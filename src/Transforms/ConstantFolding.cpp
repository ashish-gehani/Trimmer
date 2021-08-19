// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*This pass goes through the instructions in the bitcode file, folding and propagating constants, cloning functions, unrolling loops, 
specializing file I/O and strings.*/

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"
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
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Transforms/Utils.h"



#include <malloc.h>
#include <unistd.h>
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <assert.h>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include <fcntl.h>
#include <algorithm>
#include <sys/mman.h>
#include <sys/types.h>
#include <pwd.h>
#include <ctype.h>
#include <chrono>
#include <fstream>

#include "ConstantFolding.h"
#include "Utils.h"
#include "StringUtils.h"
#include "FdInfo.h"
#include "FileInsts.h"
#include "MMapInfo.h"


using namespace llvm;
using namespace std;




static cl::list<std::string> fileNames("fileNames",cl::ZeroOrMore, cl::desc("config filenames to specialize for"),cl::CommaSeparated);

static cl::opt<bool> isAnnotated("isAnnotated",
    cl::desc("are annotations found or should the whole program be tracked"));
static cl::opt<bool> trackAlloc("trackAllocas",cl::init(false),
    cl::desc("are allocas tracked"));
static cl::opt<std::string> progName("__progName", cl::init(""));

static cl::opt<int> contextType("contextType", cl::init(1));
static cl::opt<int> fileSpecialize("fileSpecialize", cl::init(1));
static cl::opt<int> stringSpecialize("stringSpecialize", cl::init(1));
static cl::opt<int> loopUnroll("loopUnroll", cl::init(1));

static cl::opt<int> useGlob("useGlob",
        cl::desc("are the globals mod-ref to be used in choosing function specialisation"),cl::init(0));
static cl::opt<int> exceedLimit("exceedLimit",
        cl::desc("heuristic to limit function cloning to a limitted number"),cl::init(0));
static cl::opt<int> disableExit("disableExit",
        cl::desc("disable exiting on fork/pthread function"),cl::init(0));
static cl::opt<int> useRegOffset("useRegOffset",
        cl::desc("using trimmer's stored registers for offset (in addition to scalarevolution) in GEPs"),cl::init(0));





unsigned trackedLoads = 0;
unsigned fSkipped = 0;

void ConstantFolding::getAnalysisUsage(AnalysisUsage &AU) const { 
  AU.addRequired<TargetLibraryInfoWrapperPass>();
  AU.addRequired<CallGraphWrapperPass>();
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
  AU.addPreserved<LoopInfoWrapperPass>();
  AU.addRequiredID(LoopSimplifyID);
  AU.addPreservedID(LoopSimplifyID);
  AU.addRequiredID(LCSSAID);
  AU.addPreservedID(LCSSAID);
  AU.addRequired<ScalarEvolutionWrapperPass>();
  // AU.addPreserved<ScalarEvolutionWrapperPass>();
  AU.addRequired<TargetTransformInfoWrapperPass>();
  // FIXME: Loop unroll requires LCSSA. And LCSSA requires dom info.
  // If loop unroll does not preserve dom info then LCSSA pass on next
  // loop will receive invalid dom info.
  // For now, recreate dom info, if loop is unrolled.
  AU.addPreserved<DominatorTreeWrapperPass>();

}

void ConstantFolding::markInstMemNonConst(Instruction  *I) {
  for(unsigned i = 0; i < I->getNumOperands(); i++) {
    Value *val = I->getOperand(i);
    Register *reg = processInstAndGetRegister(val);
    PointerType *pty = dyn_cast<PointerType>(val->getType());

    if(pty && pty->getElementType()->isFunctionTy()){
      //do not mark function pointee non constant since it points to actual llvm function
      debug(Yes) << "markInstMemNonConst: skipping function\n";
      continue;
    }

    if(reg && pty && !dyn_cast<CallInst>(val)) {
      markMemNonConst(dyn_cast<PointerType>(val->getType())->getElementType(), reg->getValue(), currBB);
    }
  }

  if(auto callInst = dyn_cast<CallInst>(I)) {
    markArgsAsNonConst(callInst);
    if(callInst->getCalledFunction() && !callInst->getCalledFunction()->isDeclaration())
      markGlobAsNonConst(callInst->getCalledFunction());
    return;
  }
}

/**
 * Process a single instruction. 
 Handles instructions according to Instruction Type, e.g., AllocaInst, StoreInst, LoadInst
 */
void ConstantFolding::runOnInst(Instruction * I) {
  ProcResult result;
  printInst(I, Yes);

  if(bbOps.partOfLoop(I)) {
    debug(Yes)<<"runOnInst: bbOps.partOfLoop("<<*I<<"): true\n";
    markInstMemNonConst(I); 

    if(auto CI = dyn_cast<CallInst>(I)) {
      if(CI->getCalledFunction() && (CI->getCalledFunction()->getName() == "fork" || CI->getCalledFunction()->getName().substr(0, 7) == "pthread")) {
        debug(Yes) <<"XXX fork or pthread invoked ...\n";
        if (!disableExit){
            exit = 1;
        }
        return;
      }
    }

    if(!isa<TerminatorInst>(I)) { //need terminator instruction to make BB graphs
      return;
    }
  }

  if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(I)) {
    result = processAllocaInst(allocaInst); 
  } else if(BitCastInst * bitCastInst = dyn_cast<BitCastInst>(I)) {
    result = processBitCastInst(bitCastInst);
  } else if(StoreInst * storeInst = dyn_cast<StoreInst>(I)) {
    result = processStoreInst(storeInst);
  } else if(LoadInst * loadInst = dyn_cast<LoadInst>(I)) {
    result = processLoadInst(loadInst);
  } else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(I)) {
    result = processGEPInst(GEPInst);
  } else if(PHINode * phiNode = dyn_cast<PHINode>(I)) {
    result = processPHINode(phiNode);
  } else if(ReturnInst * retInst = dyn_cast<ReturnInst>(I)){ 
    result = processReturnInst(retInst);
  } else if(TerminatorInst * termInst = dyn_cast<TerminatorInst>(I)) {
    result = processTermInst(termInst);
  } else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(I)) {
    result = processMemcpyInst(dyn_cast<CallInst>(memcpyInst));
  } else if(MemMoveInst *memmoveInst = dyn_cast<MemMoveInst>(I)) {
    result = processMemMoveInst(dyn_cast<CallInst>(I));
  } else if(MemSetInst * memsetInst = dyn_cast<MemSetInst>(I)) {
    result = processMemSetInst(dyn_cast<CallInst>(memsetInst));
  } else if(CallInst * callInst = dyn_cast<CallInst>(I)) {
    result = processCallInst(callInst);
  } else if(PtrToIntInst * ptrinst = dyn_cast<PtrToIntInst>(I)){
    result = processPtrToIntInst(ptrinst);
  } else if(ExtractValueInst *ev = dyn_cast<ExtractValueInst>(I)) {
    result = handleExtractValue(ev);
    //else if(PtrToIntInst *ptr = dyn_cast<PtrToIntInst>(I)) {
    //result = processPtrToInt(ptr);  }
  } else if(IntToPtrInst *inst = dyn_cast<IntToPtrInst>(I)) {
    result = processIntToPtr(inst);  
  } else {
    result = tryfolding(I);
  }

}

ProcResult ConstantFolding::processIntToPtr(IntToPtrInst *inst) {
  Value *val = inst->getOperand(0);
  ConstantInt *cInt = dyn_cast<ConstantInt>(val);
  Register *reg = processInstAndGetRegister(val);
  uint64_t value;
  if(!reg && !cInt) {
    debug(Yes) << "inttoptr: register not found\n";
    return NOTFOLDED;
  }

  if(cInt)
    value = cInt->getZExtValue();
  else
    value = reg->getValue();

  addSingleVal(inst, (uint64_t) value, false, true);
  stats.incrementInstructionsFolded();
  return FOLDED;
}
/*
   Run analysis on each Instruction of basic block BB
   */
bool ConstantFolding::runOnBB(BasicBlock * BB) {
  bbOps.markVisited(BB);
  currBB = BB;
  ContextInfo * ci = bbOps.getContextInfo(currBB);
  for(ci->inst = BB->begin(); ci->inst != BB->end();) {
    if(exit)
      return false;

    Instruction * I = &*(ci->inst++);

    if(isLoopTest()) {
      uint64_t seconds;
      stats.getLoopTime(seconds);
      debug(Yes) << "checking loop test. time elapsed = " << seconds << "\n";
      LoopUnroller *unroller = testStack.back();
      unroller->checkTermInst(I, seconds);
      if (unroller->testTerminated()){ // test terminated in the  term condition above
        debug(Yes)<<"Returning true in runOnBB\n";
        return true;
      }
    }
    runOnInst(I);
  }  
  bbOps.freeBB(BB);
  debug(Yes)<<"Returning false in runOnBB\n";
  return false;
}

void ConstantFolding::copyFuncIntoClone(Function *cloned, ValueToValueMapTy &vmap, Function *current, vector<ValSet> &funcValStack) {

  bbOps.copyFuncBlocksInfo(current, vmap); //copy over old function bbinfo into cloned function
    
  bbOps.copyContexts(cloned, current, vmap, module);

  assert(funcValStack.size() >= 2);
  ValSet oldValSet = funcValStack[funcValStack.size() - 2];
  cloneFuncStackAndRegisters(vmap, oldValSet); //copy over stack and registers
}

/*
 * Whether running a loop unroll test
 */
bool ConstantFolding::isLoopTest() {
  return testStack.size();
}
/*
   Run on callee Function(or main at analysis start)
   The context used for the entry basic block will be the same as the currBB
   at the point of function call.
   After completing execution of the function, the context before the function call
   will be replaced by the context at the return Instruction of the callee
   */
//BasicBlock* previousBB;
std::vector<BasicBlock *> callStack;
void ConstantFolding::runOnFunction(CallInst * ci, Function * toRun) {
  debug(Yes)<<"runOnFunction: "<<toRun->getName()<<"\n";

  if(exit)
    return;
  if(!ci) assert(toRun->getName().str() == "main" && "callInst not given");

  stats.functionCall(toRun);

  push_back(funcValStack);
  bool tempAnnot = currContextIsAnnotated;

  if(ci) {
    // if func call
    propagateArgs(ci, toRun);
    copyCallerContext(ci, toRun); //copy context
  }

  if(!isFuncInfoInitialized(toRun)) {
    FuncInfo *fi = initializeFuncInfo(toRun);
    addFuncInfo(toRun, fi);
  }

  callStack.push_back(currBB);

  Function * temp = currfn;
  BasicBlock *tempBB  = currBB; //preserve across recursion of this function
  currfn = toRun; //update to callee
  //BasicBlock* oldPrevious = previousBB;
  //previousBB = currBB;

  BasicBlock * entry = &toRun->getEntryBlock();

  push_back(worklistBB);
  addToWorklistBB(entry);

  while(worklistBB[worklistBB.size() - 1].size()) {
    //debug(Yes)<<"# WorkList: "<<currfn->getName()<<"\n";

    if(exit)
      return;

    LoopInfo *LI= &getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo(); //TODO should not recalculate on each iteration
    debug(Yes)<<"LoopInfo NULL?: "<<(LI==NULL)<<"\n";
    int size = worklistBB.size() - 1;
    BasicBlock *current = worklistBB[size].back();
    worklistBB[size].pop_back();
    Loop *L = NULL;

    assert(current->getParent() == currfn);
    if((L = isLoopHeader(current, *LI)) && loopUnroll && LoopUnroller::shouldSimplifyLoop(current, *LI, module, useAnnotations && contextType == 1)) {
      ValueToValueMapTy vmap;
      
      if(auto *unroller= unrollLoopInClone(currfn, L, vmap, funcValStack)) {
        addToWorklistBB(current); 
        Function *cloned = dyn_cast<BasicBlock>(vmap[current])->getParent();

        stats.swapFunction(currfn, cloned);
        stats.loopStart(dyn_cast<BasicBlock>(vmap[current]));

        testStack.push_back(unroller);
        push_back(worklistBB);

        currfn = cloned;
        copyWorklistBB(vmap, worklistBB);
        LI = unroller->getLoopInfo();


        for (map<uint64_t,FileInsts*>::iterator it=fileIOCalls.begin(); it!=fileIOCalls.end(); ++it){
          int sizeOfInsertedSeekCalls = (it->second)->insertedSeekCalls.size();
          for(int i = 0;i<sizeOfInsertedSeekCalls;i++) { 
            if(vmap[(it->second)->insertedSeekCalls[i]]){
              (it->second)->insertedSeekCalls.push_back(dyn_cast<Instruction>(vmap[(it->second)->insertedSeekCalls[i]]));  
            }
          } 
          int sizeOfFileIOCalls = (it->second)->insts.size();
          for(int i = 0;i< sizeOfFileIOCalls;i++){
            if(vmap[(it->second)->insts[i]]){
              (it->second)->insts.push_back(dyn_cast<Instruction>(vmap[(it->second)->insts[i]]));  
            }
          }
        }  

        continue;
      } 
    }

    if(runOnBB(current)) { //loop test terminated
      LoopUnroller *unroller = pop_back(testStack);
      if(!unroller->checkPassed()) {
        debug(Yes) << " test not terminated\n";
        BasicBlock *failedLoop;
        bbOps.cleanUpFuncBBInfo(currfn); //remove cloned BBinfo
        regOps.cleanUpFuncBBRegisters(currfn, popFuncValStack()); //remove cloned registers and stack
        pop_back(worklistBB);

        failedLoop = worklistBB[worklistBB.size() -1].back();
        worklistBB[worklistBB.size() - 1].pop_back();

        stats.loopFail();
        stats.swapFunction(currfn, unroller->getCloneOf());
        currfn = unroller->getCloneOf();
        toRun = currfn;

        LI = &getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
        //TODO hackish way of running on old failed loopHeader
        LoopUnroller::deleteLoop(failedLoop);
        runOnBB(failedLoop);
      }else {
        //replace old function with new one
        stats.loopSuccess();
        Function *oldFn = unroller->getCloneOf();
        addToWorklistBB(current);
        debug(Yes) << "marking test at level " << testStack.size() << " as terminated\n";

        worklistBB[worklistBB.size() -2].clear();
        auto clonedFnWorklist =  worklistBB.back();
        pop_back(worklistBB);
        for(auto it = clonedFnWorklist.begin(), end = clonedFnWorklist.end() ;it != end; it++)
          addToWorklistBB(*it); 

        debug(Yes)<<"Unroller checkPassed returned TRUE, cleaning up oldFunction with name "<<oldFn->getName()<<"\n";

        regOps.cleanUpFuncBBRegisters(oldFn, funcValStack[funcValStack.size() - 2]);
        bbOps.cleanUpFuncBBInfo(oldFn);

        funcValStack[funcValStack.size() - 2].clear();
        auto clonedFnValues = funcValStack.back();
        popFuncValStack();
        for(auto *t : clonedFnValues)
          pushFuncStack(t);  

        delete unroller;


        // if not main function
        if(ci) {
          std::vector<Value*> args(ci->arg_begin(), ci->arg_end());
          CallInst *clonedCall = createFuncCall(currfn, args);
          //erase any old replacements from toreplace for this function
          string originalName = removeCloneName(ci->getCalledFunction()->getName().str());
          ReplaceInstWithInst(ci, clonedCall);

          Function *original = module->getFunction(originalName);
          if(funcSpecMap.find(original) != funcSpecMap.end()) {
            debug(Yes) << "replacing call due to loop pass\n";
            funcSpecMap[original]->call = clonedCall;
          }
          ci = clonedCall;
        }
        debug(Yes)<<"Renaming Function!\n";
        renameFunctions(currfn, oldFn);
        toRun = currfn;
      }
    }
  }

  debug(Yes)<<"runOnFunction(): worklist has ended...\n";
  stats.functionReturn();
  //previousBB = oldPrevious;
  callStack.pop_back();

  currBB = tempBB;
  pop_back(worklistBB);
  if(!ci) return;

  FuncInfo * fi = fimap[toRun];
  if(!fi->context) {
    fi->context = bbOps.duplicateMem(currBB);
    debug(Yes) << "Unexpected behavior -> no context returned : possible if cant return from function, or unreachable instruction hit\n";
    //TODO: Can we hit unreachable and exit, even if there's a return present?
    //currfn = temp;
    //return;
  }
  debug(Yes)<<"[Rafae] Copying Context for "<<toRun->getName()<<"\n";
  debug(Yes)<<"CurrBB: "<<*currBB<<"\n";
  debug(Yes)<<"fi->context: "<<fi->context<<"\n";
  bbOps.copyContext(fi->context, currBB);
  currfn = temp; //restore to caller
  currContextIsAnnotated = tempAnnot;

  debug(Yes)<<"Cleaning up function BBInfo..\n";
  bbOps.cleanUpFuncBBInfo(toRun);
  regOps.cleanUpFuncBBRegisters(toRun, popFuncValStack());
  if(fi->retReg) addSingleVal(ci, fi->retReg->getValue(), false, true);
}
void ConstantFolding::getTrackedValues(set<Value *> &trackedValues) {
  for(auto &F: *module) {
    for(auto &BB: F) {
      for(auto &I: BB) {
        if(isAllocaTracked(&I))
          trackedValues.insert(&I);
      }
    }
  }

  for(auto it = module->global_object_begin(), end = module->global_object_end(); it != end; it++)
    if(it->getMetadata("track"))
      trackedValues.insert(&*it);
}

/*
   Entry point of the pass 
   */
bool ConstantFolding::runOnModule(Module & M) {
  initDebugLevel();
  debug(Yes) << "...................................ConstantFolding Pass started.......................................................................\n";
  module = &M;
  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  DL = new DataLayout(module);   
  CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();  
  PreserveLCSSA = mustPreserveAnalysisID(LCSSAID);

  useAnnotations = isAnnotated;  
  trackAllocas = trackAlloc;
  if(trackAllocas)
    getTrackedValues(trackedValues);

  for (auto &fileName:fileNames){
    debug(Yes) <<fileName <<"\n";
    configFileNames.push_back(fileName);
  }

  auto start = std::chrono::high_resolution_clock::now();
  collectCallGraphGlobals(CG);
  auto stop = std::chrono::high_resolution_clock::now();
  auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
  debug(Yes)<<"[MODREF] Analysis took: "<<duration.count()<<" microseconds... \n";
  numConfigFiles = rand() % 100000000 + 100000; 
  getReadonlyFuncNames();

  Function * func = module->getFunction(StringRef("main"));
  BasicBlock * entry = &func->getEntryBlock();

  if (!isFuncInfoInitialized(func)) {
    FuncInfo* fi = initializeFuncInfo(func);
    addFuncInfo(func, fi);
  }

  if (!bbOps.isBBInfoInitialized(entry)) {
    LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*entry->getParent()).getLoopInfo();
    bbOps.initAndAddBBInfo(entry, LI);
  }
  bbOps.createNewContext(entry, module);

  currBB = entry;
  currContextIsAnnotated = true;
  addGlobals();

  runOnFunction(NULL, func);

  auto Rstart = std::chrono::high_resolution_clock::now();
  replaceUses();
  auto Rstop = std::chrono::high_resolution_clock::now();
  auto Rduration = std::chrono::duration_cast<std::chrono::microseconds>(Rstop - Rstart);
  debug(Yes)<<"[REPLACEUSES] Analysis took: "<<Rduration.count()<<" microseconds... \n";

  auto Dstart = std::chrono::high_resolution_clock::now();
  deleteFileIOCalls();
  auto Dstop = std::chrono::high_resolution_clock::now();
  auto Dduration = std::chrono::duration_cast<std::chrono::microseconds>(Dstop - Dstart);
  debug(Yes)<<"[DELETEFILEIO] Analysis took: "<<Dduration.count()<<" microseconds... \n";

  stats.printStats(module->getFunction("main"));

  debug(Yes)<<"ConstantFolding Pass completed!\n";
  debug(Yes)<<"Functions Skipped: "<<fSkipped<<"\n";
  debug(Yes)<<"TrackedLoads = "<<trackedLoads<<"\n";
  std::ofstream StatFile("constStats.JSON",std::ios_base::app);
  StatFile<<"\"FunctionsSkipped\":"<<fSkipped<<", \"TrackedLoads\":"<<trackedLoads<<"}\n";
  StatFile.close();

  debug(Yes) << "...................................ConstantFolding Pass ended.......................................................................\n";
  return true;
}   

char ConstantFolding::ID = 0;

static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);

//1) collect any load on any global in current
//function. add globals to func mod set
//2) traverse call graph of each function, and 
//add mod sets of called functions in callees
//3) In case a cycle is found, duplicate mod
// set to all the functions in the cycle
//4) A function calling a function part of a cycle
//will always be a superset of the mod set of the 
//functions in the cycle

Cycle *ConstantFolding::mergeCycles(set<Cycle *> &cycles) {
  Cycle *newCycle = new Cycle;
  for(auto &cycle: cycles) {
    newCycle->nodes.insert(cycle->nodes.begin(), cycle->nodes.end());
    newCycle->values.insert(cycle->values.begin(), cycle->values.end());
  }

  return newCycle;
}


set<GlobalVariable *> ConstantFolding::dfs(CallGraphNode *root, map<Function *, set<GlobalVariable *> >&modSet, set<Function *> &openNodes, vector<Function *> &recStack, map<Function *, Cycle * > &cycles) {
  static set<Function *> processed;
  if(!root)
    return set<GlobalVariable *>();

  Function *F = root->getFunction();
  if(!F)
    return set<GlobalVariable *>();

  if(F->isDeclaration())
    return set<GlobalVariable *>();

  if(processed.find(F) != processed.end()) {
    //might be part of a cycle. Need to add this function to that cycle too
    return modSet[F];
  }

  if(openNodes.find(F) != openNodes.end()) {
    //handle cycle
    debug(Yes) << "Cycle found : " << "\n";
    set<Cycle *> oldCycles;
    set<Function *> cycleFunctions;

    cycleFunctions.insert(F);
    //find if part of any cycle already
    for(int i = recStack.size() - 1; recStack[i] != F; i--) {
      assert(i > -1);
      if(cycles.find(recStack[i]) != cycles.end())
        oldCycles.insert(cycles[recStack[i]]);
      cycleFunctions.insert(recStack[i]);
    }

    if(cycles.find(F) != cycles.end())
      oldCycles.insert(cycles[F]);

    Cycle *newCycle;

    //FIXME redundant in case of size = 1
    if(oldCycles.size())
      newCycle = mergeCycles(oldCycles);
    else
      newCycle = new Cycle;

    //merge cycle functions 
    newCycle->nodes.insert(cycleFunctions.begin(), cycleFunctions.end());

    //merge values
    for(auto &func: cycleFunctions) {
      newCycle->values.insert(modSet[func].begin(), modSet[func].end());
    }

    //update mod sets. FIXME can just replace instead of merging here?
    for(auto &func: cycleFunctions)
      modSet[func].insert(newCycle->values.begin(), newCycle->values.end());

    //for(auto &cycle: oldCycles)
    //delete cycle;

    //update cycle reference
    for(auto &func: cycleFunctions)
      cycles[func] = newCycle;

    return set<GlobalVariable *>();
  }

  openNodes.insert(F);
  recStack.push_back(F);

  set<GlobalVariable *> data = modSet[F];

  set<CallGraphNode *> children_visited;

  for(unsigned i = 0, end = root->size(); i != end; i++) {
    auto called = (*root)[i];
    if(!called)
      continue;

    if(children_visited.find(called) != children_visited.end())
      continue;

    children_visited.insert(called);
    set<GlobalVariable *> childData = dfs(called, modSet, openNodes, recStack, cycles);

    data.insert(childData.begin(), childData.end());
    //if(calledNode.second->getFunction())
  }

  openNodes.erase(F);
  recStack.pop_back();
  modSet[F].insert(data.begin(), data.end());
  processed.insert(F);
  return data;
}

