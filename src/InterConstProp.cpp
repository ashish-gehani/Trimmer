/*
  Author: Hashim Sharif
  Email: hsharif3@illinois.edu
  LLVM_version: 3.8.0

TODO:
 1) Consider pointer aliasing - currenly extra conservative 
 2) Need to consider multiple arguments that may access same memory (argument aliasing)
 3) Add specialization for more libc routines e.g strdup
 4) Test on more examples - currently tested with mini_httpd
 5) FIXIT: Make this a function pass 

ASSUMPTIONS
 1) catering only i8* arrays

*/

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
#include <llvm/Analysis/LoopInfo.h>
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Support/CommandLine.h"
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
#include "../include/processInstructions.h"

using namespace llvm;
using namespace std;

static cl::opt<bool> isAnnotated("isAnnotated",
                  cl::desc("are annotations found or should the whole program be tracked"));

// Adding llvm::MemoryDependenceAnalysis as a required PrePass                                                         
void ConstantFolding::getAnalysisUsage(AnalysisUsage &AU) const { 
  //AU.addRequired<MemoryDependenceAnalysis>();
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addRequired<TargetLibraryInfoWrapperPass>();
  AU.addRequired<CallGraphWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
}

  
void ConstantFolding::replaceCallOperands(){

  for (auto & e : replaceOperands){
    debug(Hashim) << "NOTE: ***** callInst = " << *e.first << "\n";
    vector<CallOperand*> operands = e.second;
    for(unsigned int i = 0; i < operands.size(); i++){
      CallOperand * callInfo = operands[i];
      debug(Hashim) << "* new Operand = " << *callInfo->newOperand << "\n";
      e.first->setOperand(callInfo->index, callInfo->newOperand);
    }
  }  
  replaceOperands.clear();    
}
 

// TODO: Make sure cloned functions calling other specialized routines are correctly retained
void ConstantFolding::replaceCallInsts(){
  for (auto & e : specializedCalls){
    SpecializedCall * call = e.second;
    CallInst * from = call->origCall;
    debug(Hashim) << "from = " << *from << "\n";
    CallInst * to = call->specCall;
    if(call->used){   
      debug(Hashim) << "Replacing " << *from << " with " << *to << "\n";
      ReplaceInstWithInst(from, to);  
    }
    else{
      debug(Hashim) << "Delecting Instruction = " << *to << "\n";
      delete to;
    }
  }  
  specializedCalls.clear();    
} 

bool ConstantFolding::satisfyConds(Function* F) {

  if(FuncInfoMap.find(F) == FuncInfoMap.end())
    return false;

  FuncInfo* fi = FuncInfoMap[F];  

  bool addrTaken = fi->numAddrTaken;
  if(AnnotationList.find(F) != AnnotationList.end())
    addrTaken = (fi->numAddrTaken > 2);

  bool onlyOneCall = (fi->numCallInsts == 1);
  if(!F->arg_size() && !fi->usesGlobals)
    onlyOneCall = true;

  return !fi->calledInLoop && !addrTaken && onlyOneCall; 
}

Function * ConstantFolding::addClonedFunction(CallInst * ci, Function * F) {
  Function * clonedFunc;
  ClonedCodeInfo info;
  ValueToValueMapTy vmap;
  
  string name = F->getName().str();
  debug(Hashim) << "---- cloning function = " << name <<"\n";
  clonedFunc = llvm::CloneFunction(F, vmap, true, &info);
  clonedFunc->setName(StringRef(name + "_clone")); 
  F->getParent()->getFunctionList().push_back(clonedFunc);
              
  std::vector<Value*> args(ci->arg_begin(), ci->arg_end());
  CallInst * specCallInst = CallInst::Create(clonedFunc, args);
  debug(Hashim) << "newCallSite = " << *specCallInst << "\n";
  SpecializedCall * call = new SpecializedCall;
  call->origCall = ci;
  call->specCall = specCallInst;
  call->used = false;
  specializedCalls[clonedFunc] = call; // FIXIT: Re-consider current indexing on cloned function
  
  updateBBInfo(vmap, BBInfoMap, F);    
  FuncInfoMap[clonedFunc] = copyFuncInfo(FuncInfoMap[F]);  
  
  return clonedFunc;
}

