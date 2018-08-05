
#include <unistd.h>
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include <fcntl.h>

#include "VecUtils.h"
#include "BBOps.h"

BBInfo* BBOps::initializeBBInfo(BasicBlock * BB, LoopInfo& LI) {
  BBInfo * bbi = new BBInfo(BB);
  bbi->partOfLoop = LI.getLoopFor(BB);
  for(BasicBlock::iterator b_it = BB->begin(), b_ite = BB->end(); 
      b_it != b_ite; ++b_it) {
    if((&*b_it)->mayWriteToMemory()) 
      bbi->writesToMemory = true;
  }
  return bbi; 
}

void BBOps::addBBInfo(BasicBlock * BB, BBInfo* bbi) {
  BBInfoMap[BB] = bbi;
}  

bool BBOps::isBBInfoInitialized(BasicBlock *BB) {
  return BBInfoMap.find(BB) != BBInfoMap.end();
}

void BBOps::initAndAddBBInfo(BasicBlock * BB, LoopInfo &LI) {
  BBInfo *bbi = initializeBBInfo(BB, LI);
  addBBInfo(BB, bbi);
}

bool BBOps::partOfLoop(Value * val) {
  if(isa<Instruction>(val) && dyn_cast<Instruction>(val)->getParent())
    return partOfLoop(dyn_cast<Instruction>(val)->getParent());
  return true;
}
bool BBOps::partOfLoop(BasicBlock * BB) {
  assert(BBInfoMap.find(BB) != BBInfoMap.end());
  return BBInfoMap[BB]->partOfLoop;
}
bool BBOps::writesToMemory(BasicBlock * BB) {
  assert(BBInfoMap.find(BB) != BBInfoMap.end());
  return BBInfoMap[BB]->writesToMemory;    
}
void BBOps::markVisited(BasicBlock * BB) {
  visited.insert(BB);
}
bool BBOps::isVisited(BasicBlock * BB) {
  return visited.find(BB) != visited.end();
}
bool BBOps::isUnReachable(BasicBlock * BB) {
  return unReachable.find(BB) != unReachable.end();
}

// returns true if there is a single child and it is equal to succ
bool BBOps::isSingleSucc(BasicBlock * pred, BasicBlock * succ) {
  if(pred == NULL || succ == NULL) return false;
  assert(BBInfoMap.find(pred) != BBInfoMap.end());
  return BBInfoMap[pred]->singleSucc == succ;
}

// returns true if there is a single child and it is not equal to succ
bool BBOps::isnotSingleSucc(BasicBlock * pred, BasicBlock * succ) {
  if(pred == NULL || succ == NULL) return false;
  assert(BBInfoMap.find(pred) != BBInfoMap.end());
  return BBInfoMap[pred]->singleSucc && BBInfoMap[pred]->singleSucc != succ;
}

bool BBOps::needToduplicate(BasicBlock * BB, BasicBlock * from) {
  bool singlePredFrom = true;
  ContextInfo * ci = BasicBlockContexts[from];
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;
    if(predecessor == from)
      continue;
    if(visited.find(predecessor) != visited.end()) {
      ContextInfo * oci = BasicBlockContexts[predecessor];
      if(ci->imageOf && (ci->imageOf == oci->imageOf || ci->imageOf == oci))
        continue;
      singlePredFrom = false;
    } 
  }
  bool noMemWrite = !BBInfoMap[BB]->writesToMemory; 
  bool singleSuccTo = BBInfoMap[from]->singleSucc != NULL;
  return !(singlePredFrom && (noMemWrite || singleSuccTo));
}

void BBOps::addAncestor(BasicBlock * succ, BasicBlock * anc) {
  assert(BBInfoMap.find(anc) != BBInfoMap.end());
  assert(BBInfoMap.find(succ) != BBInfoMap.end());
  BBInfoMap[succ]->ancestors = BBInfoMap[anc]->ancestors;
  BBInfoMap[succ]->ancestors.push_back(anc);
}