set<GlobalVariable *> &ConstantFolding::getFuncModset(Function *F) {
  //assert(modSet.find(F) != modSet.end());
  if(modSet.find(F) != modSet.end())
    return modSet[F];
  else {
    modSet[NULL] = set<GlobalVariable *>();
    return modSet[NULL];
  }
}

void ConstantFolding::collectModSet(GlobalVariable *gv, map<Function *, set<GlobalVariable *> > &modSet) {
  for(auto user: gv->users()) {
    Instruction *I;
    if(!(I = dyn_cast<Instruction>(user)))
      continue;
    Function *F = I->getParent()->getParent();
    modSet[F].insert(gv);
  }
}

void ConstantFolding::collectCallGraphGlobals(CallGraph *CG) {
  debug(Yes) << "PRINTING CALL GRAPH" << "\n";
  map<Function *, Cycle * > cycles;
  set<Function *> openNodes;
  vector<Function *> recStack;

  for(auto &global: module->global_objects())
    if(dyn_cast<GlobalVariable>(&global))
      collectModSet(dyn_cast<GlobalVariable>(&global), modSet);

  Function *main = CG->getModule().getFunction("main");
  assert(main);
  for(auto &kv: modSet) {
    Function *F = kv.first;
    debug(Yes)<< "Function: " << F->getName() << "\n";
    for(auto &val: kv.second) {
    }
  }
  dfs(CG->getOrInsertFunction(main), modSet, openNodes, recStack, cycles);
  set<Function *> openNodes_two;
}

/*
   ProcResult ConstantFolding::processPtrToInt(PtrToIntInst *pi) {
   Value *pointer = pi->getPointerOperand();
   Register *reg = processInstAndGetRegister(pointer);

   if(!reg) {
   debug(Yes) << "failed to fold pointer inst. Register not found\n";
   return NOTFOLDED;
   }

//PtrToIntInst *clone = cast<PtrToIntInst>(pi->clone());
ConstantInt *constantPtr = cast<ConstantInt>(ConstantInt::get(pi->getType(), reg->getValue()));

debug(Yes) << "trying to fold " << *constantPtr<< "\n";
addSingleVal(pi, constantPtr->getZExtValue(), true, true);
return FOLDED;
}
*/
/**
 * Process Alloca Instructions:
 * ty * %a = ty
 * allocate shadow memory of bytes sizeof(ty) on the stack and add shadow register 
 * with value equal to the starting address of the allocated memory
 */
ProcResult ConstantFolding::processAllocaInst(AllocaInst * ai) {

  Type * ty = ai->getAllocatedType();
  unsigned size = DL->getTypeAllocSize(ty);
  uint64_t addr = bbOps.allocateStack(size, currBB);

  pushFuncStack(ai);
  bool tracked = isAllocaTracked(ai);
  regOps.addRegister(ai, ty, addr, tracked);
  debug(Yes) << "allocaInst : size " << size << " at address " << addr << "\n";
  stats.incrementInstructionsFolded();
  return UNDECIDED;
}

// Process Malloc Instructions: Allocate heap memory
ProcResult ConstantFolding::processMallocInst(CallInst * mi) {  

  stats.incrementTotalLibCalls();

  Value * sizeVal = mi->getOperand(0);
  uint64_t size;
  if(!getSingleVal(sizeVal, size)) {
    debug(Yes) << "mallocInst : size not constant\n";
    return NOTFOLDED;
  }
  uint64_t addr = bbOps.allocateHeap(size, currBB);  
  bool tracked = isAllocaTracked(mi);

  pushFuncStack(mi);
  regOps.addRegister(mi, mi->getType(), addr, tracked);
  debug(Yes) << "mallocInst : size " << size << " at address " << addr << "\n";
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return UNDECIDED;
}

ProcResult ConstantFolding::processCallocInst(CallInst * ci) {   
 
  stats.incrementTotalLibCalls();
  Value * numVal = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  uint64_t num, bsize;

  if(!getSingleVal(numVal, num)) {
    debug(Yes) << "callocInst : num not constant\n";
    return NOTFOLDED;
  }
  if(!getSingleVal(sizeVal, bsize)) {
    debug(Yes) << "callocInst : size not constant\n";
    return NOTFOLDED;
  }
  unsigned size = num * bsize;
  uint64_t addr = bbOps.allocateHeap(size, currBB);  
  bool tracked = isAllocaTracked(ci);

  pushFuncStack(ci);
  regOps.addRegister(ci, ci->getType(), addr, tracked);
  debug(Yes) << "callocInst : size " << size << " at address " << addr << "\n";  
  memset((char *) bbOps.getActualAddr(addr, currBB), '\0', size);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return UNDECIDED;
}

/*
 * Process Bitcast Instruction :
 * bitcast ty1 * %a, ty2 * %b
 * if shadow register for %b exists add shadow register for %a with same value
 * as %b but type ty1
 */
ProcResult ConstantFolding::processBitCastInst(BitCastInst * bi) {

  Value * ptr = bi->getOperand(0);
  Register * reg = processInstAndGetRegister(ptr);
  if(!reg) {
    //try function
    /*if(dyn_cast<Function>(ptr)) {
      addSingleVal(bi, (uint64_t) ptr, false, true);
      debug(Yes)<<"in bitcast inst\n";
      return NOTFOLDED;
    }*/
    debug(Yes) << "BitCastInst : Not found in Map\n";
    return NOTFOLDED;
  }

  pushFuncStack(bi);
  debug(Yes)<< reg->getValue()<<"\n";
  regOps.addRegister(bi, bi->getType(), reg->getValue(), reg->getTracked());
  stats.incrementInstructionsFolded();
  return UNDECIDED;
}
ProcResult ConstantFolding::processStoreInst(StoreInst * si) {
  Value* storeOp = si->getOperand(0);
  Value * ptr = si->getOperand(1);
  Register * reg = processInstAndGetRegister(ptr);
  if(!reg) {
    debug(Yes) << "StoreInst : not found in map\n";
    return NOTFOLDED;
  }
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(storeOp->getType());
  uint64_t val;
  if(!getSingleVal(storeOp, val)) {
    debug(Yes) << "StoreInst : from cannot be determined\n";
    bbOps.setConstMem(false, addr, size, currBB);
    return NOTFOLDED;
  }

  bbOps.storeToMem(val, size, addr, currBB); 
  bbOps.setConstMem(true, addr, size, currBB);
  stats.incrementInstructionsFolded();
  debug(Yes)<<"StoreInst currBB: "<<currBB->getParent()->getName()<<"\n";
  return UNDECIDED;
}


Value *ConstantFolding::getLoadSource(LoadInst* LI){
  unsigned iter = 0;
  Value* processing = &*LI;

  unsigned stackCounter = 0; //How many functions to go back 

  debug(Yes)<<"Invoked getLoadSource ...\n";
  Function* parentFunction = LI->getParent()->getParent();
  if(parentFunction){
    debug(Yes)<<"ParentFunction: "<<parentFunction->getName()<<"\n";
  } else {
    debug(Yes)<<"No parent function! \n";
  }
  bool foundSource = false;
  do
  {
    debug(Yes)<<"Processing = "<<*processing<<"\n";
    if(LoadInst* LI = dyn_cast<LoadInst>(processing)){
      processing = LI->getPointerOperand();
    } else if(auto GE = dyn_cast<GetElementPtrInst>(processing)){
      debug(Yes)<<"GEP inst has " << GE->getNumOperands() << " Operands\n"; 
      for(unsigned cnt = 0; cnt < GE->getNumOperands(); ++cnt){
        debug(Yes)<<"Operand "<<cnt<<" "<<*GE->getOperand(cnt)<<"\n";
      }
      processing = GE->getPointerOperand()->stripPointerCasts();
    } else if(dyn_cast<GlobalObject>(processing)) {
      foundSource = true;
    } else if(auto SI = dyn_cast<SelectInst>(processing)){
      if(ConstantInt * CI = dyn_cast<ConstantInt>(SI->getCondition())) {
        processing = CI->getZExtValue() ? SI->getTrueValue() : SI->getFalseValue();
      }
    } else if(auto BI = dyn_cast<BitCastInst>(processing)){
      processing = BI->getOperand(0);
    } else if(dyn_cast<Instruction>(processing)){
      foundSource = true;
    } else if(dyn_cast<PointerType>(processing->getType())){
      debug(Yes)<<"Pointer type: !\n";
      Function* CalledFunction = parentFunction;
      for(auto ai = CalledFunction->arg_begin(); ai != CalledFunction->arg_end(); ++ai){
        Value* argVal = &*ai;
        if(argVal == processing){
          stackCounter++;

          debug(Yes)<<"ArgVal: "<<*argVal<<" equals "<<*processing<<"\n";
          unsigned argNum = ai->getArgNo();
          debug(Yes)<<"Match for "<<CalledFunction->getName()<<" at argument number "<<argNum<<"\n";


          if(!callStack.size()){
            return processing;
          }
          BasicBlock* previousBB = callStack[callStack.size() -stackCounter];
          debug(Yes)<<"========================================\nCallInst BB: "<<*previousBB<<"\n";


          for(auto bi = previousBB->begin(); bi != previousBB->end(); ++bi){
            Instruction* BBIns = &*bi;
            if(auto CI = dyn_cast<CallInst>(BBIns)){
              Function* CF = CI->getCalledFunction();
              debug(Yes)<<"Previous BB CallInst: "<<*CI<<"\n";


              if(CF && removeCloneName(CF->getName()) == removeCloneName(parentFunction->getName())){
                debug(Yes)<<"Name matches!!!\n";
                Value * temp = CI->getArgOperand(argNum);
                parentFunction = CI->getParent()->getParent(); //Parent Function becomes function with callInst

                unsigned counter = 0;
                debug(Yes)<<"Shifting to previous function with val: "<<*temp<<"\n";
                processing = temp;
                break;
              } else {
                debug(Yes)<<"Name doesnt match\n";
              }
            }
          }
          break;
        }
      }
      debug(Yes)<<"\nMoving to next iteration\n";
      //foundSource = true;
    } else {
      debug(Yes)<<"ELSE CASE\n";
      debug(Yes)<<*(processing->getType())<<"\n";
      foundSource = true;
    }
    iter++;
  } while(!foundSource && iter < 100);


  return processing;
}

// Process Load instructions: load memory and map the load value to the memory address loaded
ProcResult ConstantFolding::processLoadInst(LoadInst * li) { 
  stats.incrementTotalLoads();

  Value * ptr = li->getOperand(0);
  Register * reg = processInstAndGetRegister(ptr);
  if(!reg) {
    debug(Yes) << "LoadInst : Not found in Map\n";
    return NOTFOLDED;
  }
  uint64_t addr = reg->getValue();
  if(addr==999999999){
    pushFuncStack(li);
    regOps.addRegister(li,li->getType(),999999999);
    return UNDECIDED;
  }
  uint64_t size = DL->getTypeAllocSize(li->getType());

  debug(Yes) << addr << " LoadInst\n";
  if(!bbOps.checkConstMem(addr, size, currBB)) {
    debug(Yes) << " LoadInst : skipping non constant\n";
    return NOTFOLDED;
  }

  debug(Yes)<<"Loading from operand: "<<*ptr<<"\n";

  if(reg->getTracked()){
    trackedLoads++;
  }


  /*
     Value * source = getLoadSource(li);
     debug(Yes)<<"Load Source: "<<*source<<"\n";

     if(auto GO = dyn_cast<GlobalObject>(source)){
     if(GO->hasMetadata() && GO->getMetadata("track")){
     debug(Yes)<<"Loading from tracked Global!\n";
     stats.incrementTrackedLoads();
     }
     } else if(auto Ins = dyn_cast<Instruction>(source)){
     if(Ins->hasMetadata() && Ins->getMetadata("track")){
     debug(Yes)<<"Loading from instruction which is tracked!\n";
     stats.incrementTrackedLoads();
     }
     }*/
  debug(Yes)<<"TrackedLoads: "<<stats.getTrackedLoads()<<"\n";


  /*
     if(auto GE =  dyn_cast<GetElementPtrInst>(ptr)){
     Value * ptrOp = GE->getPointerOperand();
     if(Instruction* Ins = dyn_cast<Instruction>(ptrOp)){
     if(Ins->hasMetadata() && Ins->getMetadata("track")){
     debug(Yes)<<"Operand of GEPInst in load is: "<<*Ins<<" which is tracked!\n";
     }
     }
     } else if(Instruction* Ins = dyn_cast<Instruction>(ptr)){
     if(Ins->hasMetadata() && Ins->getMetadata("track")){
     debug(Yes)<<"LoadInst operand from tracked memory: "<<*Ins<<"in function "<<Ins->getParent()->getParent()->getName()<<"\n";;
     }
     } else if(GlobalObject* GO = dyn_cast<GlobalObject>(ptr)){
     if(GO->hasMetadata() && GO->getMetadata("track")){
     debug(Yes)<<"LoadInst operand GlobalObject is tracked!\n";
     }
     } */


  uint64_t val = bbOps.loadMem(addr, size, currBB);
  debug(Yes)<<"LoadInst currBB: "<<currBB->getParent()->getName()<<"\n";


  debug(Yes)<<"LoadInst Val: "<<val<<"\n";
  addSingleVal(li, val, true , reg->getTracked());
  pushFuncStack(li);
  stats.incrementLoadsFolded();
  stats.incrementInstructionsFolded();
  return UNDECIDED;
}

// Process PtrToInst Instructions: map the pointer argument to a different type to be used in further instructions
ProcResult ConstantFolding::processPtrToIntInst(PtrToIntInst* pi){
  debug(Yes)<<"Invoked processPtrToIntInst\n";
  Value * ptr = pi->getOperand(0);

  Register * reg = processInstAndGetRegister(ptr);
  if(!reg){
    debug(Yes)<<"PtrToIntInst: Not found in map\n";
    return NOTFOLDED;
  }
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(pi->getType());

  debug(Yes)<<"PtrToIntInst => RegValue: "<<addr<<"\n";

  if(!bbOps.checkConstMem(addr, size, currBB)) {
    debug(Yes) << " PtrToIntInst: skipping non constant\n";
    return NOTFOLDED;
  }
  pushFuncStack(pi);
  regOps.addRegister(pi, pi->getType(), reg->getValue(), reg->getTracked());
  stats.incrementInstructionsFolded();
  return UNDECIDED;
}

// Process GetElementbyPtr Instructions: maps the GEP value to the resultant address in memory so that it can be used in further instructions.
ProcResult ConstantFolding::processGEPInst(GetElementPtrInst * gi) {

  Value * ptr = gi->getOperand(0);

  Register * reg = processInstAndGetRegister(ptr);    
  if(!reg) {
    debug(Yes) << "GepInst : Not found in map\n";
    return NOTFOLDED;
  }

  

  unsigned OffsetBits = DL->getPointerTypeSizeInBits(gi->getType());
  APInt offset(OffsetBits, 0); 
  bool isConst = gi->accumulateConstantOffset(*DL, offset);
  debug(Yes)<<"[processGEPInst]isConst: "<<isConst<<"\n";

  Value *offsetVal = gi->getOperand(1);
  Register *regOffset = processInstAndGetRegister(offsetVal);

  if((/*useRegOffset && */ !isConst  && !regOffset) /*|| (!useRegOffset && !isConst)*/) {
    //TODO recursively mark memory non constant
    debug(Yes) << "GepInst : offset not constant\n";
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;
  }
  if(reg->getValue()==999999999)
  {
    unsigned short int num = traitsTable[offset.getZExtValue()/2];
    uint64_t addr = bbOps.allocateHeap(sizeof(unsigned short int), currBB);
    unsigned short int * source = (unsigned short int *) bbOps.getActualAddr(addr, currBB);
    *source = num;
    regOps.addRegister(gi, gi->getType(), addr);
    pushFuncStack(gi);
    return UNDECIDED;

  }
  uint64_t val;

  if(/*useRegOffset &&*/ regOffset && !isConst){
    val = reg->getValue() + regOffset->getValue();
    debug(Yes)<<"Register Offset value: "<<regOffset->getValue()<<"\n";
  } else { 
    val = reg->getValue() + offset.getZExtValue();
    debug(Yes)<<"APInt Offset value: "<<offset.getZExtValue()<<"\n";
  }
  

  debug(Yes)<<"Resultant Address: "<<val<<"\n";
  pushFuncStack(gi);
  regOps.addRegister(gi, gi->getType(), val, reg->getTracked());
  debug(Yes) << val << " GEP Inst\n";
  stats.incrementInstructionsFolded();
  return UNDECIDED;
}

ProcResult ConstantFolding::processMemMoveInst(CallInst * memMoveInst) {

  Value * toPtr = memMoveInst->getOperand(0);
  Value * fromPtr = memMoveInst->getOperand(1);
  char * fromString;
  Value * sizeVal = memMoveInst->getOperand(2);
  uint64_t size;
  Register * reg = processInstAndGetRegister(toPtr);
  if(!reg) {
    debug(Yes) << "processMemMoveInst : Not found in Map\n";
    return NOTFOLDED;
  }

  if(!getSingleVal(sizeVal, size)) {
    debug(Yes) << "processMemMoveInst : size not constant\n";
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;
  }

  if(!getStr(fromPtr, fromString, size)) {
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;
  }
  char * toString = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  //need to duplicate first since move
  char *dup = strdup(toString);
  debug(Yes) << "memmove : from " << fromString << "\n";
  memcpy(toString, dup, size);
  bbOps.setConstMem(true, reg->getValue(), size, currBB);
  free(dup);
  stats.incrementInstructionsFolded();
  return NOTFOLDED;
}

// Handle memcpy instructions: copy the string address to the destination address so that it can be used in further instructions.  
ProcResult ConstantFolding::processMemcpyInst(CallInst * memcpyInst) {

  stats.incrementTotalLibCalls();
  Value * toPtr = memcpyInst->getOperand(0);
  Value * fromPtr = memcpyInst->getOperand(1);
  char * fromString;
  Value * sizeVal = memcpyInst->getOperand(2);
  uint64_t size;
  Register * reg = processInstAndGetRegister(toPtr);  

  if(!reg) {
    debug(Yes) << "processMemcpyInst : Not found in Map\n";
    return NOTFOLDED;
  }


  if(!getSingleVal(sizeVal, size)) {
    debug(Yes) << "processMemcpyInst : size not constant\n";
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;   
  } 

  if(!getStr(fromPtr, fromString, size)) {
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;
  }
  char * toString = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  debug(Yes) << "memcpy : from " << fromString << "\n";
  memcpy(toString, fromString, size);
  bbOps.setConstMem(true, reg->getValue(), size, currBB);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return NOTFOLDED;
}
ProcResult ConstantFolding::processMemSetInst(CallInst * memsetInst) {
  Value * ptr = memsetInst->getOperand(0);
  Value * chrctr = memsetInst->getOperand(1);
  Value * sizeVal = memsetInst->getOperand(2);
  stats.incrementTotalLibCalls();

  Register * ptrReg = processInstAndGetRegister(ptr);  
  if(!ptrReg) {
    debug(Yes) << "processMemSetInst : Not found in Map\n";
    return NOTFOLDED;
  }

  uint64_t c;
  if(!getSingleVal(chrctr, c)) {
    debug(Yes) << "processMemSetInst : character not found in Map\n";
    return NOTFOLDED;    
  }

  uint64_t size;
  if(!getSingleVal(sizeVal, size)) {
    debug(Yes) << "processMemSetInst : size not found in Map\n";
    return NOTFOLDED;      
  }

  char * ptrString = (char *) bbOps.getActualAddr(ptrReg->getValue(), currBB);
  memset(ptrString, c, size);
  debug(Yes) << "set string to " << c << " size " << size << "\n";
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return NOTFOLDED;
}
/*
 * Try folding phiNodes
 */
ProcResult ConstantFolding::processPHINode(PHINode * phiNode) {
  debug(Yes)<<"Invoked processPHINode...\n";
  vector<Value*> incPtrs;
  Value * val = bbOps.foldPhiNode(phiNode, incPtrs);
  //in case not folded, mark all memories as non constant
  if(!val){
    debug(Yes)<<"Unable to fold PHINode!\n";
    for(auto &val: incPtrs) {
      if(Register *reg = processInstAndGetRegister(val)) {
        Value *val = regOps.getValue(reg);
        assert(val);
        if(val->getType()->isPointerTy()){
          debug(Yes)<<"Marking PhiNode memory non const! \n";
          markMemNonConst(dyn_cast<PointerType>(val->getType())->getElementType(), reg->getValue(), currBB);
        }
      }
    }
  }

  if(val && replaceOrCloneRegister(phiNode, val)) {
    debug(Yes) << "folded phiNode\n";
    stats.incrementInstructionsFolded();
    return FOLDED;
  } else {
    debug(Yes) << "failed to fold phiNode\n";
   return NOTFOLDED;
  }
}
/*
 * Try folding simple Instructions like icmps, sext, zexts
 */
ProcResult ConstantFolding::tryfolding(Instruction * I) { 
  if(Instruction * sI = simplifyInst(I))
    return tryfolding(sI);
  else {
    Constant * constVal = ConstantFoldInstruction(I, *DL, TLI);
    if(constVal) {
      replaceIfNotFD(I, constVal);
      stats.incrementInstructionsFolded(); 
      return FOLDED;
    }   
  }
  return NOTFOLDED;
}
/*
   Process all terminator Instructions except Returns
   first try to fold a terminator Instruction to a single successor.
   e.g.
   %i = icmp eq i32 %a, 7
   br i1 %i, bb %x, bb %y

   if we can fold the icmp Instruction we can fold the branch Instruction
   to point to only one block. (Which might lead to code debloating).

   Then visit all successors one by one. 
   bbOps.isnotSingleSucc(BB) returns true if the terminator has been folded to a
   single successor and BB is NOT that successor.
   e.g. if %i above is true bbOps.isnotSingleSucc(%y) will return true.
   */
