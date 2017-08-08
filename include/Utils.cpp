#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Transforms/Utils/SimplifyLibCalls.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"
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
#include "mem.cpp"
#include "Types.h"

using namespace llvm;
using namespace std;

bool getConstantStringInfo(const Value *V, StringRef &Str, uint64_t Offset, bool TrimAtNul) {
   
  assert(V);
  // Look through bitcast instructions and geps.
  V = V->stripPointerCasts();

  // If the value is a GEP instruction or constant expression, treat it as an
  // offset.
  if (const GEPOperator *GEP = dyn_cast<GEPOperator>(V)) {
    // Make sure the GEP has exactly three arguments.
    if (GEP->getNumOperands() != 3)
      return false;

    // Make sure the index-ee is a pointer to array of i8.
    PointerType *PT = cast<PointerType>(GEP->getOperand(0)->getType());
    ArrayType *AT = dyn_cast<ArrayType>(PT->getElementType());
    if (!AT || !AT->getElementType()->isIntegerTy(8))
      return false;

    // Check to make sure that the first operand of the GEP is an integer and
    // has value 0 so that we are sure we're indexing into the initializer.
    const ConstantInt *FirstIdx = dyn_cast<ConstantInt>(GEP->getOperand(1));
    if (!FirstIdx || !FirstIdx->isZero())
      return false;

    // If the second index isn't a ConstantInt, then this is a variable index
    // into the array.  If this occurs, we can't say anything meaningful about
    // the string.
    uint64_t StartIdx = 0;
    if (const ConstantInt *CI = dyn_cast<ConstantInt>(GEP->getOperand(2)))
      StartIdx = CI->getZExtValue();
    else
      return false;
    return getConstantStringInfo(GEP->getOperand(0), Str, StartIdx + Offset,
				 TrimAtNul);
  }

  // The GEP instruction, constant or instruction, must reference a global
  // variable that is a constant and is initialized. The referenced constant
  // initializer is the array that we'll use for optimization.
  const GlobalVariable *GV = dyn_cast<GlobalVariable>(V);
  if (!GV || !GV->isConstant() || !GV->hasDefinitiveInitializer())
    return false;

  // Handle the all-zeros case
  if (GV->getInitializer()->isNullValue()) {
    // This is a degenerate case. The initializer is constant zero so the
    // length of the string must be zero.
    Str = "";
    return true;
  }

  // Must be a Constant Array
  const ConstantDataArray *Array =
    dyn_cast<ConstantDataArray>(GV->getInitializer());
  if (!Array || !Array->isString())
    return false;

  // Get the number of elements in the array
  uint64_t NumElts = Array->getType()->getArrayNumElements();

  // Start out with the entire array in the StringRef.
  Str = Array->getAsString();

  if (Offset > NumElts)
    return false;

  // Skip over 'offset' bytes.
  Str = Str.substr(Offset);

  if (TrimAtNul) {
    // Trim off the \0 and anything after it.  If the array is not nul
    // terminated, we just return the whole end of string.  The client may know
    // some other way that the string is length-bound.
    Str = Str.substr(0, Str.find('\0'));
  }
  return true;
}


/* This function specializes calls to library functions that take constant arguments */
bool isSpecializable(Function * calledFunction){
    
  string funcName = calledFunction->getName();
  if(funcName == "atoi")
    return true;
  else
    return false;
}   

// FIXIT: Check if function is readnone or readonly and has no sideeffects
bool hasNoSideEffects(CallInst * callInst){
  
  Function * calledFunction = callInst->getCalledFunction();
  if(callInst->onlyReadsMemory() || calledFunction->onlyReadsMemory()){
    debug(Hashim) << "NOTE: *CallInst only reads memory " << *callInst << " **\n";
    return true;    
  }

  // FIXIT: Extend this list to include all read-only functions from libc if required 
  string funcName = calledFunction->getName();
  if(funcName == "atoi" || funcName == "strdup" || funcName == "printf")
    return true;
  else
    return false;
}

bool isStringFunction(Function * calledFunction){

  if(calledFunction == NULL){
    // Indirect function call skipped
    return false;
  }

  string funcName = calledFunction->getName();
  if(funcName == "strcmp" || funcName == "strcasecmp" || funcName == "strcspn" 
     || funcName == "strspn" || funcName == "strncmp")
    return true;
  else
    return false;
}

Value * getArg(Function * func, int index){
  int i = 0;
  for(auto arg = func->arg_begin(), argEnd = func->arg_end(); arg != argEnd; arg++){
    if(i == index) 
      return &*arg;
    i++;
  }
  return NULL;	
}

// FIXIT: Allow dominated predecessors to not have executed prior to current basic block
bool predecessorsVisited(BasicBlock * BB, set<BasicBlock *> visited){
   
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
    BasicBlock * predecessor = *it;
    if(visited.find(predecessor) == visited.end()){
      debug(Hashim) << "NOTE: predecessor not visited \n";
      return false;
    }
  }

  debug(Hashim) << "NOTE: predecessors visited \n";
  return true;
}

