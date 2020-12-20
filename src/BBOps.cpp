// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


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
  return false;
}
bool BBOps::partOfLoop(BasicBlock * BB) {
  assert(BBInfoMap.find(BB) != BBInfoMap.end());
  if(BBInfoMap.find(BB) == BBInfoMap.end()) {
    debug(Yes) << "Error: partOfLoop, BB not found\n";
    return false;
  }
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

/*
 * Need to duplicate a BB if it has multiple predecessors.
 * In case of single single predecessor, can mirror from 
 * parent even if it's not the only successor, as long as
 * it does not write to memory. Otherwise need to duplicate
 */
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
  bool singleSuccTo = BBInfoMap[from]->singleSucc != NULL;
  return !(singlePredFrom && singleSuccTo);
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

    //case to handle loop latch as predecessor
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
  printBB("merging context for ", BB, "\n", Yes);
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
  printBB("freeing BB ", BB, "\n", Yes); 
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
    debug(Yes) << "Adding bb " << BB->getName() << " to unreachable set \n";
    unReachable.insert(worker);
    markSuccessorsAsUR(worker->getTerminator(), LI);
    const vector<DomTreeNodeBase<BasicBlock> *> children = 
      DT->getNode(worker)->getChildren();
    for(unsigned i = 0; i < children.size(); i++) {
      BasicBlock * dom = children[i]->getBlock();
      worklist.push_back(dom);
    }
  }

  delete DT;
}  
/**
 * Adds a BB to readyToVist if it's reachable from at least one
 * predecessor and all its predecessors have been visited
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
 * on successors that become unreachable. Successors that become reachable
 * are added to readyToVisit vector
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
    if(BBInfoMap[successor]->URfrom < BBInfoMap[successor]->numPreds) {
      debug(Yes) << "Skipping " << successor->getName() << " as unreachable=" << BBInfoMap[successor]->URfrom << " and numPreds=" << BBInfoMap[successor]->numPreds;
      continue;
    } else{
    }
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
      single = SI->findCaseValue(CI)->getCaseSuccessor();
  }
  if(single) {
    printBB("folded to single successor ", single, "\n", Yes);
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
Value * BBOps::foldPhiNode(PHINode * phiNode, vector<Value*> &incPtrs) {
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
  if(phiNode->getType()->isPointerTy()) {
    for(unsigned i = 0; i < incV.size(); i++) {
      Value *val = phiNode->getIncomingValue(incV[i]);
      incPtrs.push_back(val);
    }
  }

  for(unsigned i = 0; i < incV.size(); i++) {
    if(val && val != phiNode->getIncomingValue(incV[i])) {
      debug(Yes) << "phiNode not constant\n";
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
void BBOps::recomputeLoopInfo(Function * F, LoopInfo& LI, BasicBlock *header) {
  for(Function::iterator bi = F->begin(), e = F->end(); bi != e; ++bi) {
    BasicBlock * BB = &*bi;
    if(BBInfoMap.find(BB) != BBInfoMap.end()) {
      BBInfoMap[BB]->partOfLoop = LI.getLoopFor(BB);
      debug(Yes) << "Part of Loop: " << BBInfoMap[BB]->partOfLoop << "\n";
    } else {
       }
  }
}

void BBOps::copyFuncBlocksInfo(Function * F, ValueToValueMapTy & vmap) {
  for(Function::iterator bi = F->begin(), e = F->end(); bi != e; ++bi) {
    BasicBlock * BB = &*bi;
    BasicBlock * clone = dyn_cast<BasicBlock>(vmap[BB]);
    if(visited.find(BB) != visited.end())
      visited.insert(clone);
    else if(unReachable.find(BB) != unReachable.end())
      unReachable.insert(clone);
    if(BBInfoMap.find(BB) != BBInfoMap.end()) {
      BBInfo * bbi = BBInfoMap[BB];
      BBInfo * nbbi = new BBInfo(clone);

      nbbi->writesToMemory = bbi->writesToMemory;
      nbbi->URfrom = bbi->URfrom;
      nbbi->numPreds = bbi->numPreds;
      nbbi->Rfrom = bbi->Rfrom;
      nbbi->partOfLoop = bbi->partOfLoop;
      nbbi->isHeader = bbi->isHeader;
      nbbi->singleSucc = bbi->singleSucc ? dyn_cast<BasicBlock>(bbi->singleSucc) : NULL;

      //copy over ancestors
      for(auto it = bbi->ancestors.begin(), end = bbi->ancestors.end(); it != end; it++) {
        if(vmap.find(*it) == vmap.end()) {
            debug(Yes) << "BB not found :" << *it << "\n";
        }else {
            nbbi->ancestors.push_back(dyn_cast<BasicBlock>(vmap[*it]));  
        }
      }

      //TODO do we need to recompute loopLatches?
      for(auto it = bbi->loopLatchesWithEdge.begin(), end = bbi->loopLatchesWithEdge.end(); it != end; it++) {
        if(vmap.find(*it) == vmap.end()) {
            debug(Yes) << "BB not found :" << *it << "\n";
        }else {
            nbbi->loopLatchesWithEdge.push_back(dyn_cast<BasicBlock>(vmap[*it]));
        }
      }

      BBInfoMap[clone] = nbbi;
    }
  }
}

void BBOps::copyContexts(Function *to, Function *from, ValueToValueMapTy& vmap, Module *module) {
  for(auto it = from->begin(), end = from->end(); it != end; it++) {
    if(!hasContext(&*it))
      continue;

    BasicBlock *oldBB = &*it;
    BasicBlock *newBB = dyn_cast<BasicBlock>(vmap[oldBB]);

    ContextInfo *oldCi = BasicBlockContexts[oldBB];
    if(!oldCi->deleted && !oldCi->imageOf) {
      printBB("duplicating in copyContexts", newBB, "\n", Yes);
      duplicateContext(newBB, oldBB);
    } else {
      printBB("creating new in copyContexts", newBB, "\n", Yes);
      BasicBlockContexts[newBB] = new ContextInfo(); //will set memory pointer later, since parent ci might not have been intiialized
    }

    ContextInfo *newCi = BasicBlockContexts[newBB];
    newCi->deleted = oldCi->deleted; 
  }

  //Now all memory has been initialized for sure
  for(auto it = from->begin(), end = from->end(); it != end; it++) {
    BasicBlock *oldBB = &*it;
    BasicBlock *newBB = dyn_cast<BasicBlock>(vmap[oldBB]);
    if(!hasContext(oldBB))
      continue;
    ContextInfo *oldCi = BasicBlockContexts[oldBB];
    ContextInfo *newCi = BasicBlockContexts[newBB];

    if(!oldCi->imageOf)
      continue;

    //TODO do this a better way
    BasicBlock *temp = NULL;
    for(auto itB = BasicBlockContexts.begin(), endB = BasicBlockContexts.end(); itB != endB; itB++) {
      if(itB->second == oldCi->imageOf) {//find BB which this is image of
        temp = itB->first;
        break;
      }
    }

    if(temp) {
      if(temp->getParent() != from) { //cross function parents
        newCi->imageOf = oldCi->imageOf; 
      }else {
        newCi->imageOf = BasicBlockContexts[dyn_cast<BasicBlock>(vmap[temp])];
        newCi->memory = BasicBlockContexts[dyn_cast<BasicBlock>(vmap[temp])]->memory;
      }
    }
  }
}

/**
 * Create new ContextInfo for a Basic Block
 */