ProcResult ConstantFolding::processTermInst(TerminatorInst * termInst) {  
  vector<BasicBlock *> readyToVisit;
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  bool single = bbOps.foldToSingleSucc(termInst, readyToVisit, LI);
  if(single)   stats.incrementInstructionsFolded();
  visitReadyToVisit(readyToVisit);
  
  ProcResult result =  single ? FOLDED : NOTFOLDED;
  unsigned numS = termInst->getNumSuccessors(); 
  set<BasicBlock*> processed;

  for(unsigned int index = 0; index < numS; index++) {
    BasicBlock * succ = termInst->getSuccessor(index);

    if(processed.find(succ) != processed.end())
      continue;

    processed.insert(succ);
    if(bbOps.isnotSingleSucc(currBB, succ)) continue;
    if(!bbOps.visitBB(succ, LI)) continue;
    if(!visitBB(succ, currBB)) break;
  }
   
  return result;
}
/*
   Process Return Instruction:
   At return Instruction we need to save the current memory context as this context
   will need to be replaced after we return to the calling function.
   */
ProcResult ConstantFolding::processReturnInst(ReturnInst * retInst) {   
  debug(Yes)<<"Invoked Ret inst\n";
  if(currfn->getName().str() == "main")
    return NOTFOLDED;
  debug(Yes)<<"Ret inst, current function: "<<currfn->getName().str()<<"\n";
  FuncInfo * fi = fimap[currfn];
  Value * ptr = retInst->getReturnValue();
  fi->context = bbOps.duplicateMem(currBB);  
  debug(Yes)<<"Duplicating Memory ... \n"<<"fi->context: "<<fi->context<<"\n";
  if(!ptr)
    return NOTFOLDED;
  if(cloneRegister(retInst, ptr)){
    fi->retReg = new Register(*processInstAndGetRegister(retInst)); 
    stats.incrementInstructionsFolded();}
  return NOTFOLDED;
}
/*
   Process Call Instruction:
   If the call is an indirect call, try to see if we can fold allocate the 
   function because of propagation.

   1. TRIMMER debugging instructions added to the source
   2. getopt calls
   3. malloc, calloc etc
   4. Memcpy, Memset
   5. string function : e.g. strcmp, strchr, atoi
   6. fileIO calls : open, read, lseek
   7. external functions : dont visits
   8. internal functions : only visit if it satisfies certain conditions

   If the callInst is an external call, internal call that we dont visit or
   an indirect function call that we fail to simplify we mark all its input 
   arguments as non constant
TODO : we should mark the globals accessed by it as non constant.

*/
void ConstantFolding::markGlobAsNonConst(Function *F) {
  if(!F)
    return;

  set<GlobalVariable*> &data = getFuncModset(F);
  debug(Yes) << "marking globals for " << F->getName() << " as non const\n";
  for(auto &gv: data) {
    if(gv->isConstant())
      continue;
    auto reg = processInstAndGetRegister(gv);  
    if(!reg)
      continue;
    debug(Yes) << "marking global non constant: " << *gv << "\n";
    bbOps.setConstMem(false, reg->getValue(), DL->getTypeAllocSize(reg->getType()), currBB);
  }
}

