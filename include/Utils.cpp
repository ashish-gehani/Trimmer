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
bool hasNoSideEffects(CallInst * callInst) {
  
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

void handleBaseDataTypeGEP(vector<unsigned> indices, SSAPointer * bsptr,
                Instruction* I, ValSSAPointerMap & SSAPointers) {
  if(indices.size() > 2) 
    errs() << "GEPINST : case not handled ntype is baseDataType and indices > 2\n";
  SSAPointer * sptr = new SSAPointer(bsptr);
  if(indices.size())
    sptr->position += indices[indices.size() - 1];
  SSAPointers[I] = sptr;
}

void handleBaseDataTypeGEP(vector<unsigned> indices, AggregateAlloca * aa,
                Instruction* I, ValSSAPointerMap & SSAPointers) {
  if(indices.size() > 2) 
    errs() << "GEPINST : case not handled ntype is baseDataType and indices > 2\n";
  SSAPointer * sptr = new SSAPointer(aa);
  if(indices.size())
    sptr->position += indices[indices.size() - 1];
  SSAPointers[I] = sptr;
}

unsigned hasAddressTaken(Function * F) {
  unsigned num = 0;
  for (const Use &U : F->uses()) {
    const User *FU = U.getUser();
    if (isa<BlockAddress>(FU))
      continue;
    if (!isa<CallInst>(FU) && !isa<InvokeInst>(FU)) {
      num++;
      continue;
    }
    ImmutableCallSite CS(cast<Instruction>(FU));
    if (!CS.isCallee(&U))
      num++;
  }
  return num;
}

FuncInfo * initializeFuncInfo(Function * F) {
  FuncInfo * fi = new FuncInfo;
  fi->numCallInsts = 0;
  fi->calledInLoop = false;
  fi->numAddrTaken = F->hasAddressTaken();
  fi->returnVal = NULL;
  fi->visited = false;
  fi->usesGlobals = false;
  return fi;
}

BBInfo * initializeBBInfo() {
  BBInfo * bbi = new BBInfo;
  bbi->writesToMemory = false;
  bbi->partOfLoop = false;
  bbi->isHeader = false;
  return bbi;
}

FuncInfo * copyFuncInfo(FuncInfo * fi) {
  FuncInfo* nfi = new FuncInfo; 
  nfi->numCallInsts = fi->numCallInsts;
  nfi->calledInLoop = fi->calledInLoop;
  nfi->numAddrTaken = fi->numAddrTaken;
  nfi->returnVal = NULL;
  nfi->visited = fi->visited;
  nfi->usesGlobals = fi->usesGlobals;
  return fi;
}

void updateMap(map<unsigned, AggregateAlloca *> & idmap, AggregateAlloca * aa) {
  vector<AggregateAlloca *> worklist;
  worklist.push_back(aa);
  while(worklist.size()) {
    AggregateAlloca * curr = worklist[0];
    idmap[curr->getId()] = curr;
    for(unsigned i = 0; i < curr->getNumContained(); i++) {
      AggregateAlloca * naa = curr->getContained(i);
      worklist.push_back(naa);
    }
    worklist.erase(worklist.begin());
  }
}

void duplicateAllocas(ContextInfo * newCi, ContextInfo * oldCi) {
  for(unsigned i = 0; i < oldCi->AggregateAllocas.size(); i++) {
    AggregateAlloca * aa = oldCi->AggregateAllocas[i];
    if(!aa->base())
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
  set<AggregateAlloca *> deleted;
  for(unsigned i = 0; i < ci->AggregateAllocas.size(); i++) {
    AggregateAlloca * aa = ci->AggregateAllocas[i];
    vector<AggregateAlloca *> worklist;
    worklist.push_back(aa);
    while(worklist.size()) {
      AggregateAlloca * worker = worklist[0];
      if(deleted.find(worker) != deleted.end()) {
        worklist.erase(worklist.begin());
        continue;
      }
      for(unsigned i = 0; i < worker->getNumContained(); i++)
        worklist.push_back(worker->getContained(i));
      deleted.insert(worker);
      worklist.erase(worklist.begin());
      delete worker;
    } 
  }
}

void freeBB(BasicBlock * BB, ContextInfo * ci,
        set<BasicBlock *> visited) {
  if(ci->deleted || ci->useless || !ci->executed)
    return;
  TerminatorInst * ti = BB->getTerminator();
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

void handleReturn(Function * F, BasicBlockContInfoMap bbc) {
  for (Function::iterator f_it = F->begin(), f_ite = F->end();
       f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    delete bbc[BB];
  }
}

void updateBBInfo(ValueToValueMapTy & vmap, map<BasicBlock *, BBInfo *> & bbimap,
      Function * F) {
  for (Function::iterator f_it = F->begin(), f_ite = F->end();
       f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    BasicBlock * nBB = dyn_cast<BasicBlock>(vmap[BB]);
    BBInfo * bbi = bbimap[BB];
    BBInfo * nbbi = initializeBBInfo();
    nbbi->writesToMemory = bbi->writesToMemory;
    bbimap[nBB] = nbbi;
  } 
} 

void replaceConstArgs(Function * F, 
  vector<pair<unsigned, Constant *> > constArgs) {
  for(unsigned i = 0; i < constArgs.size(); i++) {
    unsigned index = constArgs[i].first;
    Constant * with = constArgs[i].second;
    getArg(F, index)->replaceAllUsesWith(with);
  }
}   

BasicBlock * foldToSingleSucc(TerminatorInst * termInst) {
  if(BranchInst *  BI = dyn_cast<BranchInst>(termInst)) {
    if(!BI->isConditional())
      return NULL;
    if(ConstantInt * CI = dyn_cast<ConstantInt>(BI->getCondition())) {
      if(CI->getZExtValue())
        return termInst->getSuccessor(0);
      else 
        return termInst->getSuccessor(1);
    }
  } else if(SwitchInst * SI = dyn_cast<SwitchInst>(termInst)) {
    if(ConstantInt * CI = dyn_cast<ConstantInt>(SI->getCondition()))
      return SI->findCaseValue(CI).getCaseSuccessor();
  }
  return NULL;
}