void BBOps::createNewContext(BasicBlock * BB, Module* module) {
  assert(BasicBlockContexts.find(BB) == BasicBlockContexts.end());
  if(BasicBlockContexts.find(BB) != BasicBlockContexts.end()) {
    ContextInfo *ci = BasicBlockContexts[BB];
    delete ci->memory;
    BasicBlockContexts.erase(BB);
    delete ci;
  }
  BasicBlockContexts[BB] = new ContextInfo(module);
}

bool BBOps::isContextDeleted(BasicBlock *BB) {
  return BasicBlockContexts[BB]->deleted;
}

void BBOps::duplicateContext(BasicBlock * to, BasicBlock *from) {
  if(BasicBlockContexts.find(to) != BasicBlockContexts.end()) {
    ContextInfo *ci = BasicBlockContexts[to];
    delete ci->memory;
    BasicBlockContexts.erase(to);
    delete ci;
  }
  BasicBlockContexts[to] = BasicBlockContexts[from]->duplicate();
}

void BBOps::imageContext(BasicBlock * to, BasicBlock* from) {
  assert(BasicBlockContexts.find(to) == BasicBlockContexts.end());
  if(BasicBlockContexts.find(to) != BasicBlockContexts.end()) {
    ContextInfo *ci = BasicBlockContexts[to];
    delete ci->memory;
    BasicBlockContexts.erase(to);
    delete ci;
  }
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
    if(!checkConstMem(addr + i, 1, from))
      return false; 
  }
  return true;
}