bool ConstantFolding::handleGetUid(CallInst *callInst) {
  uid_t userId = getuid();
  addSingleVal(callInst, (uint64_t)userId, true, true);
  stats.incrementTotalLibCalls();
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleGetGid(CallInst *callInst){
    gid_t groupId = getgid();
    addSingleVal(callInst, (uint64_t)groupId, true, true);
    stats.incrementTotalLibCalls();
    stats.incrementLibCallsFolded();
    stats.incrementInstructionsFolded();
    return true;
}

bool ConstantFolding::copyMemory(char *address, Type *ty, char *localAddress) {
  debug(Yes) << "Copying over memory" << "\n";
  StructType *st = dyn_cast<StructType>(ty);
  debug(Yes) << st << "\n";
  auto structLayout = DL->getStructLayout(st);
  for(unsigned i = 0; i < st->getStructNumElements(); i++) {
    PointerType *t = dyn_cast<PointerType>(st->getStructElementType(i));

    if(!t) {
      continue;
    }

    uint64_t offset = structLayout->getElementOffset(i);
    if(t->getElementType()->isPointerTy()) {
      debug(Yes) << "Warning case not handled\n"; 
    } else {
      //assumption that this is char *

      //allocate memory
      char *pointer = *(char**)(address + offset);
      uint64_t allocationSize = strlen(pointer) + 1;
      uint64_t val = bbOps.allocateStack(allocationSize, currBB);

      //copy over data
      char *actualAddr = (char *)bbOps.getActualAddr(val, currBB);
      debug(Yes) << "Copying : "<< string(pointer) << " at address: " << val << " real destination address: " << actualAddr << "\n";
      strcpy(actualAddr, pointer);
      debug(Yes) << "Copied : " << actualAddr << "\n";

      //store pointer
      uint64_t size = DL->getTypeAllocSize(t);
      debug(Yes) << "Storing pointer at address: " << (uint64_t) localAddress + offset << "\n";
      bbOps.storeToMem(val, size,(uint64_t) localAddress + offset, currBB);  
    }
  }
  return true;
}

bool ConstantFolding::handleStat(CallInst *ci) {
  Value *path = ci->getOperand(0);
  Value *statBuf = ci->getOperand(1);
  Register *pathReg = processInstAndGetRegister(path);
  Register *statBufRegister = processInstAndGetRegister(statBuf);

  stats.incrementTotalLibCalls();

  if(!pathReg || !statBufRegister) {
    debug(Yes) << "stat: one of the registers not found\n";
    return false;
  }

  debug(Yes) << "calling stat on " << (char *) bbOps.getActualAddr(pathReg->getValue(), currBB) << " virtual addr = " << pathReg->getValue() << " statbuf addr = " << statBufRegister->getValue() << "\n";
  string name = string((char *) bbOps.getActualAddr(pathReg->getValue(), currBB));
  if(std::find(std::begin(configFileNames), std::end(configFileNames), name) == std::end(configFileNames)) {
    debug(Yes)<<"stat: marking arguments non constant returning\n";
    markArgsAsNonConst(ci);
    debug(Yes) << "stat: on non config file. returning\n";
    return false;
  }

  int result = stat((char *) bbOps.getActualAddr(pathReg->getValue(), currBB), (struct stat *) bbOps.getActualAddr(statBufRegister->getValue(), currBB));

  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();

  debug(Yes) << "stat returned " << result << "\n";
  addSingleVal(ci, result, true, true);
  return FOLDED;
}

bool ConstantFolding::handleGetPwUid(CallInst *callInst) {	
  stats.incrementTotalLibCalls();
  Value *uidVal = callInst->getOperand(0);
  uint64_t uid;

  if(!getSingleVal(uidVal, uid))
    return false;

  struct passwd *pwuid = getpwuid(uid);
  stats.incrementLibCallsFolded();

  if(!pwuid)
    return false;

  PointerType * pointerTy = dyn_cast<PointerType>(callInst->getType());
  if(!pointerTy)
    return false;

  Type *ty = pointerTy->getElementType();

  unsigned size = DL->getTypeAllocSize(ty);
  uint64_t addr = bbOps.allocateStack(size, currBB);

  struct passwd *memPwUid = (struct passwd *)bbOps.getActualAddr(addr, currBB); 

  memcpy(memPwUid, pwuid, size);
  copyMemory((char *) pwuid, dyn_cast<PointerType>(callInst->getType())->getElementType(), (char *)addr);
  addSingleVal(callInst, (uint64_t) addr, false, true);
  stats.incrementInstructionsFolded();
  pushFuncStack(callInst);
  return true;
}

bool ConstantFolding::handleCTypeBLoc(CallInst *callInst) {
  stats.incrementTotalLibCalls();
  const unsigned short **ptr = __ctype_b_loc();
  uint64_t addrPtr = bbOps.allocateStack(DL->getPointerSize(), currBB);

  const unsigned short *arr = *ptr;
  uint64_t localArr = bbOps.allocateStack(sizeof(unsigned short) * (255 + 1 + 128), currBB);
  unsigned short *localArrReal = ((unsigned short *) bbOps.getActualAddr(localArr, currBB)) + 128; // move to 0
  //can just use a memcpy, but this is more explanatory
  for(int i = -128; i <= 255; i++) {
    localArrReal[i] = arr[i];
  }

  *((unsigned short **) bbOps.getActualAddr(addrPtr, currBB)) = ((unsigned short *) localArr + 128);
  addSingleVal(callInst, addrPtr, true, true);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleCTypeBLocLower(CallInst *callInst) {
  stats.incrementTotalLibCalls();
  const int **ptr = __ctype_tolower_loc();
  uint64_t addrPtr = bbOps.allocateStack(DL->getPointerSize(), currBB);

  const int *arr = *ptr;
  uint64_t localArr = bbOps.allocateStack(sizeof(int ) * (255 + 1 + 128), currBB);
  int *localArrReal = ((int *) bbOps.getActualAddr(localArr, currBB)) + 128; // move to 0
  //can just use a memcpy, but this is more explanatory
  for(int i = -128; i <= 255; i++) {
    localArrReal[i] = arr[i];
  }

  *((int **) bbOps.getActualAddr(addrPtr, currBB)) = ((int *) localArr + 128);
  addSingleVal(callInst, addrPtr, true, true);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleToLower(CallInst *callInst) {
  stats.incrementTotalLibCalls();
  debug(Yes) << "Entering tolower \n";
  Value *arg = callInst->getOperand(0);
  int argValue;
  if(auto *cint = dyn_cast<ConstantInt>(arg)) {
    argValue = (int) cint->getZExtValue();
  } else if (Register *reg = processInstAndGetRegister(arg)) {
    argValue = reg->getValue();
  } else {
    debug(Yes) << "tolower: register not found" << "\n";
    return false;
  }

  stats.incrementLibCallsFolded();

  int answer = tolower(argValue);
  debug(Yes) << "tolower returned " << answer << "\n";
  addSingleVal(callInst, answer, true, true);
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleBasename(CallInst *ci) {
  stats.incrementTotalLibCalls();
  Value *val1 = ci->getOperand(0);
  Register *reg1 = processInstAndGetRegister(val1);
  char *path;

  if(!reg1 || !getStr(reg1->getValue(), path)) {
    debug(Yes) << "handleBasename: path not constant or register not found\n";
    return false;
  }

  char *result = basename(path);
  stats.incrementLibCallsFolded();

  uint64_t virtAddr = bbOps.allocateHeap(strlen(result) + 1, currBB);
  char *actualAddr = (char *) bbOps.getActualAddr(virtAddr, currBB);
  strcpy(actualAddr, result);
  addSingleVal(ci, virtAddr, true, true);
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleLibCCall(CallInst *callInst) {
  Function *F;
  if(!(F = callInst->getCalledFunction()))
    return false;

  if(F->getName().str() == "__ctype_b_loc")
    return handleCTypeBLoc(callInst);
  if(F->getName().str() == "__ctype_tolower_loc")
    return handleCTypeBLocLower(callInst);
  if(F->getName().str() == "tolower")
    return handleToLower(callInst);
  if(F->getName().str() == "__xpg_basename")
    return handleBasename(callInst);
  if(F->getName().str() == "command_by_name")
    return handleCBM(callInst);

  return false;
}

bool ConstantFolding::handleCBM(CallInst* callInst) {
  debug(Yes)<<"COMMAND_BY_NAME INVOKED\n";

  Value * op1 = callInst->getOperand(0);

  Register * reg = processInstAndGetRegister(op1);

  if(!reg){
    debug(Yes)<<"CBM: register not found\n";
    return false;
  }

  char * buf = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  debug(Yes)<<"CBM String: "<<buf<<"\n";
  stats.incrementInstructionsFolded();



  return false;
}

bool ConstantFolding::handleGetCwd(CallInst* callInst) {
  stats.incrementTotalLibCalls();
  Value *val = callInst->getOperand(0);
  Value *val2 = callInst->getOperand(1);
  Register *reg = processInstAndGetRegister(val);

  if(!reg || !dyn_cast<ConstantInt>(val2)) {
    debug(Yes) << "getcwd: register not found or size not constant\n";
    return false;
  }

  size_t size = cast<ConstantInt>(val2)->getZExtValue();
  char *buf = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  char *result = getcwd(buf, size);
  stats.incrementLibCallsFolded();

  if(!buf) {
    debug(Yes) << "getcwd: returned null\n";
    addSingleVal(callInst, 0, true, true);
    return true;
  }

  debug(Yes) << "cwd = " << *buf << "\n";
  addSingleVal(callInst, reg->getValue(), true, true);
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleFStat(CallInst *callInst) {	
  stats.incrementTotalLibCalls();

  Value * f = callInst->getOperand(0);
  Value * Stats = callInst->getOperand(1);
  uint64_t fileno;

  if(!getSingleVal(f,fileno)){
    debug(Yes)<<"file number is not constant\n";
    return false;
  }
  Register *statReg = processInstAndGetRegister(Stats);
  if(!statReg){
    debug(Yes)<<"stat struct not found\n";
    return false;
  }

  struct stat st;
  int result = fstat(fileno, &st);
  stats.incrementLibCallsFolded();
  if(result!=0){
    debug(Yes)<<"fstat returns error\n";
    return false;
  }
  uint64_t addr = statReg->getValue();
  struct stat* temp = (struct stat *)bbOps.getActualAddr(addr, currBB);
  memcpy(temp,&st,sizeof(struct stat));
  addSingleVal(callInst,result,true,true);
  stats.incrementInstructionsFolded();
  return true;

}

// handle the fileno function of libc. This function is used to return file descriptors for a specific file stream.
bool ConstantFolding::handleFileNo(CallInst *callInst) {	
  stats.incrementTotalLibCalls();

  Value * f = callInst->getOperand(0);

  uint64_t sfd;
  FILE* fptr;
  bool fdConst = getSingleVal(f,sfd) && getfptr(sfd, fptr);

  if(!fdConst){
    debug(Yes)<<"file pointer is not constant\n";
    return false;
  }

  int result = fileno(fptr);
  stats.incrementLibCallsFolded();

  if(result==-1){
    debug(Yes)<<"fileno returns error\n";
    return false;
  }
  addSingleVal(callInst,result,true,true);
  stats.incrementInstructionsFolded();
  return true;   
}

// This function handles numerous system calls. This is used to get results from OS system calls for precise debloating. 
bool ConstantFolding::handleSysCall(CallInst *callInst) {
  Function *F;
  if(!(F = callInst->getCalledFunction()))
    return false;

  if(F->getName().str() == "getuid")
    return handleGetUid(callInst);
  else if(F->getName().str() == "getgid")
    return handleGetGid(callInst);
  else if(F->getName().str() == "getpwuid")
    return handleGetPwUid(callInst);
  else if(F->getName().str() == "stat" || F->getName().str() == "stat64")
    return handleStat(callInst);
  else if(F->getName().str() == "fstat")
    return handleFStat(callInst);
  else if(F->getName().str() == "fileno")
    return handleFileNo(callInst);
  else if(F->getName().str() == "getenv")
    return handleGetEnv(callInst); 
  else if(F->getName().str() == "getcwd")
    return handleGetCwd(callInst);
  return false;
}

bool ConstantFolding::handleOverFlowInst(CallInst *callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(name == "llvm.sadd.with.overflow.i32") {
    Value *v1 = callInst->getOperand(0);
    Value *v2 = callInst->getOperand(1);
    int value1;
    int value2;
    if(ConstantInt *c1 = dyn_cast<ConstantInt>(v1)) {
      value1 = (int) c1->getZExtValue(); 
    } else {
      debug(Yes) << "Failed to simplify" << "\n";
      return true;
    }

    if(ConstantInt *c1 = dyn_cast<ConstantInt>(v2)) {
      value2 = (int) c1->getZExtValue();
    } else {
      debug(Yes) << "Failed to simplify" << "\n";
      return true;
    }

    int answer = value1 + value2;
    uint64_t val = ((uint64_t)answer << 32);
    debug(Yes) << "adding single value " <<  answer << " shifted " << val << "\n";
    regOps.addRegister(callInst, llvm::IntegerType::getInt64Ty(module->getContext()), val, true);
    //addSingleVal(callInst, val, false, true);
    return true;
  }
  return false;
}

ProcResult ConstantFolding::handleExtractValue(ExtractValueInst *inst) {
  Value *val = inst->getOperand(0);
  Value *val2 = inst->getOperand(1);
  Register *reg = processInstAndGetRegister(val);
  if(!reg) {
    debug(Yes) << "extract value register not found"  << "\n";
    return NOTFOLDED;
  }
  ConstantInt *offset = NULL;
  debug(Yes) << *val2 << "\n";
  if(!(offset = dyn_cast<ConstantInt>(val2))) {
    debug(Yes) << "extract value offset not constant" << "\n";
    return NOTFOLDED;
  }
  uint64_t off = offset->getZExtValue();
  int32_t answer = 0;
  if(off == 0) {
    answer = (~(8589934592 - 1) & reg->getValue()) >> 32;
  } else {
    answer = (8589934592 - 1) & reg->getValue();
  }
  debug(Yes) << "extract value adding constant" << answer << "\n";
  addSingleVal(inst, answer, true, true);
  stats.incrementInstructionsFolded();
  return FOLDED;
}

ProcResult ConstantFolding::processCallInst(CallInst * callInst) {

  if(!callInst->getCalledFunction() && !simplifyCallback(callInst)) {
    //TODO: mark all globals as non constant?
    markArgsAsNonConst(callInst);
    return NOTFOLDED;
  }

  Function * calledFunction = callInst->getCalledFunction();
  string name = calledFunction->getName().str();

  if(name == "fork" || name.substr(0,7) == "pthread") {

    if(!disableExit){
        exit = 1;
    }
    return NOTFOLDED;
  }

  if((name=="xmalloc" || name=="xcalloc" || name=="xrealloc" || name=="malloc"|| name=="calloc"|| name=="realloc") && calledFunction->isDeclaration()){

   if (handleHeapAlloc(callInst)){}
   }

  /* specialize for functions defined in string.h e.g strcmp, strchr */
  if(handleDbgCall(callInst)) {}
  else if(handleGetOpt(callInst)) {}
  else if(handleMemInst(callInst)) {}
  else if(handleStringFunc(callInst)) {} 
  else if(handleFileIOCall(callInst)) {} 
  else if(handleSysCall(callInst)) {}
  else if(handleLibCCall(callInst)) {}
  else if(calledFunction->isDeclaration()) {
    debug(Yes) << "skipping function : declaration\n";
    markArgsAsNonConst(callInst);
    return NOTFOLDED;
  } else {
    if (!isFuncInfoInitialized(calledFunction)) {
      FuncInfo *fi = initializeFuncInfo(calledFunction);
      addFuncInfo(calledFunction, fi);
    }

    if((useAnnotations && !satisfyConds(calledFunction, callInst)) || calledFunction->getName().str() == "authmethod_is_enabled" || (exceedLimit  && exceedsRecursion(calledFunction, callInst->getParent()->getParent()))) {
      fSkipped++;
      debug(Yes) << "skipping function : does not satisfy conds\n";

      markArgsAsNonConst(callInst);
      markGlobAsNonConst(calledFunction);

      if(funcSpecMap.find(calledFunction) != funcSpecMap.end()) {
        FuncSpecDetail *detail = funcSpecMap[calledFunction];
        Function *cloned = detail->call->getCalledFunction();
        set<CallInst *> callsToReplace;
        for(auto user: cloned->users()) {
            if(auto CI = dyn_cast<CallInst>(user))
              if(CI->getCalledFunction() != calledFunction && CI->getCalledFunction()->getName().str().find("_clone") != std::string::npos) 
                callsToReplace.insert(CI); 
            
          }

        if(callsToReplace.size() > 0){
            stats.decrementFunctionsCloned();
            }

        for(auto &CI: callsToReplace) {
          debug(Yes) << "putting in original function for instruction " << *CI << "\n";
          CI->setCalledFunction(calledFunction);
          debug(Yes) << "updated call " << *CI << "\n";
        }
      }
      return NOTFOLDED;
    }

    if(funcSpecMap.find(calledFunction) != funcSpecMap.end()) {
      //replace call with old same context copy
      debug(Yes) << "function clone exists with same context. Replaced\n";
      Function *called = funcSpecMap[calledFunction]->call->getCalledFunction();
      callInst->setCalledFunction(called);
    } else { //even if satisfyConds fails, it still goes into this

      CallInst *clonedInst = cloneAndAddFuncCall(callInst); 






      /*
       *
       * Experiment with heuristic to limit Cloning when cloned a function above a specified limit */
      if(exceedLimit && exceedClone(clonedInst->getCalledFunction()->getName(), exceedLimit)){
        debug(Yes) << "skipping function : does not satisfy conds\n";
        markArgsAsNonConst(callInst);
        markGlobAsNonConst(calledFunction);


        //clonedInst->getCalledFunction()->dropAllReferences();
        delete clonedInst;



        if(funcSpecMap.find(calledFunction) != funcSpecMap.end()) {
          FuncSpecDetail *detail = funcSpecMap[calledFunction];
          Function *cloned = detail->call->getCalledFunction();
          set<CallInst *> callsToReplace;
          for(auto user: cloned->users()) {
            if(auto CI = dyn_cast<CallInst>(user))
              if(CI->getCalledFunction() != calledFunction && CI->getCalledFunction()->getName().str().find("_clone") != std::string::npos) 
                callsToReplace.insert(CI); 
            
          }

          if(callsToReplace.size() > 0){
            stats.decrementFunctionsCloned();
            }

          for(auto &CI: callsToReplace) {
            debug(Yes) << "putting in original function for instruction " << *CI << "\n";
            CI->setCalledFunction(calledFunction);
            debug(Yes) << "updated call " << *CI << "\n";
          }
        }
        return NOTFOLDED;
      }

      ReplaceInstWithInst(callInst, clonedInst);

      Memory *context = new Memory(*bbOps.getMemory(currBB)); //make copy of memory
      FuncSpecDetail *detail = new FuncSpecDetail;
      detail->context = context;
      detail->fail = false;
      detail->call = clonedInst;

      if(!contextType){
        debug(Yes)<<"ContextType is 0/NULL...\n";
        funcSpecMap[calledFunction] = detail;
      }
       debug(Yes)<<"in call inst run on function\n";
      runOnFunction(clonedInst, clonedInst->getCalledFunction());
    }
  }
  return UNDECIDED;  
}

string ConstantFolding::removeCloneName(string name) {
  size_t pos = name.find("_clone");
  if(pos == string::npos)
    return name;
  return name.substr(0, pos);
}


bool ConstantFolding::exceedClone(string name, int level){
  //debug(Yes)<<"exceedClone invoked on: "<<name<<" and level: "<<level<<"\n";
  size_t pos = name.find("_clone.");

  if(pos == string::npos){
    return false;
  }

  unsigned len = 0;

  name = name.substr(pos+7);
  std::string::const_iterator it = name.begin();

  while(it != name.end() && std::isdigit(*it)){
    len++;
    it++;
  }

  if(!len)
    return false;

  string numString = name.substr(0,len);

  int num = stoi(numString);

  if(num >= level){
    debug(Yes)<<"exceedClone: "<<name <<" exceeds level "<<level<<"\n";
    return true;
  }


  return false;

}

// If recursion is not folding within 5 recursive function calls, do not further specialize the call site.
bool ConstantFolding::exceedsRecursion(Function *called, Function *callee) {
  string calledName = removeCloneName(called->getName().str());
  string calleeName = removeCloneName(callee->getName().str());

  if(calledName != calleeName)
    return false;

  int max = 5;
  if(worklistBB.size() < max){
      return false;
  }
  //check call stack
  for(unsigned i = worklistBB.size() - 1; i >= max; i--) {
    string func = removeCloneName(worklistBB[i].back()->getParent()->getParent()->getName().str());
    if(func != calledName)
      return false;
  }

  debug(Yes) << "Recursion exceeded" << "\n";
  return true;
}

CallInst *ConstantFolding::cloneAndAddFuncCall(CallInst *callInst) {
  ValueToValueMapTy vmap;
  Function *cloned = cloneFunc(callInst->getCalledFunction(), vmap);
  stats.incrementFunctionsCloned();

  std::vector<Value*> args(callInst->arg_begin(), callInst->arg_end());
  CallInst *clonedCall = createFuncCall(cloned, args);
  return clonedCall;
}

void ConstantFolding::propagateArgs(CallInst *ci, Function *toRun) {
  unsigned index = 0;
  for(auto arg = toRun->arg_begin(); arg != toRun->arg_end();
      arg++, index++) {
    Value * callerVal = ci->getOperand(index);
    Value * calleeVal = getArg(toRun, index);
    /*if(callerVal->getType() != calleeVal->getType()){
       debug(Yes)<< " type mismatched\n";
       IRBuilder<> Builder(ci);
       Value* BitcastInst = Builder.CreateBitCast(callerVal, calleeVal->getType());
       ci->setOperand(index,BitcastInst);
       Register * reg = processInstAndGetRegister(callerVal);
       regOps.addRegister(BitcastInst, BitcastInst->getType(), reg->getValue(), reg->getTracked());
       replaceOrCloneRegister(calleeVal, BitcastInst);
       continue;
       
    }*/
    replaceOrCloneRegister(calleeVal, callerVal);
  }
}

void ConstantFolding::copyCallerContext(CallInst * ci, Function * toRun) {
  BasicBlock * entry = &toRun->getEntryBlock();
  duplicateContext(entry, currBB);    
  updateAnnotationContext(ci->getCalledFunction());
}


bool ConstantFolding::cloneRegister(Value * from, Value * with) {
  debug(Yes) << "attempting to copy Register for " << *with << "\n";

  // if this is a constant string, allocate memory for it
  handleConstStr(with);
  uint64_t val;
  if(!getSingleVal(with, val)) {
    debug(Yes) << "failed to create Register\n";
    return false;
  }
  pushFuncStack(from);

  //addSingleVal(with, val, true, true);
  regOps.addRegister(from, from->getType(), val, true);
  return true;
}


bool ConstantFolding::replaceOrCloneRegister(Value * from, Value * with) {
  debug(Yes) << "attempting to copy Register for " << *with << "\n";

  // if this is a constant string, allocate memory for it
  handleConstStr(with);

  Type * ty = from->getType();
  if(isa<ConstantInt>(with)) {
    replaceIfNotFD(from, with);
    debug(Yes) << "replaced with constantInt\n";
  } else if(isa<ConstantPointerNull>(with)) {
    replaceIfNotFD(from, with);
    debug(Yes) << "replaced with NULL pointer\n";
  } else if(Register * reg = processInstAndGetRegister(with)) {
    pushFuncStack(from);
    regOps.addRegister(from, ty, reg->getValue(), reg->getTracked());    
    debug(Yes) << "Register from Register\n";
  } else {   
    debug(Yes) << "failed to simplify\n";
    return false;
  }
  return true;
}

void ConstantFolding::replaceUses() {
  for(unsigned i = 0; i < toReplace.size(); i++) {
    pair<Instruction *, Instruction *> cp = toReplace[i];
    Instruction * oldI = cp.first;
    Instruction * newI = cp.second; 
    BasicBlock::iterator inst = BasicBlock::iterator(oldI);
    oldI->getParent()->getInstList().insert(inst, newI);
    oldI->replaceAllUsesWith(newI); 
    oldI->eraseFromParent();
  }
}

void ConstantFolding::deleteFileIOCalls() {
  for (map<uint64_t,FileInsts*>::iterator it=fileIOCalls.begin(); it!=fileIOCalls.end(); ++it){
    bool isSpecialized = (it->second)->isSpecialized;
    if(isSpecialized == true){
      for(int i = (it->second)->insertedSeekCalls.size() -1; i >= 0; i--) {  
        (it->second)->insertedSeekCalls[i]->eraseFromParent();  
      } 
    }
    vector<Instruction*> insts = (it->second)->insts;
    for(int i = insts.size() -1; i >= 0; i--) {
      debug(Yes) << "insts  " << dyn_cast<CallInst>(insts[i])->getCalledFunction()->getName().data() <<insts[i]->getNumUses()<<dyn_cast<CallInst>(insts[i])->getParent()->getParent()->getName()<<"\n"; 
      if(insts[i]->getNumUses() > 0){
        CallInst *Inst = dyn_cast<CallInst>(insts[i]); 
        if(strcmp(Inst->getCalledFunction()->getName().data(),"open")==0){
          llvm::Type * type = llvm::IntegerType::getInt32Ty(module->getContext());
          llvm::Constant *zeroVal = llvm::ConstantInt::get(type, 0, true);  
          insts[i]->replaceAllUsesWith(zeroVal);
        } 
        else if(strcmp(Inst->getCalledFunction()->getName().data(),"fopen")==0){              
          ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(insts[i]->getType()));     
          insts[i]->replaceAllUsesWith(nullP);
        } 
      }
      insts[i]->eraseFromParent();
    }   
  }
}

void ConstantFolding::markArgsAsNonConst(CallInst * callInst) {
  Function* calledFunction = callInst->getCalledFunction();
  if(calledFunction && checkIfReadOnlyFunc(calledFunction))
    return;
  if(calledFunction && calledFunction->onlyReadsMemory()) {
    return;
  }
  for(unsigned index = 0; index < callInst->getNumArgOperands(); index++) {
    Value * val = callInst->getOperand(index);
    Register * reg = processInstAndGetRegister(val);
    if(!reg)
      continue;

    if(val->getType()->isPointerTy())
      markMemNonConst(dyn_cast<PointerType>(val->getType())->getElementType(), reg->getValue(), currBB);

  }
}

void ConstantFolding::initializeGlobal(uint64_t addr, Constant * CC) {

  /* already initialize with zero */
  if(!CC)
    return;

  if(isa<ConstantPointerNull>(CC))
    return;    

  if(isa<ConstantAggregateZero>(CC))
    return;
  ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(CC);
  if(auto gv = dyn_cast<GlobalVariable>(CC)) {
    uint64_t address = addGlobal(gv);
    bbOps.storeToMem(address, DL->getPointerSize(), addr, currBB);
    return;
  }

  debug(Yes) << "Global Value" << dyn_cast<GlobalValue>(CC) << "\n";
  debug(Yes) << "Constant expr" << dyn_cast<ConstantExpr>(CC) << "\n";
  if(CDA && CDA->isString()) {
    char * source = (char *) bbOps.getActualAddr(addr, currBB);
    string str = CDA->getAsString().str();  
    int size = str.size();
    memcpy(source, str.c_str(), size);
    debug(Yes) << "storing : size " << size << " at address " << addr << " " << *CC << "\n";
  } else if(ConstantInt * CI = dyn_cast<ConstantInt>(CC)) {
    uint64_t size = DL->getTypeAllocSize(CI->getType());
    bbOps.storeToMem(CI->getZExtValue(), size, addr, currBB);    
    debug(Yes) << "storing : size " << size << " at address " << addr << " " << *CC << "\n";
  } else if(ConstantExpr * CE = dyn_cast<ConstantExpr>(CC)) {
    /* 1. either we have it in memory in which case runOnInst will work*/
    /* 2. we dont have it in memory but its a constant string - need to allocate new memory */
    /* 3. points to something which is not in memory */
    Instruction * I = dyn_cast<ConstantExpr>(CE)->getAsInstruction();
    assert(I);
    assert(I->getOperand(0));
    StringRef stringRef;
    if(handleConstStr(I->getOperand(0))) {
      uint64_t newAddr = processInstAndGetRegister(I->getOperand(0))->getValue();
      int size = DL->getTypeAllocSize(CE->getType());
      bbOps.storeToMem(newAddr, size, addr, currBB);
      debug(Yes) << "storing address " << newAddr << " at pointer " << addr << " size " << size << "\n";
    } else if(Register * reg = processInstAndGetRegister(I)) {
      uint64_t newAddr = reg->getValue();
      int size = DL->getTypeAllocSize(CE->getType());
      bbOps.storeToMem(newAddr, size, addr, currBB);
      debug(Yes) << "storing address " << newAddr << " at pointer " << addr << " size " << size << "\n";                  
    } 
    I->dropAllReferences();
  } else if(Function * callback = dyn_cast<Function>(CC)) {
    // store its address
    int size = DL->getTypeAllocSize(callback->getType());
    uint64_t faddr = (uint64_t) callback;
    bbOps.storeToMem(faddr, size, addr, currBB);
    debug(Yes) << "stored callback for function " << callback->getName() << "\n";
  } else if(ConstantStruct *cStruct = dyn_cast<ConstantStruct>(CC)) {
    for(unsigned i = 0; i < cStruct->getNumOperands(); i++) {
      Constant * CGI = CC->getAggregateElement(i);
      auto layout = DL->getStructLayout(cStruct->getType());
      initializeGlobal(addr + layout->getElementOffset(i), CGI);
    }
  } else {
    for(unsigned i = 0; i < CC->getNumOperands(); i++) {
      Constant * CGI = CC->getAggregateElement(i);
      //debug(Yes) << "CGI: " << *CGI << "\n CC: " << *CC << "\n";
      if(!CGI) {
        debug(Yes) << "initializeGlobal: (Warning) aggregate element not found\n";
        return;
      }
      initializeGlobal(addr, CGI);
      addr += DL->getTypeAllocSize(CGI->getType());
    }
  }
}

uint64_t ConstantFolding::addGlobal(GlobalVariable* gv){
  debug(Yes) << gv->getName() << "\n"; 

  if(Register *reg = regOps.getRegister(gv))
    return reg->getValue();

  if(gv->getName() == "stdin" || gv->getName() == "stderr" || gv->getName() == "stdout")
    return 0;

  Type* contTy = gv->getType()->getContainedType(0);

  uint64_t size = DL->getTypeAllocSize(contTy);
  uint64_t addr = bbOps.allocateStack(size, currBB);
  debug(Yes) << "addGlobal : size " << size << " at address " << addr << "\n";
  //pushFuncStack(gv);
  bool tracked = !!gv->getMetadata("track");
  regOps.addRegister(gv, contTy, addr, tracked);

  if(gv->hasInitializer()) 
    initializeGlobal(addr, gv->getInitializer());

  return addr;
}

// important globals : optind, optarg, __argv_new__
void ConstantFolding::addGlobals() {
  for(auto& global : module->globals()) { 
    if(!regOps.getRegister(&global))
      addGlobal(&global);
  }

  //add libc __progname global variable
  GlobalVariable *__progName = module->getGlobalVariable(StringRef("__progname"));
  if (progName.size() && __progName) {
    uint64_t addr = bbOps.allocateStack(progName.size() + 1, currBB);
    char *address = (char *) bbOps.getActualAddr(addr, currBB);
    strcpy(address, &progName[0]);
    uint64_t doubleAddress = bbOps.allocateStack(DL->getPointerSize(), currBB);
    bbOps.storeToMem(addr, DL->getPointerSize(), doubleAddress, currBB);
    regOps.addRegister(__progName, __progName->getType()->getContainedType(0), doubleAddress, 1);
  }
}

bool ConstantFolding::getPointerAddr(Value * val, uint64_t& addr) {
  if(Register * reg = processInstAndGetRegister(val)) {
    addr = reg->getValue();
    return true;
  }
  if(isa<ConstantPointerNull>(val)) {
    addr = 0;
    return true;
  }
  return false;
}

CmpInst * ConstantFolding::foldCmp(CmpInst * CI) {
  Value * oldLHS = CI->getOperand(0);
  Value * oldRHS = CI->getOperand(1);
  uint64_t lAddr, rAddr;
  if(getPointerAddr(oldLHS, lAddr) && 
      getPointerAddr(oldRHS, rAddr)) {
    IntegerType * intTy = IntegerType::get(module->getContext(), 64);
    Value * newLHS = ConstantInt::get(intTy, lAddr);
    Value * newRHS = ConstantInt::get(intTy, rAddr);
    CmpInst * NCI = CmpInst::Create(CI->getOpcode(), CI->getPredicate(),
        newLHS, newRHS);
    NCI->insertBefore(CI);
    debug(Yes) << *CI << " ";
    replaceIfNotFD(CI, NCI);
    return NCI;
  }
  return NULL;
}

Instruction * ConstantFolding::simplifyInst(Instruction * I) {
  for(unsigned i = 0; i < I->getNumOperands(); i++) {
    Value * val = I->getOperand(i);
    if(Register * reg = processInstAndGetRegister(val)) {
      if(IntegerType * intTy = dyn_cast<IntegerType>(val->getType()))
        replaceIfNotFD(val, ConstantInt::get(intTy, reg->getValue()));
    }
  }
  if(isa<CmpInst>(I) &&
      isa<PointerType>(I->getOperand(0)->getType()))     
    return foldCmp(dyn_cast<CmpInst>(I));
  else if(auto CI = dyn_cast<CmpInst>(I)) {
    for(unsigned i = 0; i < CI->getNumOperands(); i++) {
      Value *val = CI->getOperand(i);
      uint64_t sfd;
      if(getSingleVal(val, sfd) && fdInfoMap.find(sfd) != fdInfoMap.end()) {
        debug(Yes) << "foldCmp: folding for file descriptor\n";
        CI->setOperand(i, ConstantInt::get(CI->getOperand(0)->getType(), sfd));
      }
    }
  }
  else if(SelectInst * SI = dyn_cast<SelectInst>(I)) {
    if(ConstantInt * CI = dyn_cast<ConstantInt>(SI->getCondition())) {
      Value * rep = CI->getZExtValue() ? SI->getTrueValue() : SI->getFalseValue();
      replaceOrCloneRegister(I, rep);
    } else {
      //non constant select, mark mem non constant appropriately
      markInstMemNonConst(SI);
    }
  }
  return NULL;
}

void ConstantFolding::createAnnotationList() {
  GlobalVariable * annotVar = module->
    getGlobalVariable(StringRef("llvm.global.annotations"));

  assert(annotVar && "isAnnotated and annotVar not found");

  Constant * initializer = annotVar->getInitializer();
  ArrayType * aty = dyn_cast<ConstantArray>(initializer)->getType();
  unsigned num = aty->getNumElements();
  for(unsigned i = 0; i < num; i++) {
    Constant * t1 = initializer->getAggregateElement(i);
    Constant * t2 = t1->getAggregateElement((unsigned) 0);
    Value * val;
    if(isa<GlobalVariable>(t2))
      val = t2;
    else if(Instruction * I = dyn_cast<ConstantExpr>(t2)->getAsInstruction()) {
      val = dyn_cast<User>(I)->getOperand(0);
      I->dropAllReferences();
    } else 
      continue;

    debug(Yes) << val->getName() << " will be tracked\n";
    AnnotationList.insert(val);
    StringRef stringRef;
  }
}

void ConstantFolding::createAnnotationList2() {
  vector<string> globs, funcs;
  GlobalVariable * ggv = module->getNamedGlobal("__tracked_globals__");
  if(ggv) {
    ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(ggv->getInitializer());
    split(CDA->getAsString(), globs, ';');
  }
  GlobalVariable * fgv = module->getNamedGlobal("__tracked_funcs__");
  if(fgv) {
    ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(fgv->getInitializer());
    split(CDA->getAsString(), funcs, ';');
  }
  for(unsigned i = 0; i < globs.size(); i++) {
    GlobalValue * gv = module->getNamedValue(StringRef(globs[i]));
    debug(Yes) << globs[i] << " : glob " << "\n";
    AnnotationList.insert(gv);
  }
  for(unsigned i = 0; i < funcs.size(); i++) {
    GlobalValue * gv = module->getNamedValue(StringRef(funcs[i]));
    debug(Yes) << funcs[i] << " : func " << "\n";
    AnnotationList.insert(gv);    
  }
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

bool ConstantFolding::isAllocaTracked(Instruction *I) {
  if(trackAllocas && !I->getMetadata("track"))
    return false;
  return true;
}

bool ConstantFolding::isFuncInfoInitialized(Function *F) {
  return fimap.find(F) != fimap.end();
}

void ConstantFolding::addFuncInfo(Function *F, FuncInfo *fi) {
  fimap[F] = fi;
}

FuncInfo* ConstantFolding::initializeFuncInfo(Function *F) {

  FuncInfo * fi = new FuncInfo(F);
  fi->directCallInsts = 0;
  fi->calledInLoop = false;

  for(Use &U : F->uses()) {
    User * FU = U.getUser();
    if(CallInst * ci = dyn_cast<CallInst>(FU)) {
      if(!ci->getParent())
        continue;

      fi->directCallInsts++;
    }
  }

  return fi;
}

bool ConstantFolding::hasTrackedMalloc(Function *F) {
  for(auto &BB: *F)
    for(auto &I: BB)
      if(isAllocaTracked(&I) && isa<CallInst>(&I))
        return true;

  return false;
}

// This function is used to decide whether to specialize the function or not. 
/* If contextType ==2 i.e. context-sensitive, then return true i.e. to specialize each call site of the function.
If contextType == 0 i.e. context-insensitive, then check whether the function has already specialized or not. If already specialized and 
the context (argument) matches, then replace the callsite to call the specialized functions, else do not clone the function again and replace call site already
specialized with original function call.
If contextType==1, then check its arguments. If one of the arguments is tracked (by annotation pass), then specialize the function and return true.

*/

bool ConstantFolding::satisfyConds(Function * F, CallInst *ci) {
  if(contextType == 2)
    return true;

  if(!contextType) {
    if(funcSpecMap.find(F) != funcSpecMap.end()) {
      //has a specialized copy already
      FuncSpecDetail *detail = funcSpecMap[F];
      if(detail->fail) {
        debug(Yes) << "(SATISFYCONDS) << test already failed\n";
        return false; // this is actually false
      }

      if(bbOps.contextMatch(detail->context, currBB)) {
        //check arguments match
        for(unsigned i = 0; i < ci->getNumOperands(); i++) {
          Value *current = ci->getOperand(i);
          Value *old = detail->call->getOperand(i);

          if(dyn_cast<Constant>(current) && dyn_cast<Constant>(old) && current == old)
            continue;

          Register *currentReg = processInstAndGetRegister(current);
          Register *oldReg = processInstAndGetRegister(old);

          if(!currentReg || !oldReg || currentReg->getValue() != oldReg->getValue()) {
            debug(Yes) << "arguments do not match\n";
            return false;
          }
        }
        debug(Yes) << "(SATISFYCONDS) can replace call with call to the old function\n";
        return true;
      }

      debug(Yes) << "(SATISFYCONDS) contexts do not match\n";
      funcSpecMap[F]->fail = true;
      return false;
    } else {
      debug(Yes) << "(SATISFYCONDS) first call\n";
      return true; 
    }
  }



  if(F->hasFnAttribute("track_func")) {
    debug(Yes) << "(LOG) (SATISFYCONDS) satisfied specializing conditions due to track_func\n";
    return true;
  }

  if(fimap.find(F) == fimap.end()){
    debug(Yes) << " not found in map\n";
    return false;
  }
  FuncInfo* fi = fimap[F];  
  if(trackAllocas) {
    //if any argument is being tracked 
    for(unsigned i = 0; i < ci->getNumArgOperands(); i++) {
      Value *argument = ci->getArgOperand(i);
      if(Register *reg = processInstAndGetRegister(argument)) { //dyn_cast<Constant>(argument) || 
        if(reg->getTracked()) {
          //FIXME: Properly break lines - Lines can NOT exceed 80 chars (soft engr practice)
          debug(Yes) << "(LOG) (SATISFYCONDS) Call " << *ci << " satisfied specializing conditions due to argument " <<  *argument << " at index " << i << "\n";
          return true;
        }
      }
    }

    set<GlobalVariable *> &modData = getFuncModset(F);


    if(useGlob){
    	for(auto &modD: modData) {
      		if(modD->isConstant())
        		continue;
      		if(trackedValues.find(modD) != trackedValues.end()) {
        		debug(Yes) << "(LOG) (SATISFYCONDS) Call " << *ci << " satisfied specializing conditions due to modset" << "\n";
        		return true;
      		}
    	}
   }

    //if function has a malloc
    if(hasTrackedMalloc(F))
      return true;

    debug(Yes) << "(LOG) (SATISFYCONDS) Call " << *ci << " does not meet specializing conditions" << "\n";
    return false;
  } else {
    if(AnnotationList.find(F) != AnnotationList.end()) 
      return true;
    bool dr = fi->directCallInsts > 1;
    debug(Yes) << "(LOG) (SATISFYCONDS) Call " << fi->calledInLoop <<" "<<fi->addrTaken <<" "<<dr<<"\n";
    return !(fi->calledInLoop || fi->addrTaken || fi->directCallInsts > 1); 
  }
}

/**
 * Since we can't replace pointers in IR, we make internal
 * registers for pointers. Otherwise, if constant integer,
 * replace in IR. (Temporarily not replacing 64 bit integers
 * due to potentially replacing casted pointers in IR)
 */
void ConstantFolding::addSingleVal(Value * val, uint64_t num, bool replace64, bool tracked) {
  Type * ty = val->getType();
  if(ty->isPointerTy()) {
    if(!num) {
      debug(Yes) << "replacing with null\n";
      ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
      replaceIfNotFD(val, nullP);
    } else {
      debug(Yes) << "adding Register\n";
      pushFuncStack(val);
      regOps.addRegister(val, ty, num, tracked); 
    }
  } else if(IntegerType * intTy = dyn_cast<IntegerType>(ty)) {
    if(replace64 || !ty->isIntegerTy(64)) {
      debug(Yes) << "replacing with constant int\n";
      replaceIfNotFD(val, ConstantInt::get(intTy, num));
    } else {
      regOps.addRegister(val, ty, num, tracked);
    }
  }
}

bool ConstantFolding::getSingleVal(Value * val, uint64_t& num) {
  if(ConstantInt * CI = dyn_cast<ConstantInt>(val)) 
    num =  CI->getZExtValue();
  else if(isa<ConstantPointerNull>(val))
    num = 0;
  else if(Register * reg = processInstAndGetRegister(val)) 
    num = reg->getValue();
  else if(Constant * CC = dyn_cast<Constant>(val)){
    if(Function * callback = dyn_cast<Function>(CC)) {
    // store its address
    int size = DL->getTypeAllocSize(callback->getType());
    uint64_t addr = bbOps.allocateStack(size,currBB);
    uint64_t faddr = (uint64_t) callback;
    bbOps.storeToMem(faddr, size, addr, currBB);
    debug(Yes) << "stored callback for function " << callback->getName() << "\n";
    num = faddr;
  }
  }
  else
    return false;  
  
  return true;
}

bool ConstantFolding::getStr(uint64_t addr, char *& str) {
  if(!bbOps.checkConstContigous(addr, currBB)) {
    debug(Yes) << "getStr : ptr not constant\n";
    return false;   
  }
  str = (char *) bbOps.getActualAddr(addr, currBB);
  return true;
}

bool ConstantFolding::getStr(Value * ptr, char *& str, uint64_t size) {
  StringRef stringRef;
  if(getConstantStringInfo(ptr, stringRef, 0, false)) {
    str = new char[stringRef.str().size()];
    strcpy(str, stringRef.str().c_str());
  } else if(Register * reg = processInstAndGetRegister(ptr)) {
    if(!bbOps.checkConstMem(reg->getValue(), size, currBB)) {
      debug(Yes) << "getStr : ptr not constant\n";
      return false;   
    }
    str = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  } else {
    debug(Yes) << "getStr : ptr not found in Map\n";
    return false;   
  }
  return true;
}

uint64_t ConstantFolding::createConstStr(string str) {
  uint64_t size = str.size();
  uint64_t newAddr = bbOps.allocateHeap(size, currBB);
  char * source = (char *) bbOps.getActualAddr(newAddr, currBB);
  memcpy(source, str.c_str(), size);  
  debug(Yes) << "created new constant string " << str << " at address " << newAddr << "\n";
  return newAddr;
}

bool ConstantFolding::handleConstStr(Value * ptr) {
  StringRef stringRef;
  if(getConstantStringInfo(ptr, stringRef, 0, false)) { 
    regOps.addGlobalRegister(ptr, ptr->getType(), createConstStr(stringRef.str()));
    return true;
  }  
  return false;
}


bool ConstantFolding::isFileDescriptor(Value *value) {
  if (ConstantInt *CI = dyn_cast<ConstantInt>(value)) {
    uint64_t val = CI->getZExtValue();
    return fdInfoMap.find(val) != fdInfoMap.end();
  }
  return false;
}

/**
 * Replaces all uses of a value with another value
 */
void ConstantFolding::replaceIfNotFD(Value * from, Value * to) {
  if(!from || !to)
    return;

  if(isFileDescriptor(to)) {
    ConstantInt *CI = dyn_cast<ConstantInt>(to);
    uint64_t val = CI->getZExtValue();
    pushFuncStack(from);
    regOps.addRegister(from, from->getType(), val, true); //track set to true since we only have fds for config files
    return;
  }

  from->replaceAllUsesWith(to);
  if(Register *reg = regOps.getRegister(from))
    if(reg->getTracked()) 
      debug(Yes) << "replaced with " << *to << "\n";
  //if(Instruction * I = dyn_cast<Instruction>(from))
  //updateLoopCost(FOLDED, I);
}

Function *ConstantFolding::simplifyCallback(CallInst * callInst) {
  Register * reg = processInstAndGetRegister(callInst->getCalledValue());
  if(!reg) return NULL;
  Function * calledFunction = (Function *) reg->getValue();
  //auto CE = dyn_cast<ConstantExpr>(callInst->getCalledValue());
  callInst->setCalledFunction(calledFunction);
  debug(Yes) << "set called Function to " << calledFunction->getName() << "\n";
  return calledFunction;
}

bool ConstantFolding::handleHeapAlloc(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(name == "malloc" || name=="xmalloc")      processMallocInst(callInst);
  else if(name == "calloc" || name=="xcalloc") processCallocInst(callInst);
  else if(name == "realloc"|| name=="xrealloc") processReallocInst(callInst);
  else  return false;
  return true;
}

ProcResult ConstantFolding::processReallocInst(CallInst *ci) {
  if(!ci){
    debug(Yes)<<"processReallocInst ci is null!\n";
  }
  stats.incrementTotalLibCalls();
  Value *ptr = ci->getOperand(0);
  ConstantInt *size = dyn_cast<ConstantInt>(ci->getOperand(1));
  Register *reg = processInstAndGetRegister(ptr);

  if(!reg || !ptr || !size) {
    debug(Yes) << "realloc: register not found or size not constant\n";
    return NOTFOLDED;
  }

  //@TODO not going to actually realloc. just allocate more memory. Warning, memory leak
  uint64_t addr = bbOps.allocateHeap(size->getZExtValue(), currBB);
  char *oldAddr = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  uint64_t size_old = bbOps.getSizeContigous(reg->getValue(), currBB);
  debug(Yes) << "realloc: copying over memory size: " << size_old << "\n";
  memcpy((void *) bbOps.getActualAddr(addr, currBB), (void *) oldAddr, size_old);
  addSingleVal(ci, addr, false, true);
  debug(Yes) << "realloc processed successfully\n";
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  return FOLDED;
}

bool ConstantFolding::processMallocUsableSize(CallInst *callInst) {
  return false;
  Value *val = callInst->getOperand(0);

  Register *reg = processInstAndGetRegister(val);

  if(!reg) {
    debug(Yes) << "malloc_usable_size, failed to find register \n";
    return false;
  }

  uint64_t address = reg->getValue();
  void *pointer = bbOps.getActualAddr(address, currBB);
  debug(Yes) << "malloc_usable_size: address " << pointer << "\n";
  size_t size = malloc_usable_size(pointer);
  debug(Yes) << "malloc_usable_size: result " << size << "\n";
  addSingleVal(callInst, size, true, true);
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleMemInst(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(name == "memset" || name == "__memset_chk")      processMemSetInst(callInst);
  else if(name == "memcpy") processMemcpyInst(callInst);
  else if(name == "malloc_usable_size") processMallocUsableSize(callInst);
  else  return false;
  return true;  
}

// FIXME: Do not understand what this does.
bool ConstantFolding::handleDbgCall(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(name == PRNTDBGSTR) {
    for(unsigned i = 0; i < callInst->getNumArgOperands(); i++) {
      Value * ptrVal = callInst->getOperand(i);
      char * str;
      if(getStr(ptrVal, str, 100)) debug(Yes) << str;
    }
  } else if(name == SETDBGLEVEL) {
    Value * lVal = callInst->getOperand(0);
    if(ConstantInt * cint = dyn_cast<ConstantInt>(lVal)) {
      debugLevel = cint->getZExtValue();
      debug(Yes) << "set debugLevel to " << debugLevel << "\n";
    }
  } else return false;
  stats.incrementInstructionsFolded();
  return true;
}

void ConstantFolding::visitReadyToVisit(vector<BasicBlock *> readyToVisit) {
  
  for(unsigned i = 0; i < readyToVisit.size(); i++) {
    BasicBlock * BB = readyToVisit[i];
    BasicBlock * pred = bbOps.getRfromPred(BB);
    assert(pred != NULL);
    if(pred == NULL) { //unreachable blocks only
      continue;
    }
     visitBB(BB, pred);
  }
}

/**
 * Appropriately mirrors or duplicates succ BasicBlock, based on the
 * predecessor BasicBlock from. Also frees the predecessor if possible,
 * simplifies loops in succ, and runs runOnBB on successor
 */
bool ConstantFolding::visitBB(BasicBlock * succ, BasicBlock *  from) {
  if(bbOps.needToduplicate(succ, from)) {
    debug(Yes) << "duplicating\n";
    debug(Yes) << "duplicating from " << from->getName() << " to " << succ->getName();
    duplicateContext(succ, from);
    bbOps.mergeContext(succ, from);
    checkPtrMemory(succ);
  } else {
    debug(Yes) << "cloning\n";
    bbOps.imageContext(succ, from);
  }    

   bbOps.addAncestor(succ, from);
  bbOps.freeBB(from);

  addToWorklistBB(succ);

  return true;
}

//File StringUtils.cpp

// FIXME: bad naming? handleStrStr reveals nothing about the function. Rename appropriately
bool ConstantFolding::handleStrStr(CallInst *callInst) {
  Value *val1 = callInst->getOperand(0);
  Value *val2 = callInst->getOperand(1);

  Register *reg1 = processInstAndGetRegister(val1);
  Register *reg2 = processInstAndGetRegister(val2);

  if(!reg1) {
    debug(Yes) << "handleStrStr, argument one not found in map" << "\n";
    return false;
  }

  if(!reg2) {
    debug(Yes) << "handleStrStr, argument two not found in map" << "\n";
    return false;
  }

  if(!bbOps.checkConstContigous(reg1->getValue(), currBB) || !bbOps.checkConstContigous(reg2->getValue(), currBB)) {
    debug(Yes) << "handleStrStr, one of the arguments is non constant \n";
    return false;
  }

  char * buffer1 = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);
  char * buffer2 = (char *) bbOps.getActualAddr(reg2->getValue(), currBB);
  char *result = strstr(buffer1, buffer2);
  stats.incrementLibCallsFolded();

  if(!result) {
    addSingleVal(callInst, 0, true, true);
    return false;
  }
  debug(Yes) << "result = "<< result << "\n";
  debug(Yes) << "buffer1 = "<<buffer1 << "\n";
  debug(Yes) << "buffer2 = "<<buffer2 << "\n";

  uint64_t size = strlen(result);
  uint64_t address = bbOps.allocateHeap(size, currBB);
  char *pointer = (char *) bbOps.getActualAddr(address, currBB);

  strcpy(pointer, result);
  addSingleVal(callInst, address, true, true);
  stats.incrementInstructionsFolded();
  return true;
}

bool ConstantFolding::handleStrSep(CallInst *callInst) {
  Value *arg1 = callInst->getOperand(0);
  Value *arg2 = callInst->getOperand(1);
  Register *reg1 = processInstAndGetRegister(arg1);
  Register *reg2 = processInstAndGetRegister(arg2);

  if(!reg1 || !reg2) {
    debug(Yes) << "strsep: one of the registers not found \n";
    return false;
  }

  char *delim;
  if(!bbOps.checkConstMem(reg1->getValue(), DL->getPointerSize(), currBB) || !getStr(reg2->getValue(), delim)) {
    debug(Yes) << "strsep: non constant register \n";
    return false;
  }

  uint64_t stringpAddr = bbOps.loadMem(reg1->getValue(), DL->getPointerSize(), currBB);
  if(!stringpAddr) {
    addSingleVal(callInst, 0, true, true);
    debug(Yes) << "strsep returned null\n";
    return true;
  }
  debug(Yes) << "stringpAddr: " << stringpAddr << "\n";
  char *string;
  if(!getStr(stringpAddr, string)) {
    debug(Yes) << "strsep: string not constant\n";
    return false;
  }
  char **stringp = &string;
  char *stringCopy = string;
  char *result = strsep(stringp, delim);

  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();

  addSingleVal(callInst, stringpAddr, true, true);
  if(*stringp)
    bbOps.storeToMem(stringpAddr + (stringCopy - *stringp), DL->getPointerSize(), reg1->getValue(), currBB);
  else {
    bbOps.storeToMem(0, DL->getPointerSize(), reg1->getValue(), currBB);
    debug(Yes) << "after storing null: " << bbOps.loadMem(reg1->getValue(), DL->getPointerSize(), currBB) << "\n";
    debug(Yes) << "storing null" << "\n";
  }
  //addSingleVal(arg1, reg1->getValue() + (stringpCopy - stringp), true, true); //@TODO memory leak for register overwriting
  debug(Yes) << "strsep: returned " << result << "\n";
  return true;
}

void ConstantFolding::handleStrTol(CallInst *call) {
  Value *arg1 = call->getOperand(0);
  Value *arg2 = call->getOperand(1);
  Value *arg3 = call->getOperand(2);

  Register *reg1 = processInstAndGetRegister(arg1),
           *reg2 = processInstAndGetRegister(arg2);

  if(!reg1 || !reg2) {
    debug(Yes) << "strtol: one of the registers not found\n";
    return;
  }

  char *str;
  char **endptr = NULL;
  char *strStart = NULL;
  int base;
  if(!getStr(reg1->getValue(), str)) {
    debug(Yes) << "strtol: string non constant\n";
    return;
  }

  strStart = str;
  if(!dyn_cast<ConstantInt>(arg2)) {
    char *endptrAddr = (char *) bbOps.getActualAddr(bbOps.loadMem(reg2->getValue(), DL->getPointerSize(), currBB), currBB);
    endptr = &endptrAddr;
  }

  if(auto constant = dyn_cast<ConstantInt>(arg3)) {
    base = constant->getZExtValue(); 
  } else {
    debug(Yes) << "strtol: base not constant\n";
    return;
  }

  long int answer = strtol(str, endptr, base);

  if(endptr) {
    debug(Yes) << "strtol: moved endptr forward by: " << *endptr - strStart << "\n";
    uint64_t newEndPtr = reg1->getValue() + (*endptr - strStart);
    bbOps.storeToMem(reg2->getValue(), DL->getPointerSize(), newEndPtr, currBB);
  }
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  addSingleVal(call, answer, true, true);
  return;
}

void ConstantFolding::handleStrnCpy(CallInst *callInst) {
  Value *dest = callInst->getOperand(0);
  Value *src = callInst->getOperand(1);
  ConstantInt *ci = dyn_cast<ConstantInt>(callInst->getOperand(2));

  Register *reg1 = processInstAndGetRegister(dest);
  Register *reg2 = processInstAndGetRegister(src);


  if (!reg1){
      debug(Yes)<<"strncpy: destination not found\n";
      return;
  }

  if(!reg2 || !bbOps.checkConstContigous(reg2->getValue(), currBB)) {
    debug(Yes) << "strncpy: source not found or non const\n";
    return;
  }

  if(!ci) {
    debug(Yes) << "strncpy: n not constant\n";
    return;
  }

  if(!dest) {
    debug(Yes) << "strncpy: dest register not found\n";
    return;
  }

  char *destAddr = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);
  char *srcAddr = (char *) bbOps.getActualAddr(reg2->getValue(), currBB);

  strncpy(destAddr, srcAddr, ci->getZExtValue());
  stats.incrementLibCallsFolded();

  debug(Yes) << "strncpy: folded, dest string = " << destAddr << "\n";
  stats.incrementInstructionsFolded();
  return;
}

bool ConstantFolding::handleStringFunc(CallInst * callInst) {

  if(!stringSpecialize)
    return false;
  string name = callInst->getCalledFunction()->getName();

  if(name == "strtol") handleStrTol(callInst);
  else if(name == "strncpy") handleStrnCpy(callInst);
  else if(simpleStrFunc(name))   simplifyStrFunc(callInst);
  else if(name == "strcasecmp") handleStrCaseCmp(callInst);
  else if(name == "strchr") handleStrChr(callInst);
  else if(name == "strpbrk")handleStrpbrk(callInst);
  else if(name == "atoi")   handleAtoi(callInst);
  else if(name == "strdup" || name == "__strdup" || name == "xstrdup" || name == "strndup")   handleStrDup(callInst);
  else if(name == "strtok")   handleStrTok(callInst);
  else if(name == "strcpy") handleStrCpy(callInst);
  else if(name == "strrchr") handleStrrChr(callInst);
  else if(name == "strcat") handleStrCat(callInst);
  else if(name == "strstr") handleStrStr(callInst);
  else if(name == "strsep") handleStrSep(callInst);
  else if(name == "__ctype_b_loc")  handleCTypeFuncs(callInst);
  else if(name == "c_isspace") handleCIsSpace(callInst); 
  else if(name == "c_isalnum") handleCIsalnum(callInst);
  else if(name == "c_tolower") handleCToLower(callInst);
  else if(name == "c_isdigit") handleCIsDigit(callInst);
  else return false;

  stats.incrementTotalLibCalls();
  return true;
}




// FIXME: Do not understand what this does and why is this important. Add proper comment
void ConstantFolding::handleCTypeFuncs(CallInst * callInst) {

  traitsTable = *(__ctype_b_loc());
  pushFuncStack(callInst);
  regOps.addRegister(callInst,callInst->getType(),999999999);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();

}

void ConstantFolding::handleStrrChr(CallInst *callInst) {
  Value *str = callInst->getOperand(0);
  Value *chr = callInst->getOperand(1);

  char *string;
  uint64_t character;
  Register *strReg = processInstAndGetRegister(str);

  if(!strReg) {
    debug(Yes) << "handleStrrChr: string not found\n";
    return;
  }

  if(!getStr(strReg->getValue(), string)) {
    debug(Yes) << "handleStrrChr: string not constant\n";
    return;
  }

  if(!getSingleVal(chr, character)) {
    debug(Yes) << "handleStrrChr: failed to find character\n";
    return;
  }

  char *result = strrchr(string, (int) character); 
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  debug(Yes) << "handleStrrChr: successfully folded \n";
  if(!result) {
    addSingleVal(callInst, 0, false, true);
    return;
  }

  addSingleVal(callInst, (uint64_t) strReg->getValue() + (result - string), false, true);
  return;
}

void ConstantFolding::handleStrCpy(CallInst *callInst) {
  Value *dest = callInst->getOperand(0);
  Value *src = callInst->getOperand(1);

  Register *srcReg = processInstAndGetRegister(src);
  Register *destReg = processInstAndGetRegister(dest);
  if(!srcReg || !bbOps.checkConstContigous(srcReg->getValue(), currBB)) {
    debug(Yes) << "strcpy: source string not constant" << "\n";
    //mark destination as non constant too
    if(destReg)
      bbOps.setConstContigous(false, destReg->getValue(), currBB);
    else
      debug(Yes) << "strcpy: (Warning) strcpy, destination unknown" << "\n";

    return;
  }

  if(!destReg) {
    debug(Yes) << "strcpy: Destination not found\n";
    return;
  }

  //get untill NULL
  uint64_t upperLimit = 50000;
  uint64_t size = 0;
  char *addr = (char *) bbOps.getActualAddr(srcReg->getValue(), currBB);
  char *destAddr = (char *) bbOps.getActualAddr(destReg->getValue(), currBB);
  char *temp = addr;

  while(*temp && size <= upperLimit) {
    size++;
    temp++;
  }

  if(size > upperLimit) {
    debug(Yes) << "strcpy: (Warning), src null not found untill upper limit \n";

    if(destReg)
      bbOps.setConstContigous(false, destReg->getValue(), currBB);

    return;
  }

  memcpy(destAddr, addr, size+1);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  debug(Yes) << "strcpy: Successfully folded " << size <<"\n";
  return;
}

void ConstantFolding::simplifyStrFunc(CallInst * callInst) {
  if(callInst->use_empty())
    return;
  Instruction * next = callInst;
  for(unsigned index = 0; index < callInst->getNumArgOperands(); index++) {
    Value * pointerArg = callInst->getArgOperand(index);
    Register * reg = processInstAndGetRegister(pointerArg);

    if(!reg) {
      StringRef stringRef;
      if(getConstantStringInfo(pointerArg, stringRef, 0, false))
        debug(Yes) << "constant string " << stringRef << "\n";
    } else {    
      uint64_t addr = reg->getValue();
      uint64_t len;
      if(getStrLen(callInst, len)) {
        if(!bbOps.checkConstStr(addr, len, currBB)) {
          debug(Yes) << "skipping non constant string\n";
          continue;
        }
      } else if(!bbOps.checkConstStr(addr, currBB))
        continue;
      char * baseStringData = (char *) bbOps.getActualAddr(addr, currBB);
      stats.incrementInstructionsFolded();
      debug(Yes) << "baseStringData : " << baseStringData << "\n";
      ConstantInt * ind0 = ConstantInt::get(IntegerType::get(module->getContext(), 64), 0);
      vector<Value *> indxList;
      indxList.push_back(ind0); 
      indxList.push_back(ind0);
      Constant * stringConstant = ConstantDataArray::getString(module->getContext(), 
          StringRef(baseStringData), true);
      GlobalVariable * globalReadString = new GlobalVariable(*module, stringConstant->getType(), true,
          GlobalValue::ExternalLinkage, stringConstant, "");
      Type * elType = globalReadString->getType()->getContainedType(0);
      GetElementPtrInst * stringPtr = GetElementPtrInst::Create(elType, globalReadString, 
          indxList, Twine(""), callInst);
      callInst->setOperand(index, stringPtr);          
      next = stringPtr;
    }
  }
  auto InstCombineRAUW = [this](Instruction *From, Value *With) {
    From->replaceAllUsesWith(With);
  };
  Function* CalledFn = callInst->getCalledFunction();
  OptimizationRemarkEmitter ORE(CalledFn);
  LibCallSimplifier Simplifier(*DL,TLI,ORE,InstCombineRAUW);

  if (Value *With = Simplifier.optimizeCall(callInst)) {
    replaceIfNotFD(callInst, With);
  }
}

void ConstantFolding::handleStrTok(CallInst * callInst)
{
  debug(Yes) << " in strtok"<< "\n";
  Value * bufPtr0 = callInst->getOperand(0);
  Value * bufPtr1 = callInst->getOperand(1);  

  Register * reg0 = processInstAndGetRegister(bufPtr0);  
  Register * reg1 = processInstAndGetRegister(bufPtr1); 
  ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(bufPtr0->getType()));

  if(bufPtr0 != nullP)
  {   
    if(!reg0) {
      debug(Yes) << "handleStrTok: argument 1 not found in map"<< "\n";
      return;
    }

    if(!bbOps.checkConstContigous(reg0->getValue(), currBB)) {
      debug(Yes) << "handleStrTok: non constant"<< "\n";
      return;
    }    
  }

  if(!reg1) {
    debug(Yes) << "handleStrTok: argument 2 not found in map"<< "\n";
    return;
  }

  if(!bbOps.checkConstContigous(reg1->getValue(), currBB)) {
    debug(Yes) << "handleStrTok: non constant"<< "\n";
    return;
  }    
  char * buffer1 = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);
  char * result;
  char* buffer0;

  if(bufPtr0!=nullP)
  {
    buffer0 = (char *) bbOps.getActualAddr(reg0->getValue(), currBB);
    result = strtok(buffer0,buffer1);
  }

  else
  {
    result = strtok(NULL,buffer1);
  }  

  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();

  if(!result) {
    replaceIfNotFD(callInst, nullP);
    return;
  }

  Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(result),true);
  GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
  gv->setAlignment(1);

  IRBuilder<> Builder(callInst);
  Value * BitCastInst = Builder.CreateBitCast(gv, PointerType::getUnqual(llvm::IntegerType::getInt8Ty(module->getContext())));
  callInst->replaceAllUsesWith(BitCastInst);

  uint64_t addr1 = bbOps.allocateHeap(strlen(result) + 1,currBB);
  char * buffer2 = (char *) bbOps.getActualAddr(addr1,currBB);
  strcpy(buffer2,result);
  buffer2[strlen(result)] = '\0';
  debug(Yes) << "buffer2 = "<<buffer2 << "\n";
  debug(Yes) << "type = "<<BitCastInst->getType() << "\n";
  addSingleVal(BitCastInst,addr1,true, true);

}

void ConstantFolding::handleStrCat(CallInst * callInst) {
  debug(Yes) << " in str cat"<< "\n";
  Value * bufPtr0 = callInst->getOperand(0);
  Value * bufPtr1 = callInst->getOperand(1);  

  Register * reg0 = processInstAndGetRegister(bufPtr0);  
  Register * reg1 = processInstAndGetRegister(bufPtr1); 


  if(!reg0) {
    debug(Yes) << "handleStrCat: not found in map"<< "\n";
    return;
  }

  if(!reg1) {
    debug(Yes) << "handleStrCat: not found in map"<< "\n";
    return;
  }

  if(!bbOps.checkConstContigous(reg0->getValue(), currBB) || !bbOps.checkConstContigous(reg1->getValue(), currBB)) {
    debug(Yes) << "handleStrCat: non constant"<< "\n";
    return;
  }    

  char * buffer0 = (char *) bbOps.getActualAddr(reg0->getValue(), currBB);
  char * buffer1 = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);

  char * result = strcat(buffer0,buffer1);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();

  debug(Yes) << "result = "<<result << "\n";
  debug(Yes) << "buffer0 = "<<buffer0 << "\n";
  debug(Yes) << "buffer1 = "<<buffer1 << "\n";

  uint64_t addr = bbOps.allocateHeap(strlen(buffer0)+strlen(buffer1) + 1, currBB);
  char * buffer3 = (char *) bbOps.getActualAddr(addr, currBB);
  strcpy(buffer3,result);
  addSingleVal(callInst, addr, true, true);

}

void ConstantFolding::handleStrCaseCmp(CallInst * callInst)
{

  debug(Yes) << " in str case cmp"<< "\n";
  Value * bufPtr0 = callInst->getOperand(0);
  Value * bufPtr1 = callInst->getOperand(1);  

  Register * reg0 = processInstAndGetRegister(bufPtr0);  
  Register * reg1 = processInstAndGetRegister(bufPtr1); 


  if(!reg0) {
    debug(Yes) << "handleStrCaseCmp: not found in map"<< "\n";
    return;
  }

  if(!reg1) {
    debug(Yes) << "handleStrCaseCmp: not found in map"<< "\n";
    return;
  }

  if(!bbOps.checkConstContigous(reg0->getValue(), currBB) || !bbOps.checkConstContigous(reg1->getValue(), currBB)) {
    debug(Yes) << "handleStrCaseCmp: non constant"<< "\n";
    return;
  }    

  char * buffer0 = (char *) bbOps.getActualAddr(reg0->getValue(), currBB);
  char * buffer1 = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);

  int result = strcasecmp(buffer0,buffer1);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();

  debug(Yes) << "result = "<<result << "\n";
  debug(Yes) << "buffer0 = "<<buffer0 << "\n";
  debug(Yes) << "buffer1 = "<<buffer1 << "\n";
  IntegerType * int32Ty = IntegerType::get(module->getContext(), 32);
  replaceIfNotFD(callInst, ConstantInt::get(int32Ty, result));     

}