bool BBOps::visitBB(BasicBlock * BB, LoopInfo& LI) {
  if(isVisited(BB)) {
    return false;
  }

  if(isUnReachable(BB)) {
    return false;
  }

  if (!isBBInfoInitialized(BB)) {
    initAndAddBBInfo(BB, LI);  
  }

  BBInfoMap[BB]->Rfrom++;
  if(!predecessorsVisited(BB, LI)) {
    return false;  
  }

  return true;
}
bool BBOps::predecessorsVisited(BasicBlock * BB, LoopInfo &LI) {
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
bool BBOps::mergeContext(BasicBlock * BB, BasicBlock * prev) {
  printBB("merging context for ", BB, "\n", Abubakar);
  vector<ContextInfo *> predConts; 
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;

    if(isUnReachable(predecessor)) continue;

    if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
      continue;     

    assert(BasicBlockContexts.find(predecessor) != BasicBlockContexts.end() && "basic block context not found");

    if(predecessor == prev) continue;
    if(isnotSingleSucc(predecessor, BB)) continue;

    assert(!BasicBlockContexts[predecessor]->deleted && "predecessor context deleted");

    predConts.push_back(BasicBlockContexts[predecessor]);
  }
  for(unsigned i = 0; i < predConts.size(); i++) {
    BasicBlockContexts[BB]->memory->compareWith(predConts[i]->memory);
  }
  return true;
}  
void BBOps::freePredecessors(BasicBlock * BB) {
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
    BasicBlock * predecessor = *it;
    if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
      continue;
    if(isUnReachable(predecessor))
      continue;
    freeBB(predecessor);
  }
}
void BBOps::freeBB(BasicBlock * BB) {
  ContextInfo * ci = BasicBlockContexts[BB];
  if(ci->deleted)
    return;
  if(ci->imageOf) // Todo : not efficient we should be able to delete it midway
    return;
  TerminatorInst * ti = BB->getTerminator();
  for(unsigned i = 0; i < ti->getNumSuccessors(); i++) {
    if(isnotSingleSucc(BB, ti->getSuccessor(i))) continue;
    if(BasicBlockContexts.find(ti->getSuccessor(i)) == BasicBlockContexts.end()) return;
    if(isUnReachable(ti->getSuccessor(i))) continue;
    ContextInfo * succCi = BasicBlockContexts[ti->getSuccessor(i)];
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
  freePredecessors(BB);
}
/**
 * Recursively marks BB and children dominated by BB 
 * as unreachable by adding them to the unReachable vector. 
 * This is done by getting the dominatorTree of the code
 */
void BBOps::propagateUR(BasicBlock * BB, LoopInfo& LI) {
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
/**
 * Adds a BB to readyToVist if it's reachable from at least one
 * predecessor
 */
void BBOps::checkReadyToVisit(BasicBlock * BB) {
  unsigned numPreds = BBInfoMap[BB]->numPreds;
  unsigned URfrom = BBInfoMap[BB]->URfrom; 
  unsigned Rfrom = BBInfoMap[BB]->Rfrom;
  if(Rfrom && (URfrom + Rfrom == numPreds))
    InsertUnique(readyToVisit, BB);
}
/**
 * Loops over successors of a terminal, and tries to call porpagateUR
 * on successors that become unreachable. Reachable successors are
 * added to readyToVisit vector
 */
void BBOps::markSuccessorsAsUR(TerminatorInst * termInst, LoopInfo& LI) {
  for(unsigned int index = 0; index < termInst->getNumSuccessors(); index++) {
    BasicBlock * successor = termInst->getSuccessor(index);
    if(isSingleSucc(termInst->getParent(), successor)) continue;

    if(!isBBInfoInitialized(successor)) {
      initAndAddBBInfo(successor, LI);
    }

    BBInfoMap[successor]->URfrom++;
    checkReadyToVisit(successor);
    if(BBInfoMap[successor]->URfrom < BBInfoMap[successor]->numPreds)
      continue;
    propagateUR(successor, LI);
  }
}  
bool BBOps::foldToSingleSucc(TerminatorInst * termInst, vector<BasicBlock *> & readyToVisit,
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
bool BBOps::straightPath(BasicBlock * from, BasicBlock * to) {
  if(from == to)
    return false;
  if(!findInVect(BBInfoMap[to]->ancestors, from)) {
    return false;
  }
  ContextInfo * fc = BasicBlockContexts[from];
  ContextInfo * tc = BasicBlockContexts[to];
  return tc->imageOf && (tc->imageOf == fc || tc->imageOf == fc->imageOf);
}  
Value * BBOps::foldPhiNode(PHINode * phiNode) {
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
          || straightPath(second, first)) {
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
BasicBlock * BBOps::getRfromPred(BasicBlock * BB) {
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
void BBOps::recomputeLoopInfo(Function * F, LoopInfo& LI) {
  for(Function::iterator bi = F->begin(), e = F->end(); bi != e; ++bi) {
    BasicBlock * BB = &*bi;
    if(findInMap(BBInfoMap, BB))
      BBInfoMap[BB]->partOfLoop = LI.getLoopFor(BB);
  }
}
/* todo : how to recompute ancestors */
void BBOps::copyFuncBlocksInfo(Function * F, ValueToValueMapTy & vmap) {
  for(Function::iterator bi = F->begin(), e = F->end(); bi != e; ++bi) {
    BasicBlock * BB = &*bi;
    BasicBlock * clone = dyn_cast<BasicBlock>(vmap[BB]);
    if(findInSet(visited, BB))
      visited.insert(clone);
    else if(findInSet(unReachable, BB))
      unReachable.insert(clone);
    if(findInMap(BBInfoMap, BB)) {
      BBInfo * bbi = BBInfoMap[BB];
      BBInfo * nbbi = new BBInfo(clone);
      *nbbi = *bbi;
      BBInfoMap[clone] = nbbi;
    }
  }
}

/**
 * Create new ContextInfo for a Basic Block
 */
void BBOps::createNewContext(BasicBlock * BB, Module* module) {
  BasicBlockContexts[BB] = new ContextInfo(module);
}

void BBOps::duplicateContext(BasicBlock * to, BasicBlock *from) {
  BasicBlockContexts[to] = BasicBlockContexts[from]->duplicate();
}

void BBOps::imageContext(BasicBlock * to, BasicBlock* from) {
  BasicBlockContexts[to] = BasicBlockContexts[from]->image();
}

Memory * BBOps::duplicateMem(BasicBlock *from) {
  return new Memory(*BasicBlockContexts[from]->memory);
}

bool BBOps::hasContext(BasicBlock * BB) {
  return BasicBlockContexts.find(BB) != BasicBlockContexts.end();
}

void BBOps::copyContext(Memory * mem, BasicBlock *from) {
  BasicBlockContexts[from]->memory->copyfrom(mem);
}

uint64_t BBOps::allocateStack(uint64_t size, BasicBlock *to) {
  return BasicBlockContexts[to]->memory->allocateStack(size);  
}

uint64_t BBOps::allocateHeap(uint64_t size, BasicBlock *to) {
  return BasicBlockContexts[to]->memory->allocateHeap(size);  
}

uint64_t BBOps::loadMem(uint64_t addr, uint64_t size, BasicBlock *from) {
  return BasicBlockContexts[from]->memory->load(size, addr); 
}

void BBOps::storeToMem(uint64_t val, uint64_t size, uint64_t addr, BasicBlock *to) {
  BasicBlockContexts[to]->memory->store(val, size, addr);  
}

void BBOps::setConstMem(bool val, uint64_t addr, uint64_t size, BasicBlock *to) {
  BasicBlockContexts[to]->memory->setConstant(val, addr, size);  
}

void BBOps::setConstContigous(bool val, uint64_t addr, BasicBlock *to) {
  BasicBlockContexts[to]->memory->setConstContigous(val, addr);
}

uint64_t BBOps::getRemainingContigousSize(uint64_t addr, BasicBlock *from) {
  return BasicBlockContexts[from]->memory->getRemainingContigousSize(addr);
}

void * BBOps::getActualAddr(uint64_t addr, BasicBlock *from) {
  return BasicBlockContexts[from]->memory->getActualAddr(addr);
}

bool BBOps::checkConstMem(uint64_t addr, uint64_t size, BasicBlock *from) {
  return BasicBlockContexts[from]->memory->checkConstant(addr, size);
}

bool BBOps::checkConstContigous(uint64_t addr, BasicBlock *from) {
  return BasicBlockContexts[from]->memory->checkConstContigous(addr);
}

bool BBOps::checkConstStr(uint64_t addr, BasicBlock *from) {
  char * mem = (char *) getActualAddr(addr, from);
  for(unsigned i = 0; mem[i] != '\0'; i++) {
    if(!checkConstMem(addr + i, 1, from))
      return false; 
  }
  return checkConstMem(addr, 1, from); // if the string starts with '\0'
}

bool BBOps::checkConstStr(uint64_t addr, uint64_t max, BasicBlock *from) {
  char * mem = (char *) getActualAddr(addr, from);
  for(unsigned i = 0; mem[i] != '\0' && i < max; i++) {
    if(!checkConstMem(i, 1, from))
      return false; 
  }
  return true;
}

ContextInfo *BBOps::getContextInfo(BasicBlock *bb) {
  return BasicBlockContexts[bb];
}

void BBOps::cleanUpFuncBBInfo(Function *f) {
  for(auto f_it = f->begin(), f_ite = f->end(); f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    if(BasicBlockContexts.find(BB) == BasicBlockContexts.end())
      continue;
    ContextInfo * ci = BasicBlockContexts[BB];
    if(!ci->deleted && !ci->imageOf)
      delete ci->memory;
    delete ci;
  }
}