ContextInfo *BBOps::getContextInfo(BasicBlock *bb) {
  return BasicBlockContexts[bb];
}

void BBOps::cleanUpFuncBBInfo(Function *f) {
  debug(Yes) << "called for function: " << f->getName().str() << "\n";
  for(auto f_it = f->begin(), f_ite = f->end(); f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    if(BasicBlockContexts.find(BB) == BasicBlockContexts.end())
      continue;
    printBB("deleting for BB: ", BB, " ", Yes);
    ContextInfo * ci = BasicBlockContexts[BB];
    debug(Yes) << "with ci address: " << ci << "\n";
    debug(Yes) << ci->deleted << " " << ci->imageOf << "\n";
    if(!ci->deleted && !ci->imageOf) {
      debug(Yes) << "Deleting memory too: " << "\n";
      delete ci->memory;
    }
    BasicBlockContexts.erase(BB);
    delete ci;
  }
}

void BBOps::getVisitedPreds(BasicBlock *BB, vector<BasicBlock *> &preds) {
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock *predecessor = *it;
    if(visited.find(predecessor) != visited.end()) {
      if(isnotSingleSucc(predecessor, BB))
        continue;
      preds.push_back(predecessor);
    }
  }
}

uint64_t BBOps::getConstMemSize(BasicBlock *BB) {
  return BasicBlockContexts[BB]->memory->getConstMemSize();
}

uint64_t BBOps::getSizeContigous(uint64_t address, BasicBlock *BB) {
    return BasicBlockContexts[BB]->memory->getSizeContigous(address);
}

Memory *BBOps::getMemory(BasicBlock *BB) {
  return BasicBlockContexts[BB]->memory;
}

bool BBOps::contextMatch(Memory *mem, BasicBlock *BB) {
  Memory *other = BasicBlockContexts[BB]->memory;
  if(mem->getStackIndex() != other->getStackIndex() || mem->getHeapIndex() != other->getHeapIndex())
    return false;
  uint64_t stackIndex = mem->getStackIndex();
  uint64_t heapIndex = mem->getHeapIndex();

  int8_t *stackOne = mem->getStack();
  int8_t *stackTwo = other->getStack();
  int8_t *heapOne = mem->getHeap();
  int8_t *heapTwo = other->getHeap();

  bool *stackConstOne = mem->getStackConst();
  bool *stackConstTwo = other->getStackConst();
  bool *heapConstOne = mem->getHeapConst();
  bool *heapConstTwo = other->getHeapConst();

  for(uint64_t i = 0; i < stackIndex; i++) {
    if(stackOne[i] != stackTwo[i] || stackConstOne[i] != stackConstTwo[i])
      return false;
  }

  for(uint64_t i = 0; i < heapIndex; i++) {
    if(heapOne[i] != heapTwo[i] || heapConstOne[i] != heapConstTwo[i])
      return false;
  }

  return true;
}
