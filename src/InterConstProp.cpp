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
#include <fstream>
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
    CallInst * to = call->specCall;
    if(call->used)
      ReplaceInstWithInst(from, to);  
    else {
      debug(Hashim) << "Delecting Instruction = " << *to << "\n";
      delete to;
    }
  }  
  specializedCalls.clear();    
} 
 
void ConstantFolding::replaceUses() {
  for(unsigned i = 0; i < toReplace.size(); i++) {
    callInstPair cp = toReplace[i];
    Instruction * oldI = cp.first;
    Instruction * newI = cp.second; 
    BasicBlock::iterator inst = BasicBlock::iterator(oldI);
    oldI->getParent()->getInstList().insert(inst, newI);
    oldI->replaceAllUsesWith(newI); 
    oldI->eraseFromParent();
  }
}

bool ConstantFolding::satisfyConds(Function* F) {
  if(FuncInfoMap.find(F) == FuncInfoMap.end())
    return false;
  if(AnnotationList.find(F) != AnnotationList.end())
    return true;

  FuncInfo* fi = FuncInfoMap[F];  

  bool addrTaken = fi->numAddrTaken;

  bool onlyOneCall = (fi->numCallInsts == 1);
  if(!F->arg_size() && !fi->usesGlobals)
    onlyOneCall = true;
  return !fi->calledInLoop && !addrTaken && onlyOneCall; 
}

Function * ConstantFolding::addClonedFunction(CallInst * callInst, Function * F) {
  Function * clonedFunc;
  ClonedCodeInfo info;
  ValueToValueMapTy vmap;
  
  string name = F->getName().str();
  debug(Hashim) << "---- cloning function = " << name <<"\n";
  clonedFunc = llvm::CloneFunction(F, vmap, true, &info);
  clonedFunc->setName(StringRef(name + "_clone")); 
  F->getParent()->getFunctionList().push_back(clonedFunc);
  std::vector<Value*> args(callInst->arg_begin(), callInst->arg_end());
  CallInst * specCallInst = CallInst::Create(clonedFunc, args);
  InsertUnique(toReplace, make_pair(callInst, specCallInst));

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
      BBInfoMap[BB] = initializeBBInfo(BB);
      LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currFunc).getLoopInfo();
      if(LI.getLoopFor(BB))
        BBInfoMap[BB]->partOfLoop = true;
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
          if(BBInfoMap[BB]->partOfLoop)
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

void ConstantFolding::initializeGlobal(AggregateAlloca * aa, Constant * CC) {
  
  if(isa<ConstantPointerNull>(CC))
    return;    

  if(isa<ConstantAggregateZero>(CC))
    return;

  if(!aa->isNodeTypeOf(scalarType) && !(aa->isNodeTypeOf(ptrType) &&
    !aa->getType()->getContainedType(0)->getNumContainedTypes())) {
    for(unsigned i = 0; i < CC->getNumOperands(); i++)
      initializeGlobal(aa->getContained(i), CC->getAggregateElement(i));
    return;
  }
  if(aa->getType()->isIntegerTy()) {
    ScalarAlloca * alloca = aa->getAlloca();
    ConstantInt * CI = dyn_cast<ConstantInt>(CC);
    alloca->storeConstVal(CI->getZExtValue(), 0);
    alloca->setInit(0, true);
  } else {
    if(ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(CC)) {
      string str = CDA->getAsString().str();
      int length = strlen(str.c_str());
      ScalarAlloca * alloca = aa->getAlloca();
      char * sourceBuffer = (char*) alloca->data;
      memcpy(sourceBuffer, str.c_str(), length);
      alloca->fillInit(0, length, true);
    } else if(aa->isNodeTypeOf(ptrType) && isa<ConstantExpr>(CC)) {
      Instruction * I = dyn_cast<ConstantExpr>(CC)->getAsInstruction();
      StringRef stringRef;
      if(getConstantStringInfo(I->getOperand(0), stringRef, 0, false)) {
        string str = stringRef.str();
        int length = strlen(str.c_str());
        Type * arType = ArrayType::get(aa->getType()->getContainedType(0), length);
        ScalarAlloca * alloca = new ScalarAlloca(arType);
        aa->setAlloca(alloca);
        alloca->setParent(aa);
        aa->Ntype = scalarPtrType;
        char * sourceBuffer = (char*) alloca->data;
        memcpy(sourceBuffer, str.c_str(), length);        
        alloca->fillInit(0, length, true);
      }      
    }
  }
}