void ConstantFolding::handleStrDup(CallInst * callInst)
{

  debug(Yes) << " in strdup"<< "\n";
  Value * bufPtr = callInst->getOperand(0);
  Register * reg = processInstAndGetRegister(bufPtr);  

  if(!reg) {
    debug(Yes) << "handleStrDup: not found in map"<< "\n";
    return;
  }

  if(!bbOps.checkConstContigous(reg->getValue(), currBB)) {
    debug(Yes) << "handleStrDup: non constant"<< "\n";
    return;
  }    

  uint64_t length; 
  char * buffer = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  string calledFunc = callInst->getCalledFunction()->getName();
  if(calledFunc == "strndup") {
    ConstantInt *num = dyn_cast<ConstantInt>(callInst->getOperand(1));
    if(!num)
      return;
    length = num->getZExtValue();
  } else {
    length = strlen(buffer) + 1;
  }

  uint64_t addr = bbOps.allocateHeap(length, currBB);
  char * buffer1 = (char *) bbOps.getActualAddr(addr, currBB);
  if(calledFunc == "strndup")
    strncpy(buffer1,buffer, length);
  else
    strcpy(buffer1, buffer);

  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();

  debug(Yes) << "strdup: adding register address: " << addr << "\n";
  addSingleVal(callInst, addr, true, true);
}