void compareBlockContexts(ContextInfo * newCi, ContextInfo * oldCi, 
        BasicBlockContInfoMap bbc) {
  vector<BasicBlock *> diffBBs;
  for(unsigned i = 0; i < oldCi->ancestors.size(); i++) {
    if(!findInVect(newCi->ancestors, oldCi->ancestors[i]))
      diffBBs.push_back(oldCi->ancestors[i]);
  }
  for(unsigned i = 0; i < newCi->ancestors.size(); i++) {
    if(!findInVect(oldCi->ancestors, newCi->ancestors[i]))
      diffBBs.push_back(newCi->ancestors[i]);
  }
  for(unsigned j = 0; j < diffBBs.size(); j++) {
    ContextInfo * ci = bbc[diffBBs[j]];
    for(unsigned i = 0; i < ci->modifiedAllocas.size(); i++) {
      unsigned id = ci->modifiedAllocas[i];
      AggregateAlloca * aa = oldCi->idmap[id];
      AggregateAlloca * naa = newCi->idmap[id];
      naa->checkConsistencyWith(aa);
    }
  }
  for(unsigned i = 0; i < diffBBs.size(); i++)
    InsertUnique(newCi->ancestors, diffBBs[i]);
}

//TODO: Check context properly including comparing the alloca CONTENTS
//TODO: Fill the stringPointers and ScalarAllocas correctly - be sound even if imprecise 
//TODO: Insert call to merge context and test with examples
bool mergeContext(BasicBlock * BB, BasicBlock * prev, 
        BasicBlockContInfoMap bbc, ContextInfo * newCi) {
  newCi->ancestors = bbc[prev]->ancestors;
  vector<ContextInfo *> predecessorContexts;    
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
    BasicBlock * predecessor = *it;
    if(bbc.find(predecessor) == bbc.end()){
      errs() << "basic block context not found\n";
      exit(0);
    }
    if(predecessor == prev)
      continue;
    if(bbc[predecessor]->deleted)
      continue;
    predecessorContexts.push_back(bbc[predecessor]);
  }
  for(unsigned i = 0; i < predecessorContexts.size(); i++) 
    compareBlockContexts(newCi, predecessorContexts[i], bbc);
  return true;
}
/*task1*/

void markArgsAsNonConst(CallInst* callInst, ValSSAPointerMap SSAPointers,
        vector<unsigned> & modifiedAllocas) {
  int index = 0;
  Function* calledFunction = callInst->getCalledFunction();
  for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd; 
    arg++, index++) {
    // Check for constant pointers
    // All arguments in a 'readonly' function are assumed readonly     
    if(arg->onlyReadsMemory()) {
      debug(Hashim) << "!note: Argument/Function is readonly - no side effects \n";
      continue;
    }
    
    // Searching for the pointer
    Value * pointerArg = callInst->getOperand(index);
    AggregateAlloca * basePointer;
    if(SSAPointers.find(pointerArg) == SSAPointers.end()){ 
      continue;
    } 
    else
      basePointer = SSAPointers[pointerArg]->basePointer;
    // if(basePointer->isNodeTypeOf(ptrType) ||
    //   basePointer->isNodeTypeOf(scalarPtrType))
    //   basePointer->setConstantAnc(false);
    // else
    basePointer->setConstant(false);
    InsertUnique(modifiedAllocas, basePointer->getId());
    debug(Hashim) << "Note: Marking allocation as NON-CONSTANT \n";
  }
}

void handleIndirectCall(CallInst * callInst, ValSSAPointerMap & SSAPointers,
        vector<unsigned> & modifiedAllocas){

  // For any argument to the indirect call that aliases any of the allocated memory 
  // mark the side effects i.e mark allocation as non-constant
  for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
    Value * pointerArg = callInst->getArgOperand(index);
    AggregateAlloca * basePointer;
    if(SSAPointers.find(pointerArg) == SSAPointers.end()){ 
      continue;
    } 
    else
      basePointer = SSAPointers[pointerArg]->basePointer;  
    // if(basePointer->isNodeTypeOf(ptrType) ||
    //   basePointer->isNodeTypeOf(scalarPtrType))
    //   basePointer->setConstantAnc(false);
    // else
    basePointer->setConstant(false);
    InsertUnique(modifiedAllocas, basePointer->getId());
  }
}

void handleBaseDataTypeGEP(vector<unsigned> indices, SSAPointer* bsptr,
                Instruction* I, ValSSAPointerMap & SSAPointers) {
    if(indices.size() > 2) 
      errs() << "GEPINST : case not handled ntype is baseDataType and indices > 2\n";
    SSAPointer * sptr = new SSAPointer(bsptr);
    if(indices.size())
      sptr->position += indices[indices.size() - 1];
    SSAPointers[I] = sptr;
}