void ConstantFolding::gatherGlobals() {
  for(auto& global : M->globals()) {
    GlobalVariable *  gv = &global;

    if(useAnnotations && AnnotationList.find(gv) ==
    AnnotationList.end())
      continue;
    // if(gv->isConstant())
    //   continue;
    Type * ty = gv->getType();
    allocate(ty->getContainedType(0), gv);
    AggregateAlloca * basePointer = BasicBlockContexts[currBB]->
      SSAPointers[gv]->basePointer;
    // basePointer->setOrInsert(0, new AggregateAlloca(ty->getContainedType(0)));
    errs() << "gatherGlobals\n";
    if(gv->hasInitializer()) 
      initializeGlobal(basePointer, gv->getInitializer());
    errs() << "initialized\n";
    unsigned id = basePointer->getId();
    GlobalIdPair gip = make_pair(gv, id);
    GlobalIdList.push_back(gip);
    markGlobalUses(dyn_cast<Value>(gv), gv);
  } 
  propagateGlobalUses();
}

void ConstantFolding::copyGlobals(ContextInfo * from, ContextInfo * to) {
  for(unsigned i = 0; i < GlobalIdList.size(); i++) {
    GlobalIdPair gip = GlobalIdList[i];
    GlobalVariable * gv = gip.first;
    unsigned id = gip.second;
    SSAPointer * gsptr = new SSAPointer(from->idmap[id]);
    to->SSAPointers[gv] = gsptr;
    InsertUnique(to->AggregateAllocas, gsptr->basePointer);
    to->InstOrder.push_back(gv);
    updateMap(to->idmap, gsptr->basePointer);
  }
}

void ConstantFolding::markGlobalsAsNonConst(ContextInfo * ci) {
  for(unsigned i = 0; i < GlobalIdList.size(); i++) {
    GlobalIdPair gip = GlobalIdList[i];
    unsigned id = gip.second;
    if(ci->idmap.find(id) != ci->idmap.end())
      ci->idmap[id]->setConstant(false);
  }
}

void ConstantFolding::addArgumentsToContext(Function * F) {
  unsigned index = 0;
  for(auto it = F->arg_begin(); it != F->arg_end(); it++, index++) {
    Value * val = getArg(F, index);
    allocate(val->getType(), val);
  }
}

void ConstantFolding::createAnnotationList() {
  GlobalVariable * annotVar = M->
  getGlobalVariable(StringRef("llvm.global.annotations"));

  assert(annotVar && "isAnnotated and annotVar not found");

  Constant * initializer = annotVar->getInitializer();
  ArrayType * aty = dyn_cast<ConstantArray>(initializer)->getType();
  unsigned num = aty->getNumElements();
  for(unsigned i = 0; i < num; i++) {
    Constant * t1 = initializer->getAggregateElement(i);
    Constant * t2 = t1->getAggregateElement((unsigned) 0);
    Instruction * I = dyn_cast<ConstantExpr>(t2)->getAsInstruction();
    Value * val = dyn_cast<User>(I)->getOperand(0);
    AnnotationList.insert(val);
    StringRef stringRef;
    getConstantStringInfo(t1->getAggregateElement((unsigned) 1), stringRef, 0, false);
    string tag = stringRef.str();
  }
}

void ConstantFolding::initWhiteList() {
}

void ConstantFolding::updateAnnotationContext(Function * F) {
  if(!useAnnotations)
    return;
  if(AnnotationList.find(F) == AnnotationList.end())
    currContextIsAnnotated = false;
  else {
    currContextIsAnnotated = true;
  }
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

unsigned ConstantFolding::getBBPredInfo(BasicBlock * BB,
                                      unsigned & predsV, 
                                      unsigned & predsUV,
                                      unsigned & predsUR) {
  unsigned num = 0;
  predsV = 0;
  predsUR = 0; 
  predsUV = 0;
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;
    if(visited.find(predecessor) != visited.end())
      predsV++;
    else if(unReachable.find(predecessor) != unReachable.end())
      predsUR++;
    else
      predsUV++;
    num++;
  }
  return num;
}
/*
conditions for not duplicating :
- there has to be only 1 predecessor from which this is reachable
either unique predecessor or not reachable from all others except from
cuz otherwise 
plus 
1) from only has one reachable successor cuz in that case changes can be written directly to
from's context; {handle modified allocas}
or 
2) it does not write to memory -in that case no harm in copying
*/
bool ConstantFolding::duplicate(BasicBlock * BB, BasicBlock * from, bool single) {
  bool singlePredFrom = (BBInfoMap[BB]->URfrom == (BBInfoMap[BB]->numPreds - 1));
  bool memWrite = !BBInfoMap[BB]->writesToMemory; 
  return !(singlePredFrom && (memWrite || single));
}

