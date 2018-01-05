#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/LoopInfo.h"
#include "Types.h"
#include "vecUtils.h"
#include "debug.h"
using namespace std;
using namespace llvm;

class BBOps {
public:
	BBOps() {

  }
  void initialize(BasicBlock * BB, LoopInfo& LI) {
    if(BBInfoMap.find(BB) != BBInfoMap.end())
      return;
    BBInfo * bbi = new BBInfo(BB);
    bbi->partOfLoop = LI.getLoopFor(BB);
    for(BasicBlock::iterator b_it = BB->begin(), b_ite = BB->end(); 
      b_it != b_ite; ++b_it) {
      if((&*b_it)->mayWriteToMemory()) 
        bbi->writesToMemory = true;
    }
    BBInfoMap[BB] = bbi; 
  }
  bool partOfLoop(BasicBlock * BB) {
    assert(BBInfoMap.find(BB) != BBInfoMap.end());
    return BBInfoMap[BB]->partOfLoop;
  }
  bool writesToMemory(BasicBlock * BB) {
    assert(BBInfoMap.find(BB) != BBInfoMap.end());
    return BBInfoMap[BB]->writesToMemory;    
  }
  void markVisited(BasicBlock * BB) {
    visited.insert(BB);
  }
  bool isVisited(BasicBlock * BB) {
    return visited.find(BB) != visited.end();
  }
  bool needToduplicate(BasicBlock * BB, BasicBlock * from,
  BasicBlockContInfoMap bbc) {
    bool singlePredFrom = true;
    ContextInfo * ci = bbc[from];
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
      BasicBlock * predecessor = *it;
      if(predecessor == from)
        continue;
      if(visited.find(predecessor) != visited.end()) {
        ContextInfo * oci = bbc[predecessor];
        if(ci->cloneOf && (ci->cloneOf == oci->cloneOf || ci->cloneOf == oci))
          continue;
        singlePredFrom = false;
      } 
    }    
    bool noMemWrite = !BBInfoMap[BB]->writesToMemory; 
    return !(singlePredFrom && noMemWrite);
  }
  bool predecessorsVisited(BasicBlock * BB, LoopInfo &LI) {
    initialize(BB, LI);
    Loop * BBLoop = LI.getLoopFor(BB);

    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
      
      BasicBlock * predecessor = *it;
      
      if(unReachable.find(predecessor) != unReachable.end())
        continue;

      if(visited.find(predecessor) == visited.end()) {
        Loop * predLoop = LI.getLoopFor(predecessor);
        if(predLoop && predLoop == BBLoop && BB == BBLoop->getHeader()) {
          BBInfoMap[BB]->isHeader = true;
          SmallVector<BasicBlock*, 16> LoopLatches;
          BBLoop->getLoopLatches(LoopLatches);
          if(findInVect(LoopLatches, predecessor)) {
            InsertUnique(BBInfoMap[BB]->loopLatchesWithEdge, predecessor);
            continue;
          }
        }
        return false;
      }
    }
    return true;
  }
  bool mergeContext(BasicBlock * BB, BasicBlock * prev,
    BasicBlockContInfoMap bbc) {
    vector<ContextInfo *> predConts; 
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
      BasicBlock * predecessor = *it;

      if(unReachable.find(predecessor) != unReachable.end())
        continue;

      if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
        continue;     

      assert(bbc.find(predecessor) != bbc.end() &&
        "basic block context not found");

      if(predecessor == prev) {
        continue;
      }

      if(bbc[predecessor]->deleted) {
        continue;
      }
      predConts.push_back(bbc[predecessor]);
    }
    for(unsigned i = 0; i < predConts.size(); i++) 
      bbc[BB]->memory->compareWith(predConts[i]->memory);
    return true;
  }  
  void freePredecessors(BasicBlock * BB, BasicBlockContInfoMap bbc) {
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
      BasicBlock * predecessor = *it;
      if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
        continue;
      if(unReachable.find(predecessor) != unReachable.end())
        continue;
      freeBB(predecessor, bbc);
    }
  }
  void freeBB(BasicBlock * BB, BasicBlockContInfoMap bbc) {
    ContextInfo * ci = bbc[BB];
    if(ci->deleted)
      return;
    if(ci->cloneOf && ci->cloneOf->deleted)
      return;
    TerminatorInst * ti = BB->getTerminator();
    for(unsigned i = 0; i < ti->getNumSuccessors(); i++) {
      if(unReachable.find(ti->getSuccessor(i)) != unReachable.end())
        continue;
      if(bbc.find(ti->getSuccessor(i)) == bbc.end())
        return;
      else {
        ContextInfo * succCi = bbc[ti->getSuccessor(i)];
        if(succCi->cloneOf && 
        (succCi->cloneOf == ci || succCi->cloneOf == ci->cloneOf))
          return;
      }
    }
    debug(Abubakar) << "freeing BB ";
    if(debugLevel == Abubakar)
      BB->printAsOperand(errs(), false);
    debug(Abubakar) << "\n";    
    delete ci->memory;
    if(ci->cloneOf)
      ci->cloneOf->deleted = true;
    else
      ci->deleted = true;  
    freePredecessors(BB, bbc);
  }  
private:
  map<BasicBlock *, BBInfo *> BBInfoMap;
  set<BasicBlock *> visited;
  set<BasicBlock *> unReachable;
};