void ConstantFolding::handleStrChr(CallInst * callInst) {
  Value * bufPtr = callInst->getOperand(0);
  Value * flagVal = callInst->getOperand(1);  
  uint64_t flag;
  Register * reg = processInstAndGetRegister(bufPtr);  
  if(!reg) {
    debug(Yes) << "handleStrChr : buffer Not found in Map\n";
    return;
  }
  if(!getSingleVal(flagVal, flag)) {
    debug(Yes) << "handleStrChr : flag not constant\n";
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return;   
  }
  char * buffer = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  debug(Yes) << "strchr : " << buffer << " with flag " << (char) flag << "\n";
  char * remStr = strchr(buffer, flag);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  Type * ty = callInst->getType();
  if(!remStr) {
    debug(Yes) << "strchr : returned NULL\n";
    ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
    replaceIfNotFD(callInst, nullP);
    return;
  }
  uint64_t addr;
  for(addr = reg->getValue(); *buffer && buffer != remStr; addr++, buffer++);
  debug(Yes) << "strchr : returned idx " << (addr - reg->getValue()) << "\n";
  pushFuncStack(callInst);
  regOps.addRegister(callInst, ty, addr, reg->getTracked());
}

void ConstantFolding::handleStrpbrk(CallInst * callInst) {
  Value * bufPtr = callInst->getOperand(0);
  Value * keyPtr = callInst->getOperand(1);  
  handleConstStr(keyPtr);
  Register * reg1 = processInstAndGetRegister(bufPtr);  
  if(!reg1) {
    debug(Yes) << "handleStrpbrk : buffer Not found in Map\n";
    return;
  }
  Register * reg2 = processInstAndGetRegister(keyPtr);  
  if(!reg2) {
    bbOps.setConstContigous(false, reg1->getValue(), currBB);
    debug(Yes) << "handleStrpbrk : key Not found in Map\n";
    return;
  }
  char * buffer = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);
  char * key = (char *) bbOps.getActualAddr(reg2->getValue(), currBB);
  char * remStr = strpbrk(buffer, key);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  Type * ty = callInst->getType();
  if(!remStr) {
    ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
    replaceIfNotFD(callInst, nullP);
    return;
  }
  uint64_t addr;
  for(addr = reg1->getValue(); *buffer && buffer != remStr; addr++, buffer++);
  pushFuncStack(callInst);
  regOps.addRegister(callInst, ty, addr, reg1->getTracked() | reg2->getTracked());
}


void ConstantFolding::handleAtoi(CallInst * callInst) {
  Value * ptr = callInst->getArgOperand(0);
  Register * reg = processInstAndGetRegister(ptr);
  if(!reg) {
    debug(Yes) << "handleAtoi : not found in map\n";
    return;
  }
  if(!bbOps.checkConstContigous(reg->getValue(), currBB)) {
    debug(Yes) << "handleAtoi : not constant\n";
    return;
  }
  char * str = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  int result = atoi(str);
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  IntegerType * int32Ty = IntegerType::get(module->getContext(), 32);
  replaceIfNotFD(callInst, ConstantInt::get(int32Ty, result)); 
}



void ConstantFolding::handleCIsSpace(CallInst* callInst){
  debug(Yes)<<"Invoked handleCIsSpace\n";

  Value* arg = callInst->getOperand(0);

  if(auto CI = dyn_cast<ConstantInt>(arg)){
    int constVal = CI->getSExtValue();
    debug(Yes)<<"ConstantVal: "<<constVal<<"\n";

    int result=0;

    switch(constVal){
      case 32:
      case 9:
      case 10:
      case 11:
      case 12:
      case 13:
        result =1;
        break;
      default:
        result =0;
        break;
    }
    debug(Yes)<<"Post Switch: Result = "<<result<<"\n";
    addSingleVal(callInst,(uint64_t)(result!=0),true, false); 
    stats.incrementLibCallsFolded();
    stats.incrementInstructionsFolded();
  }
}

void ConstantFolding::handleCIsalnum(CallInst* callInst){
  debug(Yes)<<"Invoked handleCIsalnum\n";

  Value* arg = callInst->getOperand(0);

  if(auto CI = dyn_cast<ConstantInt>(arg)){
    int constVal = CI->getSExtValue();
    debug(Yes)<<"ConstantVal: "<<constVal<<"\n";

    int result=isalnum(constVal);
    debug(Yes)<<"Result = "<<result<<"\n";
    addSingleVal(callInst,(uint64_t)(result!=0),true, false); 
    stats.incrementLibCallsFolded();
    stats.incrementInstructionsFolded();
  }
}

void ConstantFolding::handleCToLower(CallInst* callInst){
  debug(Yes)<<"Invoked handleCToLower\n";

  Value* arg = callInst->getOperand(0);

  if(auto CI = dyn_cast<ConstantInt>(arg)){
    int constVal = CI->getSExtValue();
    debug(Yes)<<"ConstantVal: "<<constVal<<"\n";

    int result=tolower(constVal);
    debug(Yes)<<"Result = "<<result<<"\n";
    addSingleVal(callInst,(uint64_t)result,true, false); 
    stats.incrementLibCallsFolded();
    stats.incrementInstructionsFolded();
  }
}

void ConstantFolding::handleCIsDigit(CallInst* callInst){
  debug(Yes)<<"Invoked handleCIsDigit\n";

  Value* arg = callInst->getOperand(0);

  if(auto CI = dyn_cast<ConstantInt>(arg)){
    int constVal = CI->getSExtValue();
    debug(Yes)<<"ConstantVal: "<<constVal<<"\n";

    int result=isdigit(constVal);
    debug(Yes)<<"Result = "<<result<<" in bool: "<<(result != 0)<<"\n";
    addSingleVal(callInst,(uint64_t) (result != 0),true, true); 
    stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  }
}

// FIXME: What does this comment mean? That these functions were extracted from FileIO.cpp? Should remove it

/*
   The following code specializes File IO Calls such as open, read, pread, lseek, 
   fopen, fread, fgets, fseek, mmap, munmap, close,fclose

   For each opened file, a File Structure (FdInfo) is defined which stores its file pointer (in case of fopen()), 
   file descriptor (in case of open()), file name, current offset and a tracked boolean, which 
   tells whether it can be specialized. File Open calls will be only specialized if they 
   are successful and have constant arguments.

   File Read calls will be specialized if they are successful and there exist a valid File structure associated with it 
   (initialized when file is opened) and a valid buffer,where the contents of file read will be stored. 
   Also the size of the file contents to be read and the offset of the file should be constant. 
   Similarly, for File Seek Calls, offset and flag should be constant.

   After File Read Calls, the buffer where the file data is stored is marked as constant and 
   the calls are replaced with memcpys instructions. 

   Additional File Seek calls are added for replacing File Read Calls in case the file is not 
   completely specialized. We are handling partial specialization.

   All File IO calls are added to fileIOCalls map so that if they are successfully specialized, 
   they can be deleted at the end.

*/


/**
 * Allocates and Initializes File Structure (FDInfo) for open() call
 * Saves the address of structure in FdInfoMap
 */

int ConstantFolding::initfdi(int fd,char* fname) {
  uint64_t addr = bbOps.allocateHeap(sizeof(FdInfo), currBB);
  FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB);
  fdi->fd = fd;
  fdi->offset = 0;
  fdi->tracked = true;
  fdi->fileName = fname;
  int sfd = numConfigFiles;
  numConfigFiles++;
  fdInfoMap[sfd] = addr;
  debug(Yes) << addr;
  return sfd;
}

/**
 * Allocates and Initializes File Structure (FDInfo) for fopen() call
 * Saves the address of structure in FdInfoMap
 */

int ConstantFolding::initfptr(FILE *fptr, char* fname) {
  uint64_t addr = bbOps.allocateHeap(sizeof(FdInfo),currBB);
  FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr,currBB);
  fdi->fd = 0;
  fdi->fptr = fptr;
  fdi->offset = 0;
  fdi->tracked = true;
  fdi->fileName = fname;
  int sfd = numConfigFiles;
  numConfigFiles++;  
  fdInfoMap[sfd] = addr;
  debug(Yes) <<"address = "<<addr<<"sfd = "<<sfd<<"\n";

  return sfd;
}

/**
 * Returns true if a valid File Descriptor is found in FdInfoMap
 * For read, pread, lseek, mmap, close only
 */

bool ConstantFolding::getfdi(int sfd, int & fd) {
  if(fdInfoMap.find(sfd) == fdInfoMap.end())
    return false;
  uint64_t addr = fdInfoMap[sfd];
  if(!bbOps.checkConstContigous(addr, currBB)) {
    debug(Yes) << "skipping non constant fd\n";
    return false;
  }
  FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB);
  if(!fdi->tracked) { 
    debug(Yes) << "skipping untracked fd\n";
    return false;
  }
  fd = fdi->fd;
  lseek(fd, fdi->offset, SEEK_SET);
  return true;
}

/**
 * Returns true if a valid File Pointer is found in FdInfoMap
 * For fread, fgets, fseek, fclose only
 */

bool ConstantFolding::getfptr(int sfd, FILE *& fptr) {
  if(fdInfoMap.find(sfd) == fdInfoMap.end())
    return false;

  uint64_t addr = fdInfoMap[sfd];
  if(!bbOps.checkConstContigous(addr,currBB)) {
    debug(Yes) << "skipping non constant fptr\n";
    return false;
  }
  FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr,currBB);
  if(!fdi->tracked) { 
    debug(Yes) << "skipping untracked fptr\n";
    return false;
  }
  fptr = fdi->fptr;
  fseek(fptr, fdi->offset, SEEK_SET);
  return true;
}

/**
 * Sets tracking of File as false
 * Set as false in two cases: 
 * 1.FileIO Calls can not be specialized e.g, arguments are non-constant
 * 2.FileIO functions returns an error
 */
void ConstantFolding::setfdiUntracked(int sfd) {
  ((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd], currBB))->tracked = false;
}


/**
 * Get tracked value of a File
 */

bool ConstantFolding::getfdiUntracked(int sfd) {
  return ((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd], currBB))->tracked;
}

/**
 * Sets File offset to the new offset of the File after it has being read or seeked
 * For read, pread and lseek only
 */

void ConstantFolding::setfdiOffset(int sfd, int fd) {
  ((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd], currBB))->offset = lseek(fd, 0, SEEK_CUR);
}

/**
 * Get File offset
 */

long ConstantFolding::getfdiOffset(int sfd, int fd) {
  return ((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd], currBB))->offset;
}

/**
 * Sets File offset to the new offset of the File after it has being read or seeked
 * For fread, fgets and fseek only
 */

void ConstantFolding::setfptrOffset(int sfd, FILE *fptr) {
  ((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd],currBB))->offset = ftell(fptr);

}

/**
 * Get File offset
 */
long ConstantFolding::getfptrOffset(int sfd, FILE *fptr) {
  return ((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd],currBB))->offset;

}

/**
 * Handle File IO calls such as open, read, pread,lseek,close,fopen,fread,fgets,fseek,fclose, map, munmap
 */

bool ConstantFolding::handleFileIOCall(CallInst * ci) {
  string name = ci->getCalledFunction()->getName();
  if(name == "open" || name == "open64")  handleOpen(ci);
  else if(name == "fopen" || name == "fopen64") handleFOpen(ci);
  else if(name == "read")  handleRead(ci);
  else if(name == "fread")  handleFRead(ci);
  else if(name == "lseek")  handleLSeek(ci);
  else if(name == "fseek")  handleFSeek(ci);
  else if(name == "pread")  handlePRead(ci);
  else if(name == "mmap" || name == "mmap64")   handleMMap(ci);
  else if(name == "munmap")  handleMUnmap(ci);
  else if(name == "fgets" || name == "fgets_unlocked")  handleFGets(ci);
  else if(name == "getline")  handleGetLine(ci);
  else if (name == "close")  handleClose(ci);
  else if (name == "fclose")  handleFClose(ci);
  else if (name == "feof")  handleFEOF(ci);
  else return false;

  stats.incrementTotalLibCalls();
  return true;
}

/**
 * Handle open() calls
 * Opens the file and if call is succesful, it creates, initializes and saves the File Structure (FDInfo) for that file
 */

void ConstantFolding::handleOpen(CallInst * ci) {
  Value * nameptr = ci->getOperand(0);
  char * fname;
  Value * flagVal = ci->getOperand(1);
  uint64_t flag; 
  if(!getStr(nameptr, fname, 100)) {
    debug(Yes) << "handleOpen : fname not found in map\n";
    return;
  }
  if(!getSingleVal(flagVal, flag)) {
    debug(Yes) << "handleOpen : flag not constant\n";
    return;   
  }
  if (std::find(std::begin(configFileNames), std::end(configFileNames), fname) != std::end(configFileNames) && fileSpecialize && flag==0){
    int fd = open(fname, flag);
    if(fd < 0) return;
    stats.incrementLibCallsFolded();
   stats.incrementInstructionsFolded();
    fd = initfdi(fd,fname);
    addSingleVal(ci, fd, true, true);
    FileInsts* insts = new FileInsts();
    insts->insts.push_back(ci);
    insts->isSpecialized = true;
    fileIOCalls[fd] = insts;
  } else {
    debug(Yes) << "open not specialized" << "\n";
  }
}

void ConstantFolding::handleFEOF(CallInst * ci) {
  Value * fptrVal = ci->getOperand(0);
  uint64_t sfd;
  FILE* fptr;
  bool fdConst = getSingleVal(fptrVal, sfd)&& getfptr(sfd, fptr);
  if(!fdConst){
    debug(Yes) << "handleFEOF : failed to specialize\n";
    if(getSingleVal(fptrVal, sfd)){
      string funcNames[2];
      funcNames[0] = "fopen";
      funcNames[1] = "fopen";
      removeFileIOCallsFromMap(funcNames, sfd);
    }  
    return;   
  }   
  int fileC =feof(fptr); 
  stats.incrementLibCallsFolded();
  stats.incrementInstructionsFolded();
  addSingleVal(ci,fileC,true,true);
  fileIOCalls[sfd]->insts.push_back(ci);

}

void ConstantFolding::handleGetLine(CallInst * ci) {
  Value * bufPtr = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  Value * fptrVal = ci->getOperand(2);
  uint64_t sfd;
  size_t  size;
  FILE* fptr;
  bool fdConst = getSingleVal(fptrVal, sfd) && getfptr(sfd, fptr);
  Register * reg = processInstAndGetRegister(bufPtr); 
  Register * reg1 = processInstAndGetRegister(sizeVal);   
  if(!reg || !reg1 ||!fdConst) {
    debug(Yes) << "handleGetLine : failed to specialize\n";
    if(reg) bbOps.setConstContigous(false, reg->getValue(),currBB); 
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fptrVal, sfd)){
      string funcNames[2];
      funcNames[0] = "fopen";
      funcNames[1] = "fseek";
      removeFileIOCallsFromMap(funcNames, sfd);    
    }  
    return;   
  }
  char ** buffer = (char **) bbOps.getActualAddr(reg->getValue(),currBB);
  size_t * buffer2 = (size_t *) bbOps.getActualAddr(reg1->getValue(),currBB);
  char * newBuf = NULL;

  size_t characters = getline(&newBuf,&size,fptr);
  stats.incrementLibCallsFolded();




  if(characters == -1 && !feof(fptr)) {
    debug(Yes) << "handleGetLine : read returned error\n";
    setfdiUntracked(sfd);
    bbOps.setConstContigous(false, reg->getValue(),currBB); 
    bbOps.setConstContigous(false, reg1->getValue(),currBB); 
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   
  }

  else{
    debug(Yes) << "buffer value " << newBuf <<" "<<strlen(newBuf)<<" "<<size<<" "<< characters <<"\n";
    bbOps.setConstMem(true, reg1->getValue(),8,currBB);
    bbOps.setConstMem(true, reg->getValue(),8,currBB);
    *buffer2 = size;

    uint64_t addr1 = bbOps.allocateStack(strlen(newBuf),currBB);
    char * buffer1 = (char *) bbOps.getActualAddr(addr1,currBB);
    strcpy(buffer1,newBuf);

    bbOps.storeToMem(addr1,8,reg->getValue(), currBB); 

    setfptrOffset(sfd, fptr);
    llvm::Type * type = llvm::IntegerType::getInt64Ty(module->getContext());
    llvm::Constant *sizeNum = llvm::ConstantInt::get(type, characters, true);
    ci->replaceAllUsesWith(sizeNum); 

    IRBuilder<> Builder(ci);

    Constant *mallocFunc;
    mallocFunc = module->getOrInsertFunction("malloc",Type::getInt8PtrTy(module->getContext()),Type::getInt64Ty(module->getContext()));    
    Function *hookM= cast<Function>(mallocFunc);

    ConstantInt * arg1 = Builder.getInt64(strlen(newBuf) + 1);
    CallInst * malloc = Builder.CreateCall(hookM,arg1);   

    Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(newBuf),true);
    GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
    gv->setAlignment(1);

    Instruction* MemCpyInst = Builder.CreateMemCpy(malloc,1,gv,1,strlen(newBuf));

    StoreInst * store = Builder.CreateStore(malloc,bufPtr,false);


    Constant *hookFunc;
    // FIXME: Line is overflowing - Properly break after 80 chars
    hookFunc = module->getOrInsertFunction("fseek", Type::getInt32Ty(module->getContext()),fptrVal->getType(),Type::getInt64Ty(module->getContext()),Type::getInt32Ty(module->getContext()));    
    Function *hook= cast<Function>(hookFunc);

    ConstantInt * arg2 = Builder.getInt64(getfptrOffset(sfd,fptr));
    ConstantInt * arg3 = Builder.getInt32(0);
    std::vector <llvm::Value*> putsArgs;
    putsArgs.push_back(fptrVal);
    putsArgs.push_back(arg2);
    putsArgs.push_back(arg3);
    CallInst * seek = Builder.CreateCall(hook,putsArgs);

    fileIOCalls[sfd]->insts.push_back(ci);
    fileIOCalls[sfd]->insertedSeekCalls.push_back(seek);
    stats.incrementInstructionsFolded();

  }

}