void ConstantFolding::getVisitedPreds(BasicBlock * BB,
  vector<BasicBlock *> & predsV) {
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;
    if(visited.find(predecessor) != visited.end())
      predsV.push_back(predecessor);
  }  
}

void ConstantFolding::propagateUR(BasicBlock * BB) {
  Function * F = BB->getParent();
  DominatorTree* DT = new DominatorTree(*F);
  vector<BasicBlock *> worklist;
  worklist.push_back(BB);
  while(worklist.size()) {
    BasicBlock * worker = worklist[0];
    worklist.erase(worklist.begin());
    if(unReachable.find(worker) != unReachable.end()) 
      continue;
    unReachable.insert(worker);
    markSuccessorsAsUR(worker->getTerminator(), NULL);
    const vector<DomTreeNodeBase<BasicBlock> *> children = 
      DT->getNode(worker)->getChildren();
    for(unsigned i = 0; i < children.size(); i++) {
      BasicBlock * dom = children[i]->getBlock();
      worklist.push_back(dom);
    }
  }
}

void ConstantFolding::markSuccessorsAsUR(TerminatorInst * termInst,
 BasicBlock * except) {
  for(unsigned int index = 0; index < termInst->getNumSuccessors(); index++) {
    BasicBlock * successor = termInst->getSuccessor(index);
    if(successor == except)
      continue;
    BBInfoMap[successor]->URfrom++;
    if(BBInfoMap[successor]->URfrom < BBInfoMap[successor]->numPreds)
      continue;
    propagateUR(successor);
  }
}

void ConstantFolding::freePredecessors(BasicBlock * BB) {
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
    BasicBlock * predecessor = *it;
    if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
      continue;
    if(unReachable.find(predecessor) != unReachable.end())
      continue;
    ContextInfo * ci = BasicBlockContexts[predecessor];
    freeBB(predecessor, ci);
  }
}

void ConstantFolding::freeBB(BasicBlock * BB, ContextInfo * ci) {
  if(ci->deleted || ci->useless || !ci->executed)
    return;
  TerminatorInst * ti = BB->getTerminator();
  bool allVisited = true;
  for(unsigned i = 0; i < ti->getNumSuccessors(); i++) {
    if(unReachable.find(ti->getSuccessor(i)) != unReachable.end())
      continue;
    if(visited.find(ti->getSuccessor(i)) == visited.end())
      allVisited = false;
  }
  if(allVisited) {
    freeContextInfo(ci);
    ci->deleted = true;
  }  
}

bool ConstantFolding::predecessorsVisited(BasicBlock * BB) {
  Function * F = BB->getParent();
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
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

bool ConstantFolding::mergeContext(BasicBlock * BB, BasicBlock * prev,
  ContextInfo * newCi) {
  newCi->ancestors = BasicBlockContexts[prev]->ancestors;
  vector<ContextInfo *> predecessorContexts; 
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
    BasicBlock * predecessor = *it;
    if(unReachable.find(predecessor) != unReachable.end())
      continue;

    if(findInVect(BBInfoMap[BB]->loopLatchesWithEdge, predecessor))
      continue;     

    assert(BasicBlockContexts.find(predecessor) != BasicBlockContexts.end() &&
      "basic block context not found");

    if(predecessor == prev)
      continue;

    if(BasicBlockContexts[predecessor]->deleted)
      continue;

    if(straightPath(predecessor, prev, BBInfoMap))
      continue;
    
    predecessorContexts.push_back(BasicBlockContexts[predecessor]);
  }
  for(unsigned i = 0; i < predecessorContexts.size(); i++)
    compareBlockContexts(newCi, predecessorContexts[i], BasicBlockContexts);
  return true;
}

void ConstantFolding::markArgsAsNonConst(CallInst* callInst, ContextInfo * ci) {
  Function* calledFunction = callInst->getCalledFunction();
  if(calledFunction->onlyReadsMemory())
    return;
  int index = 0;
  for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd; 
    arg++, index++) {
    if(arg->onlyReadsMemory()) {
      debug(Hashim) << "!note: Argument/Function is readonly - no side effects \n";
      continue;
    }
    Value * pointerArg = callInst->getOperand(index);
    SSAPointer * sptr = getSSAPointer(pointerArg);
    if(!sptr)
      continue;
    AggregateAlloca * basePointer = sptr->basePointer;
    basePointer->setConstant(false);
    InsertUnique(*ci->modifiedAllocas, basePointer->getId());
  }
}

