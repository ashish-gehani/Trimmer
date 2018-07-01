#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/LoopInfo.h"
#include "Types.h"
#include "VecUtils.h"
#include "Debug.h"
using namespace std;
using namespace llvm;

class BBOps {
public:
	BBOps() {}
  void initialize(BasicBlock * BB, LoopInfo& LI) {
    BBInfo * bbi = new BBInfo(BB);
    bbi->partOfLoop = LI.getLoopFor(BB);
    for(BasicBlock::iterator b_it = BB->begin(), b_ite = BB->end(); 
      b_it != b_ite; ++b_it) {
      if((&*b_it)->mayWriteToMemory()) 
        bbi->writesToMemory = true;
    }
    BBInfoMap[BB] = bbi; 
  }
  void addBB(BasicBlock * BB, LoopInfo& LI) {
    if(BBInfoMap.find(BB) != BBInfoMap.end())
      return;
    initialize(BB, LI); 
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
  bool isUnReachable(BasicBlock * BB) {
    return unReachable.find(BB) != unReachable.end();
  }

  // returns true if there is a single child and it is equal to succ
  bool isSingleSucc(BasicBlock * pred, BasicBlock * succ) {
    if(pred == NULL || succ == NULL) return false;
    assert(BBInfoMap.find(pred) != BBInfoMap.end());
    return BBInfoMap[pred]->singleSucc == succ;
  }

  // returns true if there is a single child and it is not equal to succ
  bool isnotSingleSucc(BasicBlock * pred, BasicBlock * succ) {
    if(pred == NULL || succ == NULL) return false;
    assert(BBInfoMap.find(pred) != BBInfoMap.end());
    return BBInfoMap[pred]->singleSucc && BBInfoMap[pred]->singleSucc != succ;
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
        if(ci->imageOf && (ci->imageOf == oci->imageOf || ci->imageOf == oci))
          continue;
        singlePredFrom = false;
      } 
    }
    bool noMemWrite = !BBInfoMap[BB]->writesToMemory; 
    bool singleSuccTo = BBInfoMap[from]->singleSucc != NULL;
    return !(singlePredFrom && (noMemWrite || singleSuccTo));
  }

  void addAncestor(BasicBlock * succ, BasicBlock * anc) {
    assert(BBInfoMap.find(anc) != BBInfoMap.end());
    assert(BBInfoMap.find(succ) != BBInfoMap.end());
    BBInfoMap[succ]->ancestors = BBInfoMap[anc]->ancestors;
    BBInfoMap[succ]->ancestors.push_back(anc);
  }
  
  bool visitBB(BasicBlock * BB, LoopInfo& LI) {
    if(isVisited(BB)) {
      return false;
    }

    if(isUnReachable(BB)) {
      return false;
    }
    addBB(BB, LI);
    BBInfoMap[BB]->Rfrom++;
    if(!predecessorsVisited(BB, LI)) {
      return false;  
    }

    return true;
  }
  bool predecessorsVisited(BasicBlock * BB, LoopInfo &LI) {
    assert(BBInfoMap.find(BB) != BBInfoMap.end());
    Loop * BBLoop = LI.getLoopFor(BB);

    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
      
      BasicBlock * predecessor = *it;
      
      if(isUnReachable(predecessor))
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

      if(isUnReachable(predecessor)) continue;

      if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
        continue;     

      assert(bbc.find(predecessor) != bbc.end() && "basic block context not found");

      if(predecessor == prev) continue;
      if(isnotSingleSucc(predecessor, BB)) continue;

      assert(!bbc[predecessor]->deleted && "predecessor context deleted");

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
      if(isUnReachable(predecessor))
        continue;
      freeBB(predecessor, bbc);
    }
  }
  void freeBB(BasicBlock * BB, BasicBlockContInfoMap bbc) {
    ContextInfo * ci = bbc[BB];
    if(ci->deleted)
      return;
    if(ci->imageOf) // Todo : not efficient we should be able to delete it midway
      return;
    TerminatorInst * ti = BB->getTerminator();
    for(unsigned i = 0; i < ti->getNumSuccessors(); i++) {
      if(isnotSingleSucc(BB, ti->getSuccessor(i))) continue;
      if(bbc.find(ti->getSuccessor(i)) == bbc.end()) return;
      if(isUnReachable(ti->getSuccessor(i))) continue;
      ContextInfo * succCi = bbc[ti->getSuccessor(i)];
      if(succCi->imageOf && 
      (succCi->imageOf == ci || succCi->imageOf == ci->imageOf))
        return;
    }
    printBB("freeing BB ", BB, "\n", Abubakar); 
    delete ci->memory;
    if(ci->imageOf)
      ci->imageOf->deleted = true;
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
      if(isUnReachable(worker)) 
        continue;
      unReachable.insert(worker);
      markSuccessorsAsUR(worker->getTerminator(), LI);
      const vector<DomTreeNodeBase<BasicBlock> *> children = 
        DT->getNode(worker)->getChildren();
      for(unsigned i = 0; i < children.size(); i++) {
        BasicBlock * dom = children[i]->getBlock();
        worklist.push_back(dom);
      }
    }
  }  
  void checkReadyToVisit(BasicBlock * BB) {
    unsigned numPreds = BBInfoMap[BB]->numPreds;
    unsigned URfrom = BBInfoMap[BB]->URfrom; 
    unsigned Rfrom = BBInfoMap[BB]->Rfrom;
    if(Rfrom && (URfrom + Rfrom == numPreds))
      InsertUnique(readyToVisit, BB);
  }
  void markSuccessorsAsUR(TerminatorInst * termInst, LoopInfo& LI) {
    for(unsigned int index = 0; index < termInst->getNumSuccessors(); index++) {
      BasicBlock * successor = termInst->getSuccessor(index);
      if(isSingleSucc(termInst->getParent(), successor)) continue;
      addBB(successor, LI);      
      BBInfoMap[successor]->URfrom++;
      checkReadyToVisit(successor);
      if(BBInfoMap[successor]->URfrom < BBInfoMap[successor]->numPreds)
        continue;
      propagateUR(successor, LI);
    }
  }  
  bool foldToSingleSucc(TerminatorInst * termInst, vector<BasicBlock *> & readyToVisit,
    LoopInfo& LI) {
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
      BBInfoMap[termInst->getParent()]->singleSucc = single;
      this->readyToVisit.clear();
      markSuccessorsAsUR(termInst, LI);
      readyToVisit = this->readyToVisit;
    }
    return single != NULL;
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
    return tc->imageOf && (tc->imageOf == fc || tc->imageOf == fc->imageOf);
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
  BasicBlock * getRfromPred(BasicBlock * BB) {
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
      
      BasicBlock * predecessor = *it;
      if(isUnReachable(predecessor)) {
        continue;
      }

      if(visited.find(predecessor) == visited.end()) continue;
      if(isnotSingleSucc(predecessor, BB)) {
        continue;
      }
      return predecessor;
    }    
    return NULL;
  }
  void recomputeLoopInfo(Function * F, LoopInfo& LI) {
    for(Function::iterator bi = F->begin(), e = F->end(); bi != e; ++bi) {
      BasicBlock * BB = &*bi;
      if(findInMap(BBInfoMap, BB))
        BBInfoMap[BB]->partOfLoop = LI.getLoopFor(BB);
    }
  }
  /* todo : how to recompute ancestors */
  void copyFuncBlocksInfo(Function * F, ValueToValueMapTy & vmap) {
    for(Function::iterator bi = F->begin(), e = F->end(); bi != e; ++bi) {
      BasicBlock * BB = &*bi;
      BasicBlock * clone = dyn_cast<BasicBlock>(vmap[BB]);
      if(findInSet(visited, BB))
        visited.insert(clone);
      else if(findInSet(visited, BB))
        unReachable.insert(clone);
      if(findInMap(BBInfoMap, BB)) {
        BBInfo * bbi = BBInfoMap[BB];
        BBInfo * nbbi = new BBInfo(clone);
        *nbbi = *bbi;
        BBInfoMap[clone] = nbbi;
      }
    }
  }
private:
  map<BasicBlock *, BBInfo *> BBInfoMap;
  set<BasicBlock *> visited;
  set<BasicBlock *> unReachable;
  vector<BasicBlock *> readyToVisit;
};