FuncInfo* initializeFuncInfo(Function* F) {
  FuncInfo* fi = new FuncInfo;
  fi->numCallInsts = 0;
  fi->calledInLoop = false;
  fi->AddrTaken = F->hasAddressTaken();
  fi->returnVal = NULL;
  return fi;
}

void updateMap(map<unsigned, AggregateAlloca *> & idmap, AggregateAlloca * aa) {
  vector<AggregateAlloca *> worklist;
  worklist.push_back(aa);
  while(worklist.size()) {
    AggregateAlloca * curr = worklist[0];
    idmap[curr->getId()] = curr;
    for(unsigned i = 0; i < curr->getNumContained(); i++) 
      worklist.push_back(curr->getContained(i));
    worklist.erase(worklist.begin());
  }
}
void duplicateAllocas(ContextInfo * newCi, ContextInfo * oldCi) {
  for(unsigned i = 0; i < oldCi->AggregateAllocas.size(); i++) {
    AggregateAlloca * aa = oldCi->AggregateAllocas[i];
    if(newCi->idmap.find(aa->getId()) != newCi->idmap.end())
      continue;
    AggregateAlloca * naa = aa->createClone();
    updateMap(newCi->idmap, naa);
    newCi->AggregateAllocas.push_back(naa);
  }

  for(unsigned i = 0; i < oldCi->InstOrder.size(); i++) {
    Value * I = oldCi->InstOrder[i];
    if(oldCi->SSAPointers.find(I) == oldCi->SSAPointers.end())
      continue;
    SSAPointer * sptr = oldCi->SSAPointers[I];
    AggregateAlloca * aa = newCi->idmap[sptr->basePointer->getId()];
    SSAPointer * nsptr = new SSAPointer(sptr);
    nsptr->basePointer = aa;    
    newCi->SSAPointers[I] = nsptr;
    newCi->InstOrder.push_back(I);
  }
}

void freeContextInfo(ContextInfo * ci) {
  for(auto const &ent : ci->SSAPointers) {
    SSAPointer * sptr = ent.second;
    delete sptr;
  }
  for(unsigned i = 0; i < ci->AggregateAllocas.size(); i++)
    delete ci->AggregateAllocas[i];   
}
vector<BasicBlock *> findUnvisitedProgeny(set<BasicBlock *> visited,
       BasicBlock * BB, BasicBlock * except) {
  vector<BasicBlock *> succList;
  vector<BasicBlock *> worklist;
  worklist.push_back(BB);
  while(worklist.size()) {
    BasicBlock * worker = worklist[0];
    TerminatorInst * ti = worker->getTerminator();    
    for(unsigned i = 0; i < ti->getNumSuccessors(); i++) {
      BasicBlock * succ = ti->getSuccessor(i);
      if(succ == except)
        continue;
      else if(visited.find(succ) == visited.end())
        succList.push_back(succ);
      else  
        worklist.push_back(succ);
    }
    worklist.erase(worklist.begin());
  }
  return succList;
}
void mergePredecessors(BasicBlock * BB, BasicBlockContInfoMap bbc, 
      set<BasicBlock *> visited) {
  vector<BasicBlock *> BBSuccList = findUnvisitedProgeny(visited, BB, NULL);
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;
    if(bbc[predecessor]->deleted || bbc[predecessor]->copyOrMain)
      continue;
    vector<BasicBlock *> currSuccList = findUnvisitedProgeny(visited, 
      predecessor, BB);
    bool allMutual = true;
    for(unsigned i = 0; i < currSuccList.size(); i++) {
      if(find(BBSuccList.begin(), BBSuccList.end(), currSuccList[i]) == 
        BBSuccList.end())
        allMutual = false;
    }
    if(allMutual) {
      compareBlockContexts(bbc[BB], bbc[predecessor], bbc);
      freeContextInfo(bbc[predecessor]);
      bbc[predecessor]->deleted = true;
    }
  }
}

void freePredecessors(BasicBlock * BB, BasicBlockContInfoMap bbc,
        set<BasicBlock *> visited) {
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
    BasicBlock * predecessor = *it;
    ContextInfo * ci = bbc[predecessor];
    if(ci->deleted || ci->copyOrMain)
      continue;
    // if(&predecessor->getParent()->getEntryBlock() == predecessor)
    //   continue;
    TerminatorInst * ti = predecessor->getTerminator();
    bool allVisited = true;
    for(unsigned i = 0; i < ti->getNumSuccessors(); i++) {
      if(visited.find(ti->getSuccessor(i)) == visited.end())
        allVisited = false;
    }
    if(allVisited) {
      freeContextInfo(ci);
      ci->deleted = true;
    }
  }
}

void handleReturn(Function * F, BasicBlockContInfoMap bbc) {
  for (Function::iterator f_it = F->begin(), f_ite = F->end();
       f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    delete bbc[BB];
  }
}