/**
 * Handle fopen() calls
 * Opens the file and if call is succesful, it creates, initializes and saves the File Structure (FDInfo) for that file
 */

void ConstantFolding::handleFOpen(CallInst * ci) {
  Value * nameptr = ci->getOperand(0);
  char * fname;
  Value * modVal = ci->getOperand(1);
  char * fmode;
  if(!getStr(nameptr, fname, 20)) {
    debug(Yes) << "handleFOpen : fname not found in map\n";
    return;
  }
  if(!getStr(modVal,fmode,100)) {
    debug(Yes) << "handleFOpen : fmode not found in map\n";
    return;   
  }
  if (std::find(std::begin(configFileNames), std::end(configFileNames), fname) != std::end(configFileNames) && fileSpecialize && (strcmp(fmode,"rb")==0 || strcmp(fmode,"r")==0)){
    FILE* fptr = fopen(fname, fmode);
    if(!fptr) {
      debug(Yes) << "handleFOpen : fopen error\n";
      return;
    }
    stats.incrementLibCallsFolded();
    stats.incrementInstructionsFolded();
    int fd = initfptr(fptr,fname);
    addSingleVal(ci, fd, true, true);
    FileInsts* insts = new FileInsts();
    insts->insts.push_back(ci);
    insts->isSpecialized = true;
    fileIOCalls[fd] = insts;
  }
  else {
    debug(Yes) << "fopen not specialized since name not found. Name: " << fname << "\n";
  }
}

/**
 * Handle read() calls
 * Reads the file and if call is successful, it initializes and sets the buffer(where 
 the file data is read to) to constant
 * Add llvm.memcpy instruction to replace read calls
 * Also updates the file offset
 * Seek call added for partial specialization
 */

void ConstantFolding::handleRead(CallInst * ci) {
  Value * fdVal = ci->getOperand(0);
  Value * bufPtr = ci->getOperand(1);
  Value * sizeVal = ci->getOperand(2);
  uint64_t size, sfd;
  int fd = 0;
  bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);  

  if (fd <=2) return; //What?

  Register * reg = processInstAndGetRegister(bufPtr);  
  if(!reg || !fdConst || !getSingleVal(sizeVal, size)) {
    debug(Yes) << "handleRead : failed to specialize\n";
    if(reg) bbOps.setConstContigous(false, reg->getValue(), currBB);
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fdVal, sfd)){
      string funcNames[2];
      funcNames[0] = "open";
      funcNames[1] = "lseek";
      removeFileIOCallsFromMap(funcNames, sfd);    
    }  
    return;   
  }
  char * buffer = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  long bytes_read = read(fd, buffer, size);
  stats.incrementLibCallsFolded();

  if(bytes_read < 0) {
    debug(Yes) << "handleRead : read returned error\n";
    setfdiUntracked(sfd);
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "lseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   		
  }
  bbOps.setConstMem(true, reg->getValue(), bytes_read, currBB);
  setfdiOffset(sfd, fd);
  addSingleVal(ci, bytes_read, true, true);
  buffer[bytes_read] = '\0';

  Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(buffer),true);
  GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
  gv->setAlignment(1);
  IRBuilder<> Builder(ci);
  Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,1,gv,1,bytes_read);

  Constant *hookFunc;
  // FIXME: Break line
  hookFunc = module->getOrInsertFunction("lseek", Type::getInt64Ty(module->getContext()), Type::getInt32Ty(module->getContext()),Type::getInt64Ty(module->getContext()),Type::getInt32Ty(module->getContext()));    
  Function *hook= cast<Function>(hookFunc);

  ConstantInt * arg1 = Builder.getInt32(fd);
  ConstantInt * arg2 = Builder.getInt64(getfdiOffset(sfd,fd));
  ConstantInt * arg3 = Builder.getInt32(0);
  std::vector <llvm::Value*> putsArgs;
  putsArgs.push_back(arg1);
  putsArgs.push_back(arg2);
  putsArgs.push_back(arg3);
  CallInst * seek = Builder.CreateCall(hook,putsArgs);

  fileIOCalls[sfd]->insts.push_back(ci);
  fileIOCalls[sfd]->insertedSeekCalls.push_back(seek);
  stats.incrementInstructionsFolded();
}

/**
 * Handle pread() calls
 * Reads the file and if call is successful, it initializes and sets the buffer
 (where the file data is read to) to constant
 * Add llvm.memcpy instruction to replace read calls
 * Also updates the file offset
 */

void ConstantFolding::handlePRead(CallInst * ci) {
  Value * fdVal = ci->getOperand(0);
  Value * bufPtr = ci->getOperand(1);
  Value * sizeVal = ci->getOperand(2);
  Value * offsetVal = ci->getOperand(3);
  uint64_t size,offset,sfd;
  int fd;
  bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
  Register * reg = processInstAndGetRegister(bufPtr);  
  if(!reg || !fdConst || !getSingleVal(sizeVal, size)|| !getSingleVal(offsetVal, offset)) {
    debug(Yes) << "handlePRead : failed to specialize\n";
    if(reg) bbOps.setConstContigous(false, reg->getValue(),currBB); 
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fdVal, sfd)){
      string funcNames[2];
      funcNames[0] = "open";
      funcNames[1] = "open";
      removeFileIOCallsFromMap(funcNames, sfd);          
    }
    return;   
  }
  char * buffer = (char *) bbOps.getActualAddr(reg->getValue(),currBB);
  long bytes_read = pread(fd, buffer, size,offset);
  stats.incrementLibCallsFolded();
  if(bytes_read < 0) {
    debug(Yes) << "handlePRead : read returned error\n";
    setfdiUntracked(sfd);
    bbOps.setConstContigous(false, reg->getValue(),currBB); 
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "open";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   

  }
  bbOps.setConstMem(true, reg->getValue(), bytes_read,currBB);
  addSingleVal(ci, bytes_read, true, true);

  Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(buffer),true);
  GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
  gv->setAlignment(1);
  IRBuilder<> Builder(ci);
  Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,1,gv,1,bytes_read);
  fileIOCalls[sfd]->insts.push_back(ci);
  stats.incrementInstructionsFolded();
}

//handles mmap calls

void ConstantFolding::handleMMap(CallInst * ci) {
  Value * bufPtr = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  Value * flagVal1 = ci->getOperand(2);
  Value * flagVal2 = ci->getOperand(3);
  Value * fdVal = ci->getOperand(4);
  Value * offsetVal = ci->getOperand(5);
  uint64_t size,offset,flag1,flag2,sfd;
  int fd;
  bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
  Register * reg = processInstAndGetRegister(bufPtr); 

  if(!fdConst || !getSingleVal(offsetVal, offset)|| !getSingleVal(flagVal1, flag1)|| !getSingleVal(flagVal2, flag2)) {
    debug(Yes) << "handleMMap : failed to specialize\n";
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fdVal, sfd)){
      string funcNames[2];
      funcNames[0] = "open";
      funcNames[1] = "open";
      removeFileIOCallsFromMap(funcNames, sfd);         
    }
    return;   

  }
  char * buffer;
  if(!reg)
    buffer = NULL;
  else
    buffer = (char *) bbOps.getActualAddr(reg->getValue(),currBB);

  uint64_t addr = fdInfoMap[sfd];
  FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr,currBB);

  if(!getSingleVal(sizeVal, size)){

    struct stat st;
    stat(fdi->fileName,&st);
    size = st.st_size;

  } 
  char* mmappedData = (char*)mmap(buffer,size,flag1,flag2,fd,offset);
  stats.incrementLibCallsFolded();
  if (mmappedData == MAP_FAILED){
    debug(Yes) << "handleMMap : read returned error\n";
    setfdiUntracked(sfd);
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "open";
    removeFileIOCallsFromMap(funcNames, sfd);      
    return;     		
  }

  uint64_t addr1 = bbOps.allocateHeap(size, currBB);
  char * buffer1 = (char *) bbOps.getActualAddr(addr1,currBB);
  strcpy(buffer1,mmappedData);

  Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(mmappedData),true);
  GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
  gv->setAlignment(1);
  IRBuilder<> Builder(ci);
  Value * BitCastInst = Builder.CreateBitCast(gv, PointerType::getUnqual(llvm::IntegerType::getInt8Ty(module->getContext())));
  ci->replaceAllUsesWith(BitCastInst);
  fileIOCalls[sfd]->insts.push_back(ci);
  MMapInfo* mmapInfo = new MMapInfo();
  mmapInfo->sfd = sfd;
  mmapInfo->buffer = mmappedData;
  mMapBuffer.push_back(mmapInfo);
  addSingleVal(BitCastInst,addr1, true, true);
  stats.incrementInstructionsFolded();

}

//handle munmap calls
void ConstantFolding::handleMUnmap(CallInst * ci) {

  Value * bufPtr = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  uint64_t size;
  uint64_t sfd;
  char* mmappedData;
  bool hasCorrespondingMmap = false;


  Register * reg = processInstAndGetRegister(bufPtr);
  if(!reg) {
    debug(Yes) << "handleMUnmap : failed to specialize\n";
    return;
  }

  char * buffer =  (char*)bbOps.getActualAddr(reg->getValue(),currBB);


  for(int i =0; i < mMapBuffer.size();i++)
  {

    if(strcmp(buffer,mMapBuffer[i]->buffer)==0)
    {
      debug(Yes) <<"sfd equals "<<mMapBuffer[i]->sfd <<"\n";
      debug(Yes) <<"buffer equals "<<mMapBuffer[i]->buffer <<"\n";
      sfd = mMapBuffer[i]->sfd;
      mmappedData = mMapBuffer[i]->buffer;
      hasCorrespondingMmap = true;
      break;
    }

  }


  if(!getSingleVal(sizeVal, size)){
    size =1;
  }

  int ret = munmap(mmappedData,size);
  stats.incrementLibCallsFolded();
  if (ret!=0){
    debug(Yes) << "handleMUnmap : read returned error\n";
    if(hasCorrespondingMmap){
      setfdiUntracked(sfd);
      string funcNames[2];
      funcNames[0] = "open";
      funcNames[1] = "mmap";
      removeFileIOCallsFromMap(funcNames, sfd);    
    }
    return;   		
  }

  addSingleVal(ci, ret, true, true);
  fileIOCalls[sfd]->insts.push_back(ci);
  stats.incrementInstructionsFolded();

}


/**
 * Handle fread() calls
 * Reads the file and if call is successful, it initializes and sets the buffer(where the file data is read to) to constant
 * Add llvm.memcpy instruction to replace read calls
 * Also updates the file offset
 * Seek call added for partial specialization
 */

void ConstantFolding::handleFRead(CallInst * ci) {
  Value * bufPtr = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  Value * numVal = ci->getOperand(2);
  Value * fptrVal = ci->getOperand(3);
  uint64_t size,num,sfd;
  FILE* fptr;
  bool fdConst = getSingleVal(fptrVal, sfd) && getfptr(sfd, fptr);
  Register * reg = processInstAndGetRegister(bufPtr); 
   
  if(!reg || !fdConst || !getSingleVal(sizeVal, size) || !getSingleVal(numVal, num)) {
    debug(Yes) << "handleFRead : failed to specialize\n";
    if(reg) {
     debug(Yes)<< "memory non-constant" << reg->getValue()<<"\n";
      bbOps.setConstMem(false, reg->getValue(), DL->getTypeAllocSize(reg->getType()), currBB);  //this might be wrong?
    }
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fptrVal, sfd)){
      string funcNames[2];
      funcNames[0] = "fopen";
      funcNames[1] = "fseek";
      removeFileIOCallsFromMap(funcNames, sfd);    

    }
    return;   
  }
  char * buffer = (char *) bbOps.getActualAddr(reg->getValue(),currBB);
  uint64_t bytes_read = fread(buffer,size,num,fptr);
  stats.incrementLibCallsFolded();
  if(ferror(fptr)) {
    debug(Yes) << "handleFRead : read returned error\n";
    setfdiUntracked(sfd);
    bbOps.setConstContigous(false, reg->getValue(),currBB); 
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   
  }
  bbOps.setConstMem(true, reg->getValue(), bytes_read,currBB);
  setfptrOffset(sfd, fptr);
  addSingleVal(ci, bytes_read, true, true);
  buffer[bytes_read] = '\0';

  Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(buffer),true);
  GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
  gv->setAlignment(1);
  IRBuilder<> Builder(ci);
  Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,1,gv,1,bytes_read);
  Constant *hookFunc;
  hookFunc = module->getOrInsertFunction("fseek", Type::getInt32Ty(module->getContext()),fptrVal->getType(),Type::getInt64Ty(module->getContext()),Type::getInt32Ty(module->getContext()));    
  Function *hook= cast<Function>(hookFunc);

  ConstantInt * arg2 = Builder.getInt64(getfptrOffset(sfd,fptr));
  ConstantInt * arg3 = Builder.getInt32(0);
  std::vector <llvm::Value*> putsArgs;
  putsArgs.push_back(fptrVal);
  putsArgs.push_back(arg2);
  putsArgs.push_back(arg3);
  CallInst * seek = Builder.CreateCall(hook,putsArgs);

  fileIOCalls[sfd]->insts.push_back(ci);
  fileIOCalls[sfd]->insertedSeekCalls.push_back(seek);
  stats.incrementInstructionsFolded();
}

/**
 * Handle fgets() calls
 * Reads the file and if call is successful, it initializes and sets the buffer(where the file data is read to) to constant
 * Add llvm.memcpy instruction to replace read calls
 * Also updates the file offset
 * Seek call added for partial specialization
 */

void ConstantFolding::handleFGets(CallInst * ci) {
  Value * bufPtr = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  Value * fptrVal = ci->getOperand(2);
  uint64_t size,sfd;
  FILE* fptr;
  bool fdConst = getSingleVal(fptrVal, sfd) && getfptr(sfd, fptr);
  Register * reg = processInstAndGetRegister(bufPtr);  
  if(!reg || !fdConst || !getSingleVal(sizeVal, size)) {
    debug(Yes) << "handleFGets : failed to specialize\n";
    if(reg) bbOps.setConstContigous(false, reg->getValue(),currBB); 
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fptrVal, sfd)){
      string funcNames[2];
      funcNames[0] = "fopen";
      funcNames[1] = "fseek";
      removeFileIOCallsFromMap(funcNames, sfd);    
    }  
    return;   
  }

  char * buffer = (char *) bbOps.getActualAddr(reg->getValue(),currBB);
  reg->tracked = 1;
  vector<Value *> worklist;
  set<Value *> processed;
  worklist.push_back(bufPtr);
  while (worklist.size()) {
    Instruction *current = dyn_cast<Instruction>(worklist.back());
    worklist.pop_back();

    if(!current)
      continue;
    if(processed.find(current) != processed.end())
      continue;

    if(Register *reg = processInstAndGetRegister(current)) {
      reg->tracked = 1;
    }

    for(unsigned i = 0; i < current->getNumOperands(); i++) {
      worklist.push_back(current->getOperand(i));
    }
  }

  char* bytes_read = fgets(buffer,size,fptr);
  stats.incrementLibCallsFolded();


  if(feof(fptr)){
    debug(Yes) << "handleFGets : read NULL value\n";
    ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(bufPtr->getType()));     
    ci->replaceAllUsesWith(nullP);
    fileIOCalls[sfd]->insts.push_back(ci);

  }

  else if(bytes_read == NULL) {
    debug(Yes) << "handleFGets : read returned error\n";
    setfdiUntracked(sfd);
    bbOps.setConstContigous(false, reg->getValue(),currBB); 
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   
  }

  else{
    bbOps.setConstMem(true, reg->getValue(), strlen(buffer),currBB);
    setfptrOffset(sfd, fptr);
    debug(Yes) << "buffer value " << buffer <<" "<<strlen(buffer)<<" address: " <<reg->getValue()<< "\n";
    Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(buffer),true);
    // FIXME: break line
    GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
    gv->setAlignment(1);
    IRBuilder<> Builder(ci);
    Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,1,gv,1,strlen(buffer)+1);
    ci->replaceAllUsesWith(bufPtr);
    Constant *hookFunc;
    hookFunc = module->getOrInsertFunction("fseek", Type::getInt32Ty(module->getContext()),fptrVal->getType(),Type::getInt64Ty(module->getContext()),Type::getInt32Ty(module->getContext()));    
    Function *hook= cast<Function>(hookFunc);

    ConstantInt * arg2 = Builder.getInt64(getfptrOffset(sfd,fptr));
    ConstantInt * arg3 = Builder.getInt32(0);
    std::vector <llvm::Value*> putsArgs;
    putsArgs.push_back(fptrVal);
    putsArgs.push_back(arg2);
    putsArgs.push_back(arg3);
    CallInst * seek = Builder.CreateCall(hook,putsArgs);

    fileIOCalls[sfd]->insts.push_back(ci);
    fileIOCalls[sfd]->insertedSeekCalls.push_back(seek);
    stats.incrementInstructionsFolded();

  }
}

/**
 * Handle lseek() calls
 * Updates the file offset if the call is successful
 */

void ConstantFolding::handleLSeek(CallInst * ci) {
  Value * fdVal = ci->getOperand(0);
  Value * offSetVal = ci->getOperand(1);
  Value * flagVal = ci->getOperand(2);
  uint64_t offset,sfd,flag;
  int fd = 0;
  bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);

  if (fd <= 2){
      return;
  }


  if(!fdConst || !getSingleVal(offSetVal, offset) || 
      !getSingleVal(flagVal, flag) ) {
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fdVal, sfd)){
      string funcNames[2];
      funcNames[0] = "open";
      funcNames[1] = "lseek";
      removeFileIOCallsFromMap(funcNames, sfd);    
    }  
    return;   
  }	
  long ret = lseek(fd, offset, flag);
  stats.incrementLibCallsFolded();
  if(ret < 0) { 
    setfdiUntracked(sfd);
    debug(Yes) << "handleLSeek : seek returned error\n";
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "lseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   

  }
  setfdiOffset(sfd, fd);
  addSingleVal(ci, ret, true, true);
  fileIOCalls[sfd]->insts.push_back(ci);
  stats.incrementInstructionsFolded();
}

/**
 * Handle fseek() calls
 * Updates the file offset if the call is successful
 */

void ConstantFolding::handleFSeek(CallInst * ci) {
  Value * fptrVal = ci->getOperand(0);
  Value * offSetVal = ci->getOperand(1);
  Value * flagVal = ci->getOperand(2);
  uint64_t offset, sfd, flag;
  FILE* fptr;
  bool fdConst = getSingleVal(fptrVal, sfd) && getfptr(sfd, fptr);
  if(!fdConst || !getSingleVal(offSetVal, offset) || 
      !getSingleVal(flagVal, flag)) {
    if(fdConst) setfdiUntracked(sfd);
    if(getSingleVal(fptrVal, sfd)){
      string funcNames[2];
      funcNames[0] = "fopen";
      funcNames[1] = "fseek";
      removeFileIOCallsFromMap(funcNames, sfd);    
    }  
    return;    
  }	
  int ret = fseek(fptr, offset, flag);
  stats.incrementLibCallsFolded();
  if(ret != 0) { 
    setfdiUntracked(sfd);
    debug(Yes) << "handleFSeek : seek returned error\n";
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;
  }
  setfptrOffset(sfd, fptr);
  addSingleVal(ci, ret, true, true);
  fileIOCalls[sfd]->insts.push_back(ci);
  stats.incrementInstructionsFolded();
}

/**
 * handle close() calls
 * Just add them to FileIOCalls map 
 */

void ConstantFolding::handleClose(CallInst * ci) {
  Value * fdVal = ci->getOperand(0);
  uint64_t sfd;
  int fd;
  bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
  if(!fdConst){
    debug(Yes) << "handleClose : failed to specialize\n";
    if(getSingleVal(fdVal, sfd)){
      if(fdInfoMap.find(sfd) == fdInfoMap.end())
        return;

      string funcNames[2];
      funcNames[0] = "open";
      funcNames[1] = "open";
      removeFileIOCallsFromMap(funcNames, sfd);
    }  
    return;   
  }    
  int fileClose = close(fd);
  stats.incrementLibCallsFolded();
  if(fileClose !=0)
  {
    debug(Yes) << "handleClose : close returned error\n";
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "open";
    removeFileIOCallsFromMap(funcNames, sfd);
    return;

  }
  fileIOCalls[sfd]->insts.push_back(ci);
  stats.incrementInstructionsFolded();
}

/**
 * handle fclose() calls
 * Just add them to FileIOCalls map 
 */

void ConstantFolding::handleFClose(CallInst * ci) {
  Value * fptrVal = ci->getOperand(0);
  uint64_t sfd;
  FILE* fptr;
  bool fdConst = getSingleVal(fptrVal, sfd)&& getfptr(sfd, fptr);
  if(!fdConst){
    debug(Yes) << "handleFClose : failed to specialize\n";
    if(getSingleVal(fptrVal, sfd)){
      string funcNames[2];
      funcNames[0] = "fopen";
      funcNames[1] = "fopen";
      removeFileIOCallsFromMap(funcNames, sfd);
    }  
    return;   
  }   
  int fileClose =fclose(fptr); 
  stats.incrementLibCallsFolded();
  if(fileClose !=0)
  {
    debug(Yes) << "handleFClose : fclose returned error\n";
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fopen";
    removeFileIOCallsFromMap(funcNames, sfd);
    return;

  }
  fileIOCalls[sfd]->insts.push_back(ci);
  stats.incrementInstructionsFolded();
}

