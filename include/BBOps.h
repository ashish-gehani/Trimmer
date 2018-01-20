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
  bool partOfLoop(Value * val) {
    if(isa<Instruction>(val) && dyn_cast<Instruction>(val)->getParent())
      return partOfLoop(dyn_cast<Instruction>(val)->getParent());
    return true;
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
    bool singleSuccTo = BBInfoMap[from]->singleSucc;
    return !(singlePredFrom && (noMemWrite || singleSuccTo));
  }

  void addAncestor(BasicBlock * succ, BasicBlock * anc) {
    assert(BBInfoMap.find(anc) != BBInfoMap.end());
    assert(BBInfoMap.find(succ) != BBInfoMap.end());
    BBInfoMap[succ]->ancestors = BBInfoMap[anc]->ancestors;
    BBInfoMap[succ]->ancestors.push_back(anc);
  }
  
  bool visitBB(BasicBlock * BB, LoopInfo& LI) {
    
    if(isVisited(BB)) 
      return false;

    if(unReachable.find(BB) != unReachable.end())
      return false;

    initialize(BB, LI);
    
    if(!predecessorsVisited(BB, LI))
      return false;  

    return true;
  }
  bool predecessorsVisited(BasicBlock * BB, LoopInfo &LI) {
    assert(BBInfoMap.find(BB) != BBInfoMap.end());
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
    printBB("merging context for ", BB, "\n", Abubakar);
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
    for(unsigned i = 0; i < predConts.size(); i++) {
      bbc[BB]->memory->compareWith(predConts[i]->memory);
    }
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
    if(ci->cloneOf) // Todo : not efficient we should be able to delete it midway
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
    printBB("freeing BB ", BB, "\n", Abubakar); 
    delete ci->memory;
    if(ci->cloneOf)
      ci->cloneOf->deleted = true;
    else
      ci->deleted = true;  
    freePredecessors(BB, bbc);
  }
  void propagateUR(BasicBlock * BB, LoopInfo& LI) {
    Function * F = BB->getParent();
    DominatorTree * DT = new DominatorTree(*F);
    vector<BasicBlock *> worklist;
    worklist.push_back(BB);
    while(worklist.size()) {
      BasicBlock * worker = worklist[0];
      worklist.erase(worklist.begin());
      if(unReachable.find(worker) != unReachable.end()) 
        continue;
      unReachable.insert(worker);
      markSuccessorsAsUR(worker->getTerminator(), NULL, LI);
      const vector<DomTreeNodeBase<BasicBlock> *> children = 
        DT->getNode(worker)->getChildren();
      for(unsigned i = 0; i < children.size(); i++) {
        BasicBlock * dom = children[i]->getBlock();
        worklist.push_back(dom);
      }
    }
  }  
  void markSuccessorsAsUR(TerminatorInst * termInst,
   BasicBlock * except, LoopInfo& LI) {
    for(unsigned int index = 0; index < termInst->getNumSuccessors(); index++) {
      BasicBlock * successor = termInst->getSuccessor(index);
      if(successor == except)
        continue;
      initialize(successor, LI);      
      BBInfoMap[successor]->URfrom++;
      if(BBInfoMap[successor]->URfrom < BBInfoMap[successor]->numPreds)
        continue;
      propagateUR(successor, LI);
    }
  }  
  BasicBlock * foldToSingleSucc(TerminatorInst * termInst, LoopInfo& LI) {
    BasicBlock * single = NULL;
    if(BranchInst *  BI = dyn_cast<BranchInst>(termInst)) {
      if(!BI->isConditional())
        single = termInst->getSuccessor(0);
      else if(ConstantInt * CI = dyn_cast<ConstantInt>(BI->getCondition())) {
        if(CI->getZExtValue())
          single = termInst->getSuccessor(0);
        else 
          single = termInst->getSuccessor(1);
      }
    } else if(SwitchInst * SI = dyn_cast<SwitchInst>(termInst)) {
      if(ConstantInt * CI = dyn_cast<ConstantInt>(SI->getCondition()))
        single = SI->findCaseValue(CI).getCaseSuccessor();
    }
    if(single) {
      printBB("folded to single successor ", single, "\n", Abubakar);
      markSuccessorsAsUR(termInst, single, LI);
      BBInfoMap[termInst->getParent()]->singleSucc = true;
    }
    return single;
  }
  bool straightPath(BasicBlock * from, BasicBlock * to, 
  BasicBlockContInfoMap bbc) {
    if(from == to)
      return false;
    if(!findInVect(BBInfoMap[to]->ancestors, from)) {
      return false;
    }
    ContextInfo * fc = bbc[from];
    ContextInfo * tc = bbc[to];
    return tc->cloneOf && (tc->cloneOf == fc || tc->cloneOf == fc->cloneOf);
  }  
  Value * foldPhiNode(PHINode * phiNode, 
  BasicBlockContInfoMap bbc) {
    vector<unsigned> incV;
    for(unsigned i = 0; i < phiNode->getNumIncomingValues(); i++) {
      BasicBlock * BB = phiNode->getIncomingBlock(i);
      if(visited.find(BB) == visited.end())
        continue;
      incV.push_back(i);
    }
    for(unsigned i = 0; i < incV.size(); i++) {
      BasicBlock * first = phiNode->getIncomingBlock(incV[i]);
      for(unsigned j = 0; j < incV.size(); j++) {
        BasicBlock * second = phiNode->getIncomingBlock(incV[j]);
        if((first == second && j != i)
        || straightPath(second, first, bbc)) {
          incV.erase(incV.begin() + j);
          if(j < i)
            i--;
          j--;
        }
      }
    }
    Value * val = NULL; 
    for(unsigned i = 0; i < incV.size(); i++) {
      if(val && val != phiNode->getIncomingValue(incV[i])) {
        debug(Abubakar) << "phiNode not constant\n";
        return NULL;
      }
      val = phiNode->getIncomingValue(incV[i]);
    }
    return val;
  }
private:
  map<BasicBlock *, BBInfo *> BBInfoMap;
  set<BasicBlock *> visited;
  set<BasicBlock *> unReachable;
};