void ConstantFolding::gatherFuncInfo() {
  for (Module::iterator mit = M->getFunctionList().begin(); 
      mit != M->getFunctionList().end(); ++mit) {
    Function * currFunc = &*mit;
    if(FuncInfoMap.find(currFunc) == FuncInfoMap.end())
      FuncInfoMap[currFunc] = initializeFuncInfo(currFunc);
    for (Function::iterator f_it = mit->begin(), f_ite = mit->end(); 
      f_it != f_ite; ++f_it) {
      BasicBlock * BB = &*f_it;
      BBInfoMap[BB] = initializeBBInfo();
      LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currFunc).getLoopInfo();
      for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); 
        b_it != b_ite; ++b_it) {
        Instruction* I = &*b_it;
        if(I->mayWriteToMemory()) 
          BBInfoMap[BB]->writesToMemory = true;
        if(CallInst* ci = dyn_cast<CallInst>(I)) {
          Function* F = ci->getCalledFunction();
          if(!F)
            continue;
          InsertUnique(FuncInfoMap[currFunc]->calledFunctions, F);
          if(!FuncInfoMap[F])
            FuncInfoMap[F] = initializeFuncInfo(F);
          if(LI.getLoopFor(BB))
            FuncInfoMap[F]->calledInLoop = true;
          FuncInfoMap[F]->numCallInsts++;
        }
      }
    }
  }
}

void ConstantFolding::markGlobalUses(Value * val, GlobalVariable * gv) {
  for (auto& U : val->uses()) {
    User* user = U.getUser();  
    if(isa<ConstantExpr>(user))
      markGlobalUses(dyn_cast<Value>(user), gv);
    else if(Instruction * I = dyn_cast<Instruction>(user)) {
      if(!I->getParent())
        continue;
      FuncInfoMap[I->getFunction()]->usesGlobals = true; 
    }
  }
}

void ConstantFolding::propagateGlobalUses() {
  bool changed;
  do {
    changed = false;
    for (Module::iterator mit = M->getFunctionList().begin(); 
      mit != M->getFunctionList().end(); ++mit) {
      Function * F = &*mit;
      if(FuncInfoMap[F]->usesGlobals)
        continue;
      for(unsigned i = 0; i < FuncInfoMap[F]->calledFunctions.size(); i++) {
        Function * called = FuncInfoMap[F]->calledFunctions[i];
        if(FuncInfoMap[called]->usesGlobals) {
          FuncInfoMap[F]->usesGlobals = true;
          changed = true;
        }
      } 
    }
  } while(changed);
}

void ConstantFolding::initializeGlobal(GlobalVariable * gv) {
  if(!gv->hasInitializer())
    return;
  ContextInfo * ci = BasicBlockContexts[currBB];
  Type * ty = gv->getType()->getContainedType(0);  
  AggregateAlloca * aa = getSSAPointer(gv, ci)->basePointer;
  Constant * initializer = gv->getInitializer();
  if(isa<ConstantPointerNull>(initializer))
    return;    
  if(isa<ConstantAggregateZero>(initializer))
    return;

  if(ty->getNumContainedTypes()) {
    aa->setConstant(false);
    return;
  }

  ScalarAlloca * alloca = aa->getAlloca();
  alloca->storeConstVal(dyn_cast<ConstantInt>(initializer)->getZExtValue(), 0);
}

void ConstantFolding::gatherGlobals() {
  for(auto& global : M->globals()) {
    GlobalVariable *  gv = &global;
    if(gv->isConstant())
      continue;
    allocate(gv->getType()->getContainedType(0), gv);
    initializeGlobal(gv);
    unsigned id = BasicBlockContexts[currBB]->SSAPointers[gv]->
      basePointer->getId();
    GlobalIdPair gip = make_pair(gv, id);
    GlobalIdList.push_back(gip);
    markGlobalUses(dyn_cast<Value>(gv), gv);
  } 
  propagateGlobalUses();
}