void ConstantFolding::handleIndirectCall(CallInst * callInst, ContextInfo * ci) {
  Value * val = callInst->getCalledValue();
  if(Function * calledFunction = dyn_cast<Function>(val)) {
    if(calledFunction->onlyReadsMemory() ||
      whiteList.find(calledFunction) != whiteList.end())
      return;
  }
  markGlobalsAsNonConst(ci);
  for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
    Value * pointerArg = callInst->getArgOperand(index);
    SSAPointer * sptr = getSSAPointer(pointerArg);
    if(!sptr)
      continue;
    AggregateAlloca * basePointer = sptr->basePointer;
    basePointer->setConstant(false);
    InsertUnique(*ci->modifiedAllocas, basePointer->getId());
  }
}

SSAPointer * ConstantFolding::getSSAPointer(Value * val) {
  return getSSAPointer(val, BasicBlockContexts[currBB]);
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


void ConstantFolding::visitBB(BasicBlock * BB, BasicBlock * from, bool single) {
  if(visited.find(BB) != visited.end())
    return;
  BBInfoMap[from]->SuccsV.push_back(BB);
  if(!predecessorsVisited(BB))
    return;  
  ContextInfo * ci = BasicBlockContexts[currBB];
  if(!duplicate(BB, from, single)) {
    BasicBlockContexts[BB] = ci->clone();            
  } else {
    ContextInfo * nci = new ContextInfo(false);
    duplicateAllocas(nci, ci);
    mergeContext(BB, currBB, nci);
    BasicBlockContexts[BB] = nci;
  }    
  runOnBB(BB);
}

AggregateAlloca * ConstantFolding::runOnFunction(Function * toRun, Function *
    actualFunc, ContextInfo * nci) {

  bool temp = currContextIsAnnotated;
  updateAnnotationContext(actualFunc);
  BasicBlock * entry = &toRun->getEntryBlock();
  BasicBlockContexts[entry] = nci;
  runOnBB(entry);
  currContextIsAnnotated = temp;
  FuncInfoMap[toRun]->visited = true;
  
  handleReturn(toRun, BasicBlockContexts);  

  return FuncInfoMap[toRun]->returnVal;
}
void ConstantFolding::runOnBB(BasicBlock * BB) {  
  BasicBlock * temp = currBB;
  currBB = BB; 
  visited.insert(BB); 
  ContextInfo * ci = BasicBlockContexts[BB];
  ci->ancestors.push_back(BB);
  for(ci->inst = BB->begin(); ci->inst != BB->end();) {
    Instruction * I = &*ci->inst;
    BasicBlockContexts[BB]->InstOrder.push_back(I);
    errs() << *I << " " << currBB->getParent()->getName() << "\n";    
    runOnInst(I); 
  }
  ci->executed = true; 
  freePredecessors(BB); 
  freeBB(BB, ci);
  currBB = temp;
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
  } else if(PHINode * phiNode = dyn_cast<PHINode>(I)) {
    processPHINode(phiNode);
  } else if(BitCastInst * bitcastInst = dyn_cast<BitCastInst>(I)) {
    processBitCastInst(bitcastInst);
  } else if(ReturnInst * returnInst = dyn_cast<ReturnInst>(I)) {
    processReturnInst(returnInst);
  } else if(TerminatorInst * termInst = dyn_cast<TerminatorInst>(I)) {
    processTermInst(termInst);
  } else {
    tryFolding(I);
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

  initWhiteList();
  useAnnotations = isAnnotated;  
  if(useAnnotations)
    createAnnotationList();

  Function * func = M->getFunction(StringRef("main"));
  BasicBlock * entry = &(func->getEntryBlock());
  ContextInfo * ci = new ContextInfo(true);
  BasicBlockContexts[entry] = ci;
  currBB = entry;
  currContextIsAnnotated = true;

  // addArgumentsToContext(func);
  gatherFuncInfo();
  gatherGlobals(); 
  updateAnnotationContext(func);
  runOnBB(entry);   
    	   
  replaceCallOperands();
  replaceCallInsts();
  replaceUses();
  return true;
}   
  

char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);