void ConstantFolding::removeFileIOCallsFromMap(string buffer[],int sfd) {

  vector<Instruction*> insts = fileIOCalls[sfd]->insts;
  vector<Instruction*>::iterator it = insts.begin() ;
  while (it != insts.end()){
    CallInst *Inst = dyn_cast<CallInst>(*it); 
    // FIXME: Break line
    if(((Inst->getCalledFunction()->getName().str()).compare(buffer[0])==0 || (Inst->getCalledFunction()->getName().str()).compare(buffer[1])==0)){
      it = insts.erase(it);
    }
    else{
      ++it; 
    } 
  }   

  fileIOCalls[sfd]->insts = insts;
  fileIOCalls[sfd]->isSpecialized = false;

}

bool ConstantFolding::handleLongArgs(CallInst * callInst, option * long_opts,
    int *& long_index) {
  Value * val = callInst->getOperand(3);
  Register * reg = processInstAndGetRegister(val);
  if(!reg) {
    debug(Yes) << "long_opts not found\n";
    return false;
  }
  uint64_t addr = reg->getValue();

  debug(Yes)<<"Checking if addr: "<<addr<<" is constant\n";
  if(!bbOps.checkConstContigous(addr, currBB)) {
    debug(Yes) << "long_opts not constant\n";
    return false;
  }
  unsigned i = 0;
  unsigned size = bbOps.getSizeContigous(addr, currBB);
  debug(Yes) << "Size of long options " << size/32<< "\n";

  for(;;) {
    uint64_t nameAddr = bbOps.loadMem(addr, 8, currBB);
    if(!nameAddr)
      break;
    long_opts[i].name = (char *) bbOps.getActualAddr(nameAddr, currBB);
    long_opts[i].has_arg = bbOps.loadMem(addr + 8, 4, currBB);
    uint64_t flagAddr = bbOps.loadMem(addr + 16, 8, currBB);
    long_opts[i].flag = !flagAddr ? 0 : (int *) bbOps.getActualAddr(flagAddr, currBB);
    long_opts[i].val = bbOps.loadMem(addr + 24, 4, currBB);
    if(!long_opts[i].name)
      break;
    debug(Yes)<<"{name: "<<long_opts[i].name<<", has_args: "<<long_opts[i].has_arg<<", flag: "<<long_opts[i].flag<<", val: "<<long_opts[i].val<<"}\n";
    i++;
    addr += 32;
  }
  debug(Yes)<<"i: "<<i<<"\n";
  Value * indexVal = callInst->getOperand(4);
  debug(Yes) << indexVal << " indexVal printing" << "\n";
  //debug(Yes) << *indexVal << "\n";
  if(dyn_cast<ConstantPointerNull>(indexVal)) {
    debug(Yes)<<"indexVal is a Constant Pointer Null\n";
    long_index = NULL;
  } else {
    reg = processInstAndGetRegister(indexVal);
    if(!reg) {
      debug(Yes) << "long_index not found\n";
      return false;
    }
    if(!bbOps.checkConstContigous(reg->getValue(), currBB)) {
      debug(Yes) << "long_index not constant\n";
      return false;
    }
    long_index = (int *) bbOps.getActualAddr(reg->getValue(), currBB);
  }
  memset((char *) &long_opts[i], '\0', sizeof(option)); 
  return true;
}

bool ConstantFolding::handleGetEnv(CallInst *ci) {
  Value *arg1 = ci->getOperand(0);
  stats.incrementTotalLibCalls();

  Register *reg = processInstAndGetRegister(arg1);
  if(!reg) {
    debug(Yes) << "handleGetEnv: Register not found\n";
    return false;
  }

  char *str;
  if(!getStr(reg->getValue(), str)) {
    debug(Yes) << "handleGetEnv: string not constant\n";
    return false;
  }

  char *result = getenv(str);

  stats.incrementLibCallsFolded();
  if(!result) {
    debug(Yes) << "handleGetEnv: returned null\n";
    addSingleVal(ci, 0, true, true);
    return true;
  }

  uint64_t addr = bbOps.allocateStack(strlen(result) + 1, currBB);
  char *actualAddr = (char *) bbOps.getActualAddr(addr, currBB);
  strcpy(actualAddr, result);
  addSingleVal(ci, addr, true, true);
  debug(Yes) << "handleGetEnv: returned " << result << "\n";
  stats.incrementInstructionsFolded();
  return true;
}
/**
 * Assumption that flags in argv will be constant. Non flag (optarg) can be non
 * constant due to dynamic values
 */


bool ConstantFolding::handleGetOpt(CallInst * ci) { 
  debug(Yes)<<"Invoked handleGetOpt\n";

  string name = ci->getCalledFunction()->getName().str();
  if(name.size() < 6 || name.substr(0, 6) != "getopt")
    return false;

  if(name == "getopt_long_only") {
    debug(Yes) << "case not handled " << name << "\n";
    return true;
  }

  //custom getopt implementations
  //if(!ci->getCalledFunction()->isDeclaration())
  //return false;

  uint64_t argc;
  Register * argvReg = processInstAndGetRegister(ci->getOperand(1));
  Register * optsReg = processInstAndGetRegister(ci->getOperand(2));
  Register * optindReg = NULL;
  if(module->getNamedGlobal("optind")){
    optindReg = processInstAndGetRegister(module->getNamedGlobal("optind"));
    if(!bbOps.checkConstContigous(optindReg->getValue(), currBB)){
      debug(Yes) << " optind conditions not satisfied\n";
      return true;
    }
  }

  if(!getSingleVal(ci->getOperand(0), argc) || !argvReg || 
      !optsReg) {
    debug(Yes) << "conditions not satisfied\n";
    if(module->getNamedGlobal("optind")){
    optindReg = processInstAndGetRegister(module->getNamedGlobal("optind"));
    bbOps.setConstContigous(false, optindReg->getValue(), currBB);
    }
    return true;
  }


  debug(Yes)<<"Obtaining argvSize...\n";
  uint64_t ptrSize = DL->getTypeAllocSize(argvReg->getType());
  uint64_t intSize = DL->getTypeAllocSize(ci->getType());

  uint64_t argvSize = bbOps.getSizeContigous(argvReg->getValue(),currBB) - ptrSize;
  debug(Yes)<<"argvSize: "<<argvSize<<"(Excluding NULL ptr)\n";


  debug(Yes)<<"Check getopt from: "<<argvReg->getValue()<<", to "<<argvReg->getValue() + argvSize<<"\n";

  if(!bbOps.checkConstContigous(argvReg->getValue(), currBB)) {

    if(!bbOps.checkConstMem(argvReg->getValue(),ptrSize, currBB)){
      debug(Yes) << "conditions not satisfied argv non-constant\n";
      return true;
     }
    if(!bbOps.checkConstMem(argvReg->getValue() + ptrSize,ptrSize, currBB)){
      debug(Yes) << "conditions not satisfied argv non-constant\n";
      return true;
     }


  }
  
  unsigned indice = 0;
  vector<unsigned> array;


  for(uint64_t start = argvReg->getValue(); start < argvReg->getValue() + argvSize; start += ptrSize){
      debug(Yes)<<"Checking address: "<<start<<"\n";
      if(!bbOps.checkConstMem(start,ptrSize, currBB)){
        debug(Yes)<<"[ArgvReg] starting at "<<start<<" for "<<ptrSize<<" bytes is non const\n";
        array.push_back(indice);
      } 
     indice = indice + 1;
    }

  uint64_t argcLimit = argc;
 

  uint64_t optindAddr;
  if(optindReg){
    optindAddr = optindReg->getValue();
    optind = bbOps.loadMem(optindAddr, intSize, currBB);
  }
  char ** argv = (char **) malloc(sizeof(char *) * argc);
  uint64_t addr = argvReg->getValue();
  map<char *, uint64_t> realToVirt;
  for(unsigned i = 0, iter = addr; i < argcLimit; i++, iter += ptrSize) {
    uint64_t strAddr = bbOps.loadMem(iter, ptrSize, currBB);
    debug(Yes) << "Checking for index: " << i << "\n";
    if(find(array.begin(), array.end(), i)!=array.end()){
      argv[i] = "_";
      continue;
    }
    if(!getStr(strAddr, argv[i])) {
      debug(Yes) << "handleGetOpt: Non Constant argv at index" << i << "\n";
      if(i == optind) {
        debug(Yes) << "handleGetOpt: Flag not constant. Can not handle getopt \n";
        return true;
      }
    }
    debug(Yes)<<"Got String "<<argv[i]<<"\n";

    realToVirt[argv[i]] = strAddr;
  }
  char * opts = (char *) bbOps.getActualAddr(optsReg->getValue(), currBB);
  int result;
  if(name == "getopt_long") { 
    debug(Yes)<<"handleGetOpt: getopt_long\n";
    option * long_opts = (option *) malloc(sizeof(option) * 350); //@FIXME 350 is arbitrary for long opts length
    int * long_index;
    if(!handleLongArgs(ci, long_opts, long_index))
      return true;
    debug(Yes)<<"Calling getopt_long_local\n";
    result = getopt_long(argcLimit, argv, opts, long_opts, long_index);
  } else 
    result = getopt(argcLimit, argv, opts);

  IntegerType * intTy = IntegerType::get(module->getContext(), intSize * 8);
  ConstantInt * resInt = ConstantInt::get(intTy, result);

  debug(Yes) << "getopt returned " << (char) result << "\n";
  replaceIfNotFD(ci, resInt);

   Register * optargReg = processInstAndGetRegister(module->getNamedGlobal("optarg"));
  if(optarg == "_"){
      debug(Yes) << "optarg is " << optarg << "\n";
      bbOps.setConstContigous(false, optargReg->getValue(), currBB);
    }


  if((optarg && !optindReg) || (optarg && bbOps.checkConstMem(addr + (optind - 1) * ptrSize, ptrSize, currBB))) {
    debug(Yes) << "optarg is " << optarg << "\n";

    Register * optargReg = processInstAndGetRegister(module->getNamedGlobal("optarg"));
    uint64_t optArgAddr = optargReg->getValue();
    uint64_t strAddr = bbOps.loadMem(optArgAddr, ptrSize, currBB);
    debug(Yes)<<"optArgAddr: "<<optArgAddr<<", strAddr "<<strAddr<<"\n";
    if(!strAddr) {
      Type * ty = optargReg->getType()->getContainedType(0);
      uint64_t charSize = DL->getTypeAllocSize(ty);
      strAddr = bbOps.allocateHeap(charSize * 100, currBB);
      bbOps.storeToMem(strAddr, ptrSize, optArgAddr, currBB);
      debug(Yes) << "created new string at " << strAddr << "\n";
    }
    char * source = (char *) bbOps.getActualAddr(strAddr, currBB);
    memcpy(source, optarg, strlen(optarg));
    if(optarg == "_"){
      bbOps.setConstContigous(false, strAddr, currBB);
      bbOps.setConstContigous(false, optargReg->getValue(), currBB);
    }
    else{
      bbOps.setConstContigous(true, strAddr, currBB);
      bbOps.setConstContigous(true, optargReg->getValue(), currBB);
     }
    source[strlen(optarg)] = '\0';
    debug(Yes)<<"Pasted string: "<<source<<" to addr "<<strAddr<<"\n";
  }

  if(optindReg)
    bbOps.storeToMem(optind, intSize, optindAddr, currBB);
  for(unsigned i = 0, iter = addr; i < argcLimit; i++, iter += ptrSize){
    if(find(array.begin(), array.end(), i)!=array.end())
      continue;
    bbOps.storeToMem(realToVirt[argv[i]], ptrSize, iter, currBB);
  }
  debug(Yes)<<"Returning from handleGetOpt\n";
  stats.incrementInstructionsFolded();
  return true;
}





void ConstantFolding::cloneFuncStackAndRegisters(ValueToValueMapTy &vmap, ValSet &oldValSet) {
  for(auto val : oldValSet) {
    if(!vmap[val])
      continue;
    Register * reg = processInstAndGetRegister(val);
    if(reg) {  
      pushFuncStack(vmap[val]); 
      regOps.addRegister(vmap[val], reg);
    }
    else
      continue;
  }
}

LoopUnroller *ConstantFolding::unrollLoop(BasicBlock * BB, BasicBlock *&entry) {  
  Function *cloned = BB->getParent();
  LoopInfo *LI = &getAnalysis<LoopInfoWrapperPass>(*cloned).getLoopInfo();;
  AssumptionCache *AC = &getAnalysis<AssumptionCacheTracker>(*cloned).getAssumptionCache(*cloned);
  Loop *L = LI->getLoopFor(dyn_cast<BasicBlock>(BB));
  LoopUnroller *clonedFnUnroller = new LoopUnroller(module, PreserveLCSSA, useAnnotations, L, LI);

  if(clonedFnUnroller->runtest(TLI, *AC, regOps,bbOps,fdInfoMap,currBB)){
    stats.incrementLoopsUnrolled();
    return clonedFnUnroller;
  }
  delete clonedFnUnroller;
  return NULL;
}

Loop *ConstantFolding::isLoopHeader(BasicBlock *BB, LoopInfo &LI) {
  //debug(Yes)<<"isLoopHeader invoked for BB:"<<*BB<<"\n";
  if(!bbOps.partOfLoop(BB)) {
    return NULL; 
  }
  Loop * L = LI.getLoopFor(BB);
  debug(Yes)<<"isLoopHeader, getting loop NULL?: "<<(L==NULL)<<"\n";
  if(BB != L->getHeader())
    return NULL; 

  return L;
}


void ConstantFolding::duplicateContext(BasicBlock * to, BasicBlock *from) {
  if (!bbOps.isBBInfoInitialized(to)) {
    LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*to->getParent()).getLoopInfo();
    bbOps.initAndAddBBInfo(to, LI);
  }
  bbOps.duplicateContext(to, from);
}

void ConstantFolding::pushFuncStack(Value *val) {
  assert(val);
  //assert(funcValStack.size());
  if(funcValStack.size())
    funcValStack[funcValStack.size() - 1].insert(val);
}

Register *ConstantFolding::processInstAndGetRegister(Value *ptr) {
  if(!ptr)
    return NULL;

  if(Register *r = regOps.getRegister(ptr))
    return r;

  Instruction * I = NULL;
  Register * reg = NULL;
  if(ConstantExpr * ce = dyn_cast<ConstantExpr>(ptr))
    I = ce->getAsInstruction();
  else if(auto gl = dyn_cast<GlobalVariable>(ptr)){
    addGlobal(gl);
    if(Register *reg = regOps.getRegister(ptr))
      return reg;
    else
      return NULL;
  }
  else 
    I = dyn_cast<Instruction>(ptr);

  if(I && !I->getParent()) { // if it has a parent then it must have been visited 
    runOnInst(I);
    if((reg = regOps.getRegister(I))) {
      regOps.addRegister(ptr, reg);
    }
    I->dropAllReferences();
  }

  return reg;
}

void ConstantFolding::addToWorklistBB(BasicBlock *BB) {
  assert(BB->getParent() == currfn);
  //if(BB->getParent() != currfn)
  worklistBB[worklistBB.size()-1].push_back(BB);
}

void ConstantFolding::copyWorklistBB(ValueToValueMapTy& vmap, vector<BBList> &worklistBB) {
  int oldSize = worklistBB.size() - 2;
  for(auto it = worklistBB[oldSize].begin(), end = worklistBB[oldSize].end(); it != end; it++) {
    addToWorklistBB(dyn_cast<BasicBlock>(vmap[*it]));
    //worklistBB[worklistBB.size() - 1].push_back(dyn_cast<BasicBlock>(vmap[*it]));
  }
}

/*
 * Clones a function, and tries to unroll a loop in it
 */
LoopUnroller *ConstantFolding::unrollLoopInClone(Function *currfn, Loop *L, ValueToValueMapTy &vmap, vector<ValSet> &funcValStack) {

  LoopUnroller *unroller;
  Function *cloned = cloneFunc(currfn, vmap); //clone function

  push_back(funcValStack);
  copyFuncIntoClone(cloned, vmap, currfn, funcValStack);

  BasicBlock *temp;
  BasicBlock *header = dyn_cast<BasicBlock>(vmap[L->getHeader()]);
  if(!(unroller = unrollLoop(dyn_cast<BasicBlock>(vmap[L->getHeader()]), temp))) {
    //remove clone info
    bbOps.cleanUpFuncBBInfo(cloned);
    regOps.cleanUpFuncBBRegisters(cloned, popFuncValStack());
    return NULL;
  }

  FuncInfo *fi = initializeFuncInfo(cloned);
  addFuncInfo(cloned, fi);

  LoopInfo *LI = unroller->getLoopInfo();
  LI= &getAnalysis<LoopInfoWrapperPass>(*cloned).getLoopInfo(); //TODO should not recalculate on each iteration
  debug(Yes) << "unrollLoopInClone: recomputing loop info \n";
  bbOps.recomputeLoopInfo(cloned, *LI, header);

  unroller->setCloneOf(currfn);
  return unroller;
}

void ConstantFolding::eraseToReplace(CallInst *ci, vector<InstPair> &toReplace) {
  auto newEnd = 
    remove_if(toReplace.begin(), toReplace.end(),
        [&](const InstPair& ip) { 
        if(ip.first == ci) {
        ip.second->dropAllReferences(); 
        return true;
        }
        return false;
        });
  toReplace.erase(newEnd, toReplace.end());
}

void ConstantFolding::renameFunctions(Function *currFn, Function *oldFn) {
   debug(Yes)<<" Current Function Name "<<currFn->getName().str()<<"\n";
   debug(Yes)<<" Old Function Name "<<oldFn->getName().str()<<"\n";
  if (currFn->getName().str().substr(0,12) == "branchPruned") {
    oldFn->setName(oldFn->getName() + "_old");

    Function *f = module->getFunction("branchPruned_clone");
    if(f)
      f->setName("branchPruned_clone_old");
    currFn->setName("branchPruned_clone");
  }
  if(currFn->getName().str().substr(0,10) == "main_clone") {
    
    oldFn->setName(oldFn->getName() + "_old");
    Function *f = module->getFunction("main");          
    if(f)
      f->setName("main_old");
    currFn->setName("main");
  }
}

ValSet ConstantFolding::popFuncValStack() {
  assert(funcValStack.size());
  return pop_back(funcValStack);
}


/*
 * For last processed BB, if after merging memory of its preds, 
 * two pointers are non constant, mark their
 * memories as non const
 */
void ConstantFolding::checkPtrMemory(BasicBlock *currBB) {
  vector<BasicBlock*> preds;
  bbOps.getVisitedPreds(currBB, preds);

  debug(Yes) << "SIZE : " << preds.size() << "\n";
  for(auto BB: preds) {
    for(auto &I: *BB) {

      if(!dyn_cast<StoreInst>(&I))
        continue;
      StoreInst *str = dyn_cast<StoreInst>(&I);
      Value *ptr = str->getOperand(1);
      PointerType *type = dyn_cast<PointerType>(ptr->getType());
      Register *reg = processInstAndGetRegister(ptr);
      if(!reg)
        continue;
      uint64_t size = DL->getTypeAllocSize(str->getOperand(0)->getType());
      //if some memory was marked non const after merging
      if(bbOps.checkConstMem(reg->getValue(), size, BB) &&
          !bbOps.checkConstMem(reg->getValue(), size, currBB)) {
        if(type->getElementType()->isPointerTy()) {
          uint64_t value = bbOps.loadMem(reg->getValue(), size, BB); //load the pointer in memory
          markMemNonConst(dyn_cast<PointerType>(type->getElementType())->getElementType(), value, currBB);
        }
      }
    }
  }
}

/**
 * Given a type, and an address to that type, recursively marks memory at that address,
 * and any addresses (pointers) in the memory of that type as non const
 */

void ConstantFolding::markMemNonConst(Type *ty, uint64_t address, BasicBlock *BB) {
  debug(Yes) << *ty << " " << address <<  "\n";
  if(!ty || ty->isFunctionTy())
    return;

  if(!address)
    return;

  if(address > 1000000000000000000)
    return;


  if(fdInfoMap.find(address) != fdInfoMap.end())
    return;
  //if(!ty->isPointerTy())
  //return;
  if(!bbOps.checkConstMem(address, DL->getTypeAllocSize(ty), BB)) {
    debug(Yes) << "Address already non constant: " << address << "\n";
    return;
  }

  debug(Yes) << "marking mem non const in loop at address " << address << " to " << address + DL->getTypeAllocSize(ty)  <<"\n";
  bbOps.setConstContigous(false, address, BB);


  if(ty->isStructTy()) {

    debug(Yes) << "is struct type" << "\n";
    auto structLayout = DL->getStructLayout(dyn_cast<StructType>(ty));
    for(unsigned i = 0; i < ty->getStructNumElements(); i++) {
      Type *t = ty->getStructElementType(i);
      PointerType *pty = dyn_cast<PointerType>(t);
      if(!pty || pty->getElementType()->isFunctionTy()) {
        continue;
      }

      if(ty == dyn_cast<PointerType>(t)->getElementType())
        continue;

      debug(Yes)<<"\nMarkMemNonConst element "<<i<<"\n";

      uint64_t offset = address + structLayout->getElementOffset(i);
      debug(Yes)<<"offset = "<<offset<<"\n";
      uint64_t size = DL->getTypeAllocSize(t);
      debug(Yes)<<"size = "<<size<<"\n";


      if(offset < address){ //uint64_t max exceeded
        debug(Yes)<<"offset exceeds uint64_t max value; skipping markconst\n";
        continue;
      }

      uint64_t val = bbOps.loadMem(offset, size, BB);
      debug(Yes)<<"load from mem = "<<val<<"\n";

      markMemNonConst(dyn_cast<PointerType>(t)->getElementType(), val, BB); 
    }
  } else if(ty->isArrayTy() || ty->isVectorTy()) {
    debug(Yes) << "is array type " << "\n";
    auto *arrayTy = dyn_cast<SequentialType>(ty);
    Type *t = arrayTy->getElementType();
    unsigned offsetTotal = 0;
    if(t->isPointerTy()) {
      debug(Yes) << "array pointer ty " <<"\n";
      for(unsigned i = 0; i < arrayTy->getNumElements(); i++) {
        uint64_t offset = address + offsetTotal;
        uint64_t ptrSize = DL->getPointerSize();
        uint64_t value = bbOps.loadMem(offset, ptrSize, BB);
        if(offset < address){ //uint64_t max exceeded
          debug(Yes)<<"offset exceeds uint64_t max value; skipping markconst\n";
          continue;
        }
        markMemNonConst(dyn_cast<PointerType>(t)->getElementType(), value, BB);
      }
    }
  } else if(ty->isPointerTy()) {
    debug(Yes) << *ty << " is of pointer type\n";
    PointerType *t = dyn_cast<PointerType>(ty);
    if(!t->getElementType()->isFunctionTy()) {
      uint64_t value = bbOps.loadMem(address, DL->getTypeAllocSize(t->getElementType()), BB);
      markMemNonConst(t->getElementType(), value, BB);
    }
  }

  // FIXME: Break line
  }