void ConstantFolding::createAnnotationList() {
  GlobalVariable * annotVar = M->
  getGlobalVariable(StringRef("llvm.global.annotations"));
  if(!annotVar) {
    // errs() << "annotVar not found\n";
    return;
  }
  Constant * initializer = annotVar->getInitializer();
  ArrayType * aty = dyn_cast<ConstantArray>(initializer)->getType();
  unsigned num = aty->getNumElements();
  for(unsigned i = 0; i < num; i++) {
    Constant * t1 = initializer->getAggregateElement(i);
    Constant * t2 = t1->getAggregateElement((unsigned) 0);
    Instruction * I = dyn_cast<ConstantExpr>(t2)->getAsInstruction();
    Value * val = dyn_cast<User>(I)->getOperand(0);
    AnnotationList.insert(val);
  }
}

void ConstantFolding::updateAnnotationContext(Function * F) {
  if(!useAnnotations)
    return;
  if(AnnotationList.find(F) == AnnotationList.end())
    currContextIsAnnotated = false;
  else 
    currContextIsAnnotated = true;
}

bool ConstantFolding::trackAllocas() {
  if(useAnnotations && !currContextIsAnnotated)
    return false;
  return true;
}

void ConstantFolding::allocate(Type * ty, Value * val) {
  
  if(!trackAllocas())
    return;

  ContextInfo * ci = BasicBlockContexts[currBB];  
  SSAPointer * sptr = new SSAPointer(ty);
  ci->SSAPointers[val] = sptr;
  InsertUnique(ci->AggregateAllocas, sptr->basePointer);
  ci->InstOrder.push_back(val);
  updateMap(ci->idmap, sptr->basePointer);
  AggregateAllocaToVal[sptr->basePointer->getId()] = val;
}

void ConstantFolding::allocate(AggregateAlloca * aa, Value * val) {
  
  if(!trackAllocas())
    return;

  ContextInfo * ci = BasicBlockContexts[currBB];  
  SSAPointer * sptr = new SSAPointer(aa);
  ci->SSAPointers[val] = sptr;
  InsertUnique(ci->AggregateAllocas, sptr->basePointer);
  ci->InstOrder.push_back(val);
  updateMap(ci->idmap, sptr->basePointer);
  AggregateAllocaToVal[sptr->basePointer->getId()] = val;
}

void ConstantFolding::allocate(SSAPointer * sptr, Value * val) {
  
  if(!trackAllocas())
    return;

  ContextInfo * ci = BasicBlockContexts[currBB];  
  ci->SSAPointers[val] = sptr;
  InsertUnique(ci->AggregateAllocas, sptr->basePointer);
  ci->InstOrder.push_back(val);
  updateMap(ci->idmap, sptr->basePointer);
  AggregateAllocaToVal[sptr->basePointer->getId()] = val;  
}

//Assumption a basic block can have predecessors only from the same function
bool ConstantFolding::predecessorsVisited(BasicBlock * BB) {
  Function * F = BB->getParent();
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
  vector<BasicBlock *> notVisited;
  Loop * BBLoop = LI.getLoopFor(BB);
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;
    if(visited.find(predecessor) == visited.end()) {
      Loop * predLoop = LI.getLoopFor(predecessor);
      if(predLoop && predLoop == BBLoop && BB == BBLoop->getHeader()) {
        BBInfoMap[BB]->isHeader = true;
        SmallVector<BasicBlock*, 16> LoopLatches;
        BBLoop->getLoopLatches(LoopLatches);
        bool found = false;
        for(unsigned i = 0; i < LoopLatches.size(); i++) {
          if(LoopLatches[i] == predecessor)
            found = true;
        }
        if(found) {
          InsertUnique(BBInfoMap[BB]->loopLatchesWithEdge, predecessor);
          continue;
        }
      }
      return false;
    }
  }
  return true;
}

bool ConstantFolding::mergeContext(BasicBlock * BB, BasicBlock * prev,
  ContextInfo * newCi) {
  newCi->ancestors = BasicBlockContexts[prev]->ancestors;
  vector<ContextInfo *> predecessorContexts; 
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;

    if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
      continue;        

    if(BasicBlockContexts.find(predecessor) == BasicBlockContexts.end()) {
      errs() << "basic block context not found\n";
      exit(0);
    }
    if(predecessor == prev)
      continue;
    if(BasicBlockContexts[predecessor]->deleted || 
      BasicBlockContexts[predecessor]->copyOrMain)
      continue;
    predecessorContexts.push_back(BasicBlockContexts[predecessor]);
  }
  for(unsigned i = 0; i < predecessorContexts.size(); i++)
    compareBlockContexts(newCi, predecessorContexts[i], BasicBlockContexts);
  return true;
}

SSAPointer * ConstantFolding::getSSAPointer(Value * val, ContextInfo * ci) {
  if(ci->SSAPointers.find(val) != ci->SSAPointers.end())
    return ci->SSAPointers[val];
  if(ConstantExpr * ce = dyn_cast<ConstantExpr>(val)) {
    if(Instruction * I = ce->getAsInstruction()) {
      if(ci->SSAPointers.find(I) != ci->SSAPointers.end())
        return ci->SSAPointers[I]; 
      BasicBlock::iterator inst = ci->inst;
      runOnInst(I);
      ci->inst = inst;
      if(ci->SSAPointers.find(I) != ci->SSAPointers.end())
        return ci->SSAPointers[I];      
    }
  }
  return NULL;
}

void ConstantFolding::runOnBB() {   
  visited.insert(currBB); 
  ContextInfo * ci = BasicBlockContexts[currBB];
  ci->ancestors.push_back(currBB);
  for (ci->inst = currBB->begin(); ci->inst != currBB->end();) {
    Instruction * I = &(*ci->inst);
    BasicBlockContexts[currBB]->InstOrder.push_back(I);
    // errs() << *I << "\n";   
    runOnInst(I);
  }
  ci->executed = true; 
  freeBB(currBB, ci, visited);
} 

void ConstantFolding::runOnInst(Instruction * I) {
  bool call = false;
  if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(I)) {
    processAllocaInst(allocaInst);  
  } else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(I)) {
    processMemcpyInst(memcpyInst);
  } else if(StoreInst * storeInst = dyn_cast<StoreInst>(I)) {
    processStoreInst(storeInst);
  } else if(LoadInst * loadInst = dyn_cast<LoadInst>(I)) {
    processLoadInst(loadInst);
  } else if(CallInst * callInst = dyn_cast<CallInst>(I)) {
    call = true;
    processCallInst(callInst);
  } else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(I)) {
    processGEPInst(GEPInst);
  } else if(BranchInst * branchInst = dyn_cast<BranchInst>(I)) {
    processBranchInst(branchInst);
  } else if(SwitchInst * switchInst = dyn_cast<SwitchInst>(I)) {
    processSwitchInst(switchInst);
  } else if(BitCastInst * bitcastInst = dyn_cast<BitCastInst>(I)) {
    processBitCastInst(bitcastInst);
  } else if(ReturnInst * returnInst = dyn_cast<ReturnInst>(I)) {
    processReturnInst(returnInst);
  }
  if(!call)
    BasicBlockContexts[currBB]->inst++;
}

bool ConstantFolding::runOnModule(Module & module) {

  debug(Abubakar) << "\n\n*******---- InterConstProp -----*********\n\n";

  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  DL = new DataLayout(&module);   
  CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();
  M = &module;
  useAnnotations = isAnnotated;

  if(useAnnotations)
    createAnnotationList();

  Function * func = M->getFunction(StringRef("main"));
  BasicBlock * entry = &(func->getEntryBlock());
  ContextInfo * ci = new ContextInfo(true);
  BasicBlockContexts[entry] = ci;
  currBB = entry;
  currContextIsAnnotated = true;
  gatherFuncInfo();
  gatherGlobals(); 
  updateAnnotationContext(func);
  runOnBB();   
    	   
  replaceCallOperands();
  replaceCallInsts();
  
  return true;
}   
  

char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);