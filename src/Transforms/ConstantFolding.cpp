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



#include <malloc.h>
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
#include <algorithm>
#include <sys/mman.h>
#include <sys/types.h>
#include <pwd.h>

#include "ConstantFolding.h"
#include "Utils.h"
#include "StringUtils.h"
#include "FdInfo.h"
#include "FileInsts.h"
#include "MMapInfo.h"
#include "GetOptLocal.h"

using namespace llvm;
using namespace std;


//File InterConstProp.cpp

static cl::list<std::string> fileNames("fileNames",cl::ZeroOrMore, cl::desc("config filenames to specialize for"),cl::CommaSeparated);

static cl::opt<bool> isAnnotated("isAnnotated",
                  cl::desc("are annotations found or should the whole program be tracked"));
static cl::opt<bool> trackAlloc("trackAllocas",cl::init(false),
                  cl::desc("are allocas tracked"));
static cl::opt<std::string> progName("__progName", cl::init(""));

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
  debug(Abubakar) << I->getType() << " Inst\n";
  debug(Abubakar) << I->getOpcodeName() << " Inst\n";
  for(unsigned i = 0; i < I->getNumOperands(); i++) {
    Value *val = I->getOperand(i);
    Register *reg = processInstAndGetRegister(val);
    PointerType *pty = dyn_cast<PointerType>(val->getType());

    if(pty && pty->getElementType()->isFunctionTy()){
      //do not mark function pointee non constant since it points to actual llvm function
      debug(Usama) << "markInstMemNonConst: skipping function\n";
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
 * Process a single instruction appropriately
 */
void ConstantFolding::runOnInst(Instruction * I) {
  ProcResult result;
  printInst(I, Abubakar);
  
  if(bbOps.partOfLoop(I)) {
    markInstMemNonConst(I); 
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
  } else if(ReturnInst * retInst = dyn_cast<ReturnInst>(I)) {
    result = processReturnInst(retInst);
  } else if(TerminatorInst * termInst = dyn_cast<TerminatorInst>(I)) {
    result = processTermInst(termInst);
  } else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(I)) {
    result = processMemcpyInst(dyn_cast<CallInst>(memcpyInst));
  } else if(MemSetInst * memsetInst = dyn_cast<MemSetInst>(I)) {
    result = processMemSetInst(dyn_cast<CallInst>(memsetInst));
  } else if(CallInst * callInst = dyn_cast<CallInst>(I)) {
    result = processCallInst(callInst);
  } else {
    result = tryfolding(I);
  }

  //if(isLoopTest())
    //updateLoopCost(result, I);
}

ProcResult ConstantFolding::processIntToPtr(IntToPtrInst *inst) {
  Value *val = inst->getOperand(0);
  ConstantInt *cInt = dyn_cast<ConstantInt>(val);
  Register *reg = processInstAndGetRegister(val);
  uint64_t value;
  if(!reg && !cInt) {
    debug(Usama) << "inttoptr: register not found\n";
    return NOTFOLDED;
  }

  if(cInt)
    value = cInt->getZExtValue();
  else
    value = reg->getValue();

  addSingleVal(inst, (uint64_t) value, false, true);
  return FOLDED;
}
/*
  run on each Instruction of the basic.
*/
bool ConstantFolding::runOnBB(BasicBlock * BB) {
  bbOps.markVisited(BB);
  currBB = BB;
  ContextInfo * ci = bbOps.getContextInfo(currBB);
  for(ci->inst = BB->begin(); ci->inst != BB->end();) {
    Instruction * I = &*(ci->inst++);

    if(isLoopTest()) {
      uint64_t seconds;
      stats.getLoopTime(seconds);
      debug(Usama) << "checking loop test. time elapsed = " << seconds << "\n";
      LoopUnroller *unroller = testStack.back();
      unroller->checkTermInst(I, seconds);
      if (unroller->testTerminated()) // test terminated in the  term condition above
        return true;
    }
    runOnInst(I);
  }  
  bbOps.freeBB(BB);
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
  Run on a called Function(or main at start)
  The context used for the entry basic block will be the same as the currBB
  at the point of function call.
  After completing execution of the function, the context before the function call
  will have to be replaced by the context at the return Instruction of the called
  function.    
*/
void ConstantFolding::runOnFunction(CallInst * ci, Function * toRun) {

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

  Function * temp = currfn;
  BasicBlock *tempBB  = currBB; //preserve across recursion of this function
  currfn = toRun; //update to callee

  BasicBlock * entry = &toRun->getEntryBlock();

  push_back(worklistBB);
  addToWorklistBB(entry);

  LoopInfo *LI= &getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo(); //TODO should not recalculate on each iteration
  while(worklistBB[worklistBB.size() - 1].size()) {

    int size = worklistBB.size() - 1;
    BasicBlock *current = worklistBB[size].back();
    worklistBB[size].pop_back();
    Loop *L = NULL;


    assert(current->getParent() == currfn);
    if((L = isLoopHeader(current, *LI)) && LoopUnroller::shouldSimplifyLoop(current, *LI, module, useAnnotations)) {
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
         debug(Abubakar) << " test not terminated\n";
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
        debug(Abubakar) << "marking test at level " << testStack.size() << " as terminated\n";

        worklistBB[worklistBB.size() -2].clear();
        auto clonedFnWorklist =  worklistBB.back();
        pop_back(worklistBB);
        for(auto it = clonedFnWorklist.begin(), end = clonedFnWorklist.end() ;it != end; it++)
          addToWorklistBB(*it); 

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
          ReplaceInstWithInst(ci, clonedCall);
          ci = clonedCall;
        }
        renameFunctions(currfn, oldFn);
        toRun = currfn;
      }
    }
  }

  stats.functionReturn();

  currBB = tempBB;
  pop_back(worklistBB);
  if(!ci) return;

  FuncInfo * fi = fimap[toRun];
  if(!fi->context) {
    errs() << "Unexpected behavior -> no context returned : possible if cant return from function, or unreachable instruction hit\n";
    //TODO: Can we hit unreachable and exit, even if there's a return present?
    currfn = temp;
    return;
  }
  bbOps.copyContext(fi->context, currBB);
  currfn = temp; //restore to caller
  currContextIsAnnotated = tempAnnot;

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
  debug(Abubakar) << "  ---------------- ** inter-constprop ** ----------------\n";
  module = &M;
  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  DL = new DataLayout(module);   
  CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();  
  PreserveLCSSA = mustPreserveAnalysisID(LCSSAID);
  
  useAnnotations = isAnnotated;  
  trackAllocas = trackAlloc;
  if(trackAllocas)
    getTrackedValues(trackedValues);

  if(useAnnotations && !trackAllocas) {
    createAnnotationList();
    // createAnnotationList2();
  }


  for (auto &fileName:fileNames){
    debug(Abubakar) <<fileName <<"\n";
    configFileNames.push_back(fileName);
  }

  collectCallGraphGlobals(CG);
  numConfigFiles = rand() % 100000000 + 100000; 

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

  replaceUses();
  deleteFileIOCalls();

  stats.printStats(module->getFunction("main"));
  stats.makeGraph(module->getFunction("main"));
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
  if(!root)
    return set<GlobalVariable *>();

  Function *F = root->getFunction();
  if(!F)
    return set<GlobalVariable *>();
  
  if(F->isDeclaration())
    return set<GlobalVariable *>();


  if(openNodes.find(F) != openNodes.end()) {
    //handle cycle
    errs() << "Cycle found : " << "\n";
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
      modSet[func] = newCycle->values;
      //modSet[func].insert(newCycle->values.begin(), newCycle->values.end());

    for(auto &cycle: oldCycles)
      delete cycle;

    //update cycle reference
    for(auto &func: cycleFunctions)
      cycles[func] = newCycle;

    return set<GlobalVariable *>();
  }

  openNodes.insert(F);
  recStack.push_back(F);

  set<GlobalVariable *> data = modSet[F];

  for(unsigned i = 0, end = root->size(); i != end; i++) {
    auto called = (*root)[i];
    if(!called)
        continue;

    set<GlobalVariable *> childData = dfs(called, modSet, openNodes, recStack, cycles);

    data.insert(childData.begin(), childData.end());
    //if(calledNode.second->getFunction())
  }

  openNodes.erase(F);
  recStack.pop_back();
  modSet[F] = data;
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
  debug(Usama) << "PRINTING CALL GRAPH" << "\n";
  map<Function *, Cycle * > cycles;
  set<Function *> openNodes;
  vector<Function *> recStack;

  for(auto &global: module->global_objects())
    if(dyn_cast<GlobalVariable>(&global))
      collectModSet(dyn_cast<GlobalVariable>(&global), modSet);
  
  Function *main = CG->getModule().getFunction("main");
  assert(main);
  //debug(Usama) << "External calling Node: " << CG->getExternalCallingNode() << "\n";
  //debug(Usama) << "Calls external Node: " << CG->getCallsExternalNode() << "\n";
  dfs(CG->begin()->second.get(), modSet, openNodes, recStack, cycles);

  for(auto &kv: modSet) {
    Function *F = kv.first;
    debug(Abubakar)<< "Function: " << F->getName() << "\n";
    for(auto &val: kv.second) {
      errs() << *val << "\n";
    }
  }
}

ProcResult ConstantFolding::processPtrToInt(PtrToIntInst *pi) {
  Value *pointer = pi->getPointerOperand();
  Register *reg = processInstAndGetRegister(pointer);

  if(!reg) {
    debug(Usama) << "failed to fold pointer inst. Register not found\n";
    return NOTFOLDED;
  }

  //PtrToIntInst *clone = cast<PtrToIntInst>(pi->clone());
  ConstantInt *constantPtr = cast<ConstantInt>(ConstantInt::get(pi->getType(), reg->getValue()));

  debug(Usama) << "trying to fold " << *constantPtr<< "\n";
  addSingleVal(pi, constantPtr->getZExtValue(), true, true);
  return FOLDED;
}
//File ProcessInstructions.cpp

/**
 * Process Alloca Instructions:
 * ty * %a = ty
 * allocate shadow memory of bytes sizeof(ty) on the stack and add shadow register 
 * with value equal to the starting address of the allocated memory
 */
ProcResult ConstantFolding::processAllocaInst(AllocaInst * ai) {
  /*
  if(!isAllocaTracked(ai)) {
    debug(Abubakar) << "skipping untracked alloca\n";
    return NOTFOLDED;
  }  
  */
  Type * ty = ai->getAllocatedType();
  unsigned size = DL->getTypeAllocSize(ty);
  uint64_t addr = bbOps.allocateStack(size, currBB);

  pushFuncStack(ai);
  bool tracked = isAllocaTracked(ai);
  regOps.addRegister(ai, ty, addr, tracked);
  debug(Abubakar) << "allocaInst : size " << size << " at address " << addr << "\n";
  return UNDECIDED;
}
ProcResult ConstantFolding::processMallocInst(CallInst * mi) {   
  /*
  if(!isAllocaTracked(mi)) {
    debug(Abubakar) << "skipping untracked malloc\n";
    return NOTFOLDED;
  }
  */
  Value * sizeVal = mi->getOperand(0);
  uint64_t size;
  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "mallocInst : size not constant\n";
    return NOTFOLDED;
  }
  uint64_t addr = bbOps.allocateHeap(size, currBB);  
  bool tracked = isAllocaTracked(mi);

  pushFuncStack(mi);
  regOps.addRegister(mi, mi->getType(), addr, tracked);
  debug(Abubakar) << "mallocInst : size " << size << " at address " << addr << "\n";  
  return UNDECIDED;
}
ProcResult ConstantFolding::processCallocInst(CallInst * ci) {   
  /*
  if(!isAllocaTracked(ci)) {
    debug(Abubakar) << "skipping untracked calloc\n";
    return NOTFOLDED;
  }
  */
  Value * numVal = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  uint64_t num, bsize;

  if(!getSingleVal(numVal, num)) {
    debug(Abubakar) << "callocInst : num not constant\n";
    return NOTFOLDED;
  }
  if(!getSingleVal(sizeVal, bsize)) {
    debug(Abubakar) << "callocInst : size not constant\n";
    return NOTFOLDED;
  }
  unsigned size = num * bsize;
  uint64_t addr = bbOps.allocateHeap(size, currBB);  
  bool tracked = isAllocaTracked(ci);

  pushFuncStack(ci);
  regOps.addRegister(ci, ci->getType(), addr, tracked);
  debug(Abubakar) << "callocInst : size " << size << " at address " << addr << "\n";  
  memset((char *) bbOps.getActualAddr(addr, currBB), '\0', size);
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
    debug(Abubakar) << "BitCastInst : Not found in Map\n";
    return NOTFOLDED;
  }

  pushFuncStack(bi);
  regOps.addRegister(bi, bi->getType(), reg->getValue(), reg->getTracked());
  return UNDECIDED;
}
ProcResult ConstantFolding::processStoreInst(StoreInst * si) {
  Value* storeOp = si->getOperand(0);
  Value * ptr = si->getOperand(1);
  Register * reg = processInstAndGetRegister(ptr);
  if(!reg) {
    debug(Abubakar) << "StoreInst : not found in map\n";
    return NOTFOLDED;
  }
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(storeOp->getType());
  uint64_t val;
  if(!getSingleVal(storeOp, val)) {
    debug(Abubakar) << "StoreInst : from cannot be determined\n";
    bbOps.setConstMem(false, addr, size, currBB);
    return NOTFOLDED;
  }
  
  bbOps.storeToMem(val, size, addr, currBB); 
  return UNDECIDED;
}
ProcResult ConstantFolding::processLoadInst(LoadInst * li) { 
  
  Value * ptr = li->getOperand(0);
  Register * reg = processInstAndGetRegister(ptr);
  if(!reg) {
    debug(Abubakar) << "LoadInst : Not found in Map\n";
    return NOTFOLDED;
  }
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(li->getType());

  debug(Abubakar) << addr << " LoadInst\n";
  if(!bbOps.checkConstMem(addr, size, currBB)) {
    debug(Abubakar) << " LoadInst : skipping non constant\n";
    return NOTFOLDED;
  }
  uint64_t val = bbOps.loadMem(addr, size, currBB);
  addSingleVal(li, val, true , reg->getTracked());
  return UNDECIDED;
}

ProcResult ConstantFolding::processGEPInst(GetElementPtrInst * gi) {
  
  Value * ptr = gi->getOperand(0);

  Register * reg = processInstAndGetRegister(ptr);    
  if(!reg) {
    debug(Abubakar) << "GepInst : Not found in map\n";
    return NOTFOLDED;
  }
  

  unsigned OffsetBits = DL->getPointerTypeSizeInBits(gi->getType());
  APInt offset(OffsetBits, 0); 
  bool isConst = gi->accumulateConstantOffset(*DL, offset);
  if(!isConst) {
    debug(Abubakar) << "GepInst : offset not constant\n";
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;
  }
  uint64_t val = reg->getValue() + offset.getZExtValue();
  pushFuncStack(gi);
  regOps.addRegister(gi, gi->getType(), val, reg->getTracked());
  debug(Abubakar) << val << " GepInst\n";
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
    debug(Abubakar) << "processMemMoveInst : Not found in Map\n";
    return NOTFOLDED;
  }

  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "processMemMoveInst : size not constant\n";
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
  debug(Abubakar) << "memmove : from " << fromString << "\n";
  memcpy(toString, dup, size);
  bbOps.setConstMem(true, reg->getValue(), size, currBB);
  free(dup);
  return NOTFOLDED;
}

ProcResult ConstantFolding::processMemcpyInst(CallInst * memcpyInst) {

  Value * toPtr = memcpyInst->getOperand(0);
  Value * fromPtr = memcpyInst->getOperand(1);
  char * fromString;
  Value * sizeVal = memcpyInst->getOperand(2);
  uint64_t size;
  Register * reg = processInstAndGetRegister(toPtr);  

  if(!reg) {
    debug(Abubakar) << "processMemcpyInst : Not found in Map\n";
    return NOTFOLDED;
  }

  
  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "processMemcpyInst : size not constant\n";
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;   
  } 

  if(!getStr(fromPtr, fromString, size)) {
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return NOTFOLDED;
  }
  char * toString = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  debug(Abubakar) << "memcpy : from " << fromString << "\n";
  memcpy(toString, fromString, size);
  bbOps.setConstMem(true, reg->getValue(), size, currBB);
  return NOTFOLDED;
}
ProcResult ConstantFolding::processMemSetInst(CallInst * memsetInst) {
  Value * ptr = memsetInst->getOperand(0);
  Value * chrctr = memsetInst->getOperand(1);
  Value * sizeVal = memsetInst->getOperand(2);

  Register * ptrReg = processInstAndGetRegister(ptr);  
  if(!ptrReg) {
    debug(Abubakar) << "processMemSetInst : Not found in Map\n";
    return NOTFOLDED;
  }

  uint64_t c;
  if(!getSingleVal(chrctr, c)) {
    debug(Abubakar) << "processMemSetInst : character not found in Map\n";
    return NOTFOLDED;    
  }

  uint64_t size;
  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "processMemSetInst : size not found in Map\n";
    return NOTFOLDED;      
  }

  char * ptrString = (char *) bbOps.getActualAddr(ptrReg->getValue(), currBB);
  memset(ptrString, c, size);
  debug(Abubakar) << "set string to " << c << " size " << size << "\n";
  return NOTFOLDED;
}
/*
 * Try folding phiNodes
 */
ProcResult ConstantFolding::processPHINode(PHINode * phiNode) {
  vector<Value*> incPtrs;
  Value * val = bbOps.foldPhiNode(phiNode, incPtrs);
  //in case not folded, mark all memories as non constant
  if(!val)
    for(auto &val: incPtrs) {
      if(Register *reg = processInstAndGetRegister(val)) {
        Value *val = regOps.getValue(reg);
        assert(val);
        if(val->getType()->isPointerTy())
          markMemNonConst(dyn_cast<PointerType>(val->getType())->getElementType(), reg->getValue(), currBB);
      }
    }

  if(val && replaceOrCloneRegister(phiNode, val)) {
    debug(Abubakar) << "folded phiNode\n";
    return FOLDED;
  } else {
    debug(Abubakar) << "failed to fold phiNode\n";
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
  debug(Abubakar) << "current function name " << currfn->getName() << "\n";
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  debug(Abubakar) << "after loop info wrapper pass " << currfn->getName() << "\n";
  bool single = bbOps.foldToSingleSucc(termInst, readyToVisit, LI);
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
  if(currfn->getName().str() == "main")
    return NOTFOLDED;
  FuncInfo * fi = fimap[currfn];
  Value * ptr = retInst->getReturnValue();
  fi->context = bbOps.duplicateMem(currBB);  
  if(!ptr)
    return NOTFOLDED;
  if(cloneRegister(retInst, ptr))
    fi->retReg = new Register(*processInstAndGetRegister(retInst)); 
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
  debug(Usama) << "marking globals for " << F->getName() << " as non const\n";
  for(auto &gv: data) {
    if(gv->isConstant())
      continue;
    auto reg = processInstAndGetRegister(gv);  
    if(!reg)
      continue;
    errs() << "marking global non constant: " << *gv << "\n";
    bbOps.setConstMem(false, reg->getValue(), DL->getTypeAllocSize(reg->getType()), currBB);
  }
}

bool ConstantFolding::handleGetUid(CallInst *callInst) {
  uid_t userId = getuid();
  addSingleVal(callInst, (uint64_t)userId, true, true);
  return true;
}

bool ConstantFolding::copyMemory(char *address, Type *ty, char *localAddress) {
  debug(Usama) << "Copying over memory" << "\n";
  StructType *st = dyn_cast<StructType>(ty);
  debug(Usama) << st << "\n";
  auto structLayout = DL->getStructLayout(st);
  for(unsigned i = 0; i < st->getStructNumElements(); i++) {
    PointerType *t = dyn_cast<PointerType>(st->getStructElementType(i));

    if(!t) {
      continue;
    }

    uint64_t offset = structLayout->getElementOffset(i);
    if(t->getElementType()->isPointerTy()) {
      debug(Usama) << "Warning case not handled\n"; 
    } else {
      //assumption that this is char *

      //allocate memory
      char *pointer = *(char**)(address + offset);
      uint64_t allocationSize = strlen(pointer) + 1;
      uint64_t val = bbOps.allocateStack(allocationSize, currBB);

      //copy over data
      char *actualAddr = (char *)bbOps.getActualAddr(val, currBB);
      debug(Usama) << "Copying : "<< string(pointer) << " at address: " << val << " real destination address: " << actualAddr << "\n";
      strcpy(actualAddr, pointer);
      debug(Usama) << "Copied : " << actualAddr << "\n";

      //store pointer
      uint64_t size = DL->getTypeAllocSize(t);
      debug(Usama) << "Storing pointer at address: " << (uint64_t) localAddress + offset << "\n";
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

  if(!pathReg || !statBufRegister) {
    debug(Usama) << "stat: one of the registers not found\n";
    return false;
  }

  debug(Usama) << "calling stat on " << (char *) bbOps.getActualAddr(pathReg->getValue(), currBB) << " virtual addr = " << pathReg->getValue() << " statbuf addr = " << statBufRegister->getValue() << "\n";
  string name = string((char *) bbOps.getActualAddr(pathReg->getValue(), currBB));
  if(std::find(std::begin(configFileNames), std::end(configFileNames), name) == std::end(configFileNames)) {
    debug(Usama) << "stat: on non config file. returning\n";
    return false;
  }

  int result = stat((char *) bbOps.getActualAddr(pathReg->getValue(), currBB), (struct stat *) bbOps.getActualAddr(statBufRegister->getValue(), currBB));
  debug(Usama) << "stat returned " << result << "\n";
  addSingleVal(ci, result, true, true);
  return FOLDED;
}

bool ConstantFolding::handleGetPwUid(CallInst *callInst) {	
	Value *uidVal = callInst->getOperand(0);
	uint64_t uid;

	if(!getSingleVal(uidVal, uid))
		return false;

	struct passwd *pwuid = getpwuid(uid);
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
  pushFuncStack(callInst);
  return true;
}

bool ConstantFolding::handleCTypeBLoc(CallInst *callInst) {
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
  return true;
}

bool ConstantFolding::handleCTypeBLocLower(CallInst *callInst) {
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
  return true;
}

bool ConstantFolding::handleToLower(CallInst *callInst) {
  debug(Usama) << "Entering tolower \n";
  Value *arg = callInst->getOperand(0);
  int argValue;
  if(auto *cint = dyn_cast<ConstantInt>(arg)) {
    argValue = (int) cint->getZExtValue();
  } else if (Register *reg = processInstAndGetRegister(arg)) {
    argValue = reg->getValue();
  } else {
    debug(Usama) << "tolower: register not found" << "\n";
    return false;
  }

  int answer = tolower(argValue);
  debug(Usama) << "tolower returned " << answer << "\n";
  addSingleVal(callInst, answer, true, true);
  return true;
}

bool ConstantFolding::handleBasename(CallInst *ci) {
  Value *val1 = ci->getOperand(0);
  Register *reg1 = processInstAndGetRegister(val1);
  char *path;

  if(!reg1 || !getStr(reg1->getValue(), path)) {
    debug(Usama) << "handleBasename: path not constant or register not found\n";
    return false;
  }

  char *result = basename(path);
  uint64_t virtAddr = bbOps.allocateHeap(strlen(result) + 1, currBB);
  char *actualAddr = (char *) bbOps.getActualAddr(virtAddr, currBB);
  strcpy(actualAddr, result);
  addSingleVal(ci, virtAddr, true, true);
  return true;
}


bool ConstantFolding::handleGetCwd(CallInst* callInst) {
  Value *val = callInst->getOperand(0);
  Value *val2 = callInst->getOperand(1);
  Register *reg = processInstAndGetRegister(val);

  if(!reg || !dyn_cast<ConstantInt>(val2)) {
    debug(Usama) << "getcwd: register not found or size not constant\n";
    return false;
  }

  size_t size = cast<ConstantInt>(val2)->getZExtValue();
  char *buf = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  char *result = getcwd(buf, size);

  if(!buf) {
    debug(Usama) << "getcwd: returned null\n";
    addSingleVal(callInst, 0, true, true);
    return true;
  }

  debug(Usama) << "cwd = " << *buf << "\n";
  addSingleVal(callInst, reg->getValue(), true, true);
  return true;
}

bool ConstantFolding::handleSysCall(CallInst *callInst) {
  Function *F;
  if(!(F = callInst->getCalledFunction()))
    return false;

  if(F->getName().str() == "getuid")
    return handleGetUid(callInst);
  else if(F->getName().str() == "getpwuid")
    return handleGetPwUid(callInst);
  return false;
}

ProcResult ConstantFolding::processCallInst(CallInst * callInst) {

  if(!callInst->getCalledFunction() && !simplifyCallback(callInst)) {
    //TODO: mark all globals as non constant?
    markArgsAsNonConst(callInst);
    return NOTFOLDED;
  }
  Function * calledFunction = callInst->getCalledFunction();
  string name = calledFunction->getName().str();
  /* specialize for functions defined in string.h e.g strcmp, strchr */
  if(handleDbgCall(callInst)) {}
  else if(handleGetOpt(callInst)) {}
  else if(handleHeapAlloc(callInst)) {}
  else if(handleMemInst(callInst)) {}
  else if(handleStringFunc(callInst)) {} 
  else if(handleFileIOCall(callInst)) {} 
  else if(handleSysCall(callInst)) {}
  else if(calledFunction->isDeclaration()) {
    debug(Abubakar) << "skipping function : declaration\n";
    markArgsAsNonConst(callInst);
    return NOTFOLDED;
  } else {
    if (!isFuncInfoInitialized(calledFunction)) {
        FuncInfo *fi = initializeFuncInfo(calledFunction);
        addFuncInfo(calledFunction, fi);
    }
    if(calledFunction->getName().str() == "ConfigAddOption")
      return NOTFOLDED;

    if((useAnnotations && !satisfyConds(calledFunction, callInst)) || exceedsRecursion(calledFunction, callInst->getParent()->getParent())) {
      debug(Abubakar) << "skipping function : does not satisfy conds\n";
      markArgsAsNonConst(callInst);
      markGlobAsNonConst(callInst->getCalledFunction());
      return NOTFOLDED;
    }
    CallInst *clonedInst = cloneAndAddFuncCall(callInst); 
    ReplaceInstWithInst(callInst, clonedInst);
    runOnFunction(clonedInst, clonedInst->getCalledFunction()); 
  }
  return UNDECIDED;  
}

string ConstantFolding::removeCloneName(string name) {
  size_t pos = name.find("_clone");
  if(pos == string::npos)
    return name;
  return name.substr(0, pos);
}

bool ConstantFolding::exceedsRecursion(Function *called, Function *callee) {
  string calledName = removeCloneName(called->getName().str());
  string calleeName = removeCloneName(callee->getName().str());

  if(calledName != calleeName)
    return false;

  //check call stack
  int max = 5;
  for(unsigned i = worklistBB.size() - 1; i >= max && i >= 0; i--) {
    string func = removeCloneName(worklistBB[i].back()->getParent()->getParent()->getName().str());
    if(func != calledName)
      return false;
  }
  
  debug(Usama) << "Recursion exceeded" << "\n";
  return true;
}

CallInst *ConstantFolding::cloneAndAddFuncCall(CallInst *callInst) {
  ValueToValueMapTy vmap;
  Function *cloned = cloneFunc(callInst->getCalledFunction(), vmap);
  std::vector<Value*> args(callInst->arg_begin(), callInst->arg_end());
  CallInst *clonedCall = createFuncCall(cloned, args);
  return clonedCall;
}
//File LoopUtils.cpp

//File Utils.cpp
void ConstantFolding::propagateArgs(CallInst *ci, Function *toRun) {
    unsigned index = 0;
    for(auto arg = toRun->arg_begin(); arg != toRun->arg_end();
      arg++, index++) {
        Value * callerVal = ci->getOperand(index);
        Value * calleeVal = getArg(toRun, index);
        replaceOrCloneRegister(calleeVal, callerVal);
    }
}

void ConstantFolding::copyCallerContext(CallInst * ci, Function * toRun) {
  BasicBlock * entry = &toRun->getEntryBlock();
  duplicateContext(entry, currBB);    
  updateAnnotationContext(ci->getCalledFunction());
}


bool ConstantFolding::cloneRegister(Value * from, Value * with) {
  debug(Abubakar) << "attempting to copy Register for " << *with << "\n";
  
  // if this is a constant string, allocate memory for it
  handleConstStr(with);
  uint64_t val;
  if(!getSingleVal(with, val)) {
    debug(Abubakar) << "failed to create Register\n";
    return false;
  }
  pushFuncStack(from);
  regOps.addRegister(from, from->getType(), val, true);
  return true;
}


bool ConstantFolding::replaceOrCloneRegister(Value * from, Value * with) {
  debug(Abubakar) << "attempting to copy Register for " << *with << "\n";
  
  // if this is a constant string, allocate memory for it
  handleConstStr(with);

  Type * ty = from->getType();
  if(isa<ConstantInt>(with)) {
    replaceIfNotFD(from, with);
    debug(Abubakar) << "replaced with constantInt\n";
  } else if(isa<ConstantPointerNull>(with)) {
    replaceIfNotFD(from, with);
    debug(Abubakar) << "replaced with NULL pointer\n";
  } else if(Register * reg = processInstAndGetRegister(with)) {
    pushFuncStack(from);
    regOps.addRegister(from, ty, reg->getValue(), reg->getTracked());    
    debug(Abubakar) << "Register from Register\n";
  } else {   
    debug(Abubakar) << "failed to simplify\n";
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
      debug(Abubakar) << "insts  " << dyn_cast<CallInst>(insts[i])->getCalledFunction()->getName().data() <<insts[i]->getNumUses()<<dyn_cast<CallInst>(insts[i])->getParent()->getParent()->getName()<<"\n"; 
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
  if(calledFunction && ignorefunc(calledFunction))
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

  debug(Usama) << "Global Value" << dyn_cast<GlobalValue>(CC) << "\n";
  debug(Usama) << "Constant expr" << dyn_cast<ConstantExpr>(CC) << "\n";
  if(CDA && CDA->isString()) {
    char * source = (char *) bbOps.getActualAddr(addr, currBB);
    string str = CDA->getAsString().str();  
    int size = str.size();
    memcpy(source, str.c_str(), size);
    debug(Abubakar) << "storing : size " << size << " at address " << addr << " " << *CC << "\n";
  } else if(ConstantInt * CI = dyn_cast<ConstantInt>(CC)) {
    uint64_t size = DL->getTypeAllocSize(CI->getType());
    bbOps.storeToMem(CI->getZExtValue(), size, addr, currBB);    
    debug(Abubakar) << "storing : size " << size << " at address " << addr << " " << *CC << "\n";
  } else if(ConstantExpr * CE = dyn_cast<ConstantExpr>(CC)) {
    /* 1. either we have it in memory in which case runOnInst will work*/
    /* 2. we dont have it in memory but its a constant string - need to allocate new memory */
    /* 3. points to something which is not in memory */
    Instruction * I = dyn_cast<ConstantExpr>(CE)->getAsInstruction();
    assert(I);
    StringRef stringRef;
    if(handleConstStr(I->getOperand(0))) {
      uint64_t newAddr = processInstAndGetRegister(I->getOperand(0))->getValue();
      int size = DL->getTypeAllocSize(CE->getType());
      bbOps.storeToMem(newAddr, size, addr, currBB);
      debug(Abubakar) << "storing address " << newAddr << " at pointer " << addr << " size " << size << "\n";
    } else if(Register * reg = processInstAndGetRegister(I)) {
      uint64_t newAddr = reg->getValue();
      int size = DL->getTypeAllocSize(CE->getType());
      bbOps.storeToMem(newAddr, size, addr, currBB);
      debug(Abubakar) << "storing address " << newAddr << " at pointer " << addr << " size " << size << "\n";                  
    } 
    I->dropAllReferences();
  } else if(Function * callback = dyn_cast<Function>(CC)) {
    // store its address
    int size = DL->getTypeAllocSize(callback->getType());
    uint64_t faddr = (uint64_t) callback;
    bbOps.storeToMem(faddr, size, addr, currBB);
    debug(Abubakar) << "stored callback for function " << callback->getName() << "\n";
  } else if(ConstantStruct *cStruct = dyn_cast<ConstantStruct>(CC)) {
    for(unsigned i = 0; i < cStruct->getNumOperands(); i++) {
       Constant * CGI = CC->getAggregateElement(i);
       auto layout = DL->getStructLayout(cStruct->getType());
       initializeGlobal(addr + layout->getElementOffset(i), CGI);
    }
  } else {
    for(unsigned i = 0; i < CC->getNumOperands(); i++) {
      Constant * CGI = CC->getAggregateElement(i);
      //debug(Usama) << "CGI: " << *CGI << "\n CC: " << *CC << "\n";
      if(!CGI) {
        debug(Usama) << "initializeGlobal: (Warning) aggregate element not found\n";
        return;
      }
      initializeGlobal(addr, CGI);
      addr += DL->getTypeAllocSize(CGI->getType());
    }
  }
}

uint64_t ConstantFolding::addGlobal(GlobalVariable* gv){
  debug(Abubakar) << gv->getName() << "\n"; 

  if(Register *reg = regOps.getRegister(gv))
    return reg->getValue();

  if(gv->getName() == "stdin" || gv->getName() == "stderr" || gv->getName() == "stdout")
    return 0;

  Type* contTy = gv->getType()->getContainedType(0);

  uint64_t size = DL->getTypeAllocSize(contTy);
  uint64_t addr = bbOps.allocateStack(size, currBB);
  debug(Abubakar) << "addGlobal : size " << size << " at address " << addr << "\n";
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
    IntegerType * intTy = IntegerType::get(module->getContext(), 1);
    Value * newLHS = ConstantInt::get(intTy, lAddr != 0);
    Value * newRHS = ConstantInt::get(intTy, rAddr != 0);
    CmpInst * NCI = CmpInst::Create(CI->getOpcode(), CI->getPredicate(),
                    newLHS, newRHS);
    NCI->insertBefore(CI);
    debug(Abubakar) << *CI << " ";
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
    
    debug(Abubakar) << val->getName() << " will be tracked\n";
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
    debug(Abubakar) << globs[i] << " : glob " << "\n";
    AnnotationList.insert(gv);
  }
  for(unsigned i = 0; i < funcs.size(); i++) {
    GlobalValue * gv = module->getNamedValue(StringRef(funcs[i]));
    debug(Abubakar) << funcs[i] << " : func " << "\n";
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
      LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*ci->getFunction()).getLoopInfo();
      if(LI.getLoopFor(ci->getParent()))
        fi->calledInLoop = true;     
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

bool ConstantFolding::satisfyConds(Function * F, CallInst *ci) {
  if(F->hasFnAttribute("track_func")) {
    debug(Usama) << "(LOG) (SATISFYCONDS) satisfied specializing conditions due to track_func\n";
    return true;
  }

  if(fimap.find(F) == fimap.end()){
    debug(Usama) << " not found in map\n";
    return false;
  }
  FuncInfo* fi = fimap[F];  
  if(trackAllocas) {
    //if any argument is being tracked 
    for(unsigned i = 0; i < ci->getNumArgOperands(); i++) {
      Value *argument = ci->getArgOperand(i);
      if(Register *reg = processInstAndGetRegister(argument)) { //dyn_cast<Constant>(argument) || 
        if(reg->getTracked()) {
          debug(Usama) << "(LOG) (SATISFYCONDS) Call " << *ci << " satisfied specializing conditions due to argument " <<  *argument << " at index " << i << "\n";
          return true;
        }
      }
    }

    set<GlobalVariable *> &modData = getFuncModset(F);
    //vector<Value *> intersection;
    /*
    for(auto &modD: modData)
      if(trackedValues.find(modD) != trackedValues.end()) {
        debug(Usama) << "(LOG) (SATISFYCONDS) Call " << *ci << " satisfied specializing conditions due to modset" << "\n";
        return true;
      }
      */
    //set_intersection(modData.begin(), modData.end(), trackedValues.begin(), trackedValues.end(), intersection.begin());
    //if(intersection.size()) {
    //}

    //if function has a malloc
    if(hasTrackedMalloc(F))
      return true;

    debug(Usama) << "(LOG) (SATISFYCONDS) Call " << *ci << " does not meet specializing conditions" << "\n";
    return false;
  } else {
    if(AnnotationList.find(F) != AnnotationList.end()) 
        return true;
    bool dr = fi->directCallInsts > 1;
    debug(Usama) << "(LOG) (SATISFYCONDS) Call " << fi->calledInLoop <<" "<<fi->addrTaken <<" "<<dr<<"\n";
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
      debug(Abubakar) << "replacing with null\n";
      ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
      replaceIfNotFD(val, nullP);
    } else {
      debug(Abubakar) << "adding Register\n";
      pushFuncStack(val);
      regOps.addRegister(val, ty, num, tracked); 
    }
  } else if(IntegerType * intTy = dyn_cast<IntegerType>(ty)) {
    if(replace64 || !ty->isIntegerTy(64)) {
      debug(Abubakar) << "replacing with constant int\n";
      replaceIfNotFD(val, ConstantInt::get(intTy, num));
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
  else 
    return false;  
  return true;
}

bool ConstantFolding::getStr(uint64_t addr, char *& str) {
  if(!bbOps.checkConstContigous(addr, currBB)) {
    debug(Abubakar) << "getStr : ptr not constant\n";
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
      debug(Abubakar) << "getStr : ptr not constant\n";
      return false;   
    }
    str = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  } else {
    debug(Abubakar) << "getStr : ptr not found in Map\n";
    return false;   
  }
  return true;
}

uint64_t ConstantFolding::createConstStr(string str) {
    uint64_t size = str.size();
    uint64_t newAddr = bbOps.allocateHeap(size, currBB);
    char * source = (char *) bbOps.getActualAddr(newAddr, currBB);
    memcpy(source, str.c_str(), size);  
    debug(Abubakar) << "created new constant string " << str << " at address " << newAddr << "\n";
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
  debug(Abubakar) << "replaced with " << *to << "\n";
  //if(Instruction * I = dyn_cast<Instruction>(from))
    //updateLoopCost(FOLDED, I);
}

bool ConstantFolding::simplifyCallback(CallInst * callInst) {
  Register * reg = processInstAndGetRegister(callInst->getCalledValue());
  if(!reg) return false;
  Function * calledFunction = (Function *) reg->getValue();
  callInst->setCalledFunction(calledFunction);
  debug(Abubakar) << "set called Function to " << calledFunction->getName() << "\n";
  return true;
}

bool ConstantFolding::handleHeapAlloc(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(name == "malloc")      processMallocInst(callInst);
  else if(name == "calloc") processCallocInst(callInst);
  else  return false;
  return true;
}

ProcResult ConstantFolding::processReallocInst(CallInst *ci) {
  Value *ptr = ci->getOperand(0);
  ConstantInt *size = dyn_cast<ConstantInt>(ci->getOperand(1));
  Register *reg = processInstAndGetRegister(ptr);

  if(!ptr || !size) {
    debug(Usama) << "realloc: register not found or size not constant\n";
    return NOTFOLDED;
  }

  //@TODO not going to actually realloc. just allocate more memory. Warning, memory leak
  uint64_t addr = bbOps.allocateHeap(size->getZExtValue(), currBB);
  char *oldAddr = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  uint64_t size_old = bbOps.getSizeContigous(reg->getValue(), currBB);
  debug(Usama) << "realloc: copying over memory size: " << size_old << "\n";
  memcpy((void *) bbOps.getActualAddr(addr, currBB), (void *) oldAddr, size_old);
  addSingleVal(ci, addr, false, true);
  debug(Usama) << "realloc processed successfully\n";
  return FOLDED;
}

bool ConstantFolding::handleMemInst(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(name == "memset")      processMemSetInst(callInst);
  else if(name == "memcpy") processMemcpyInst(callInst);
  else  return false;
  return true;  
}

bool ConstantFolding::handleDbgCall(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(name == PRNTDBGSTR) {
      for(unsigned i = 0; i < callInst->getNumArgOperands(); i++) {
        Value * ptrVal = callInst->getOperand(i);
        char * str;
        if(getStr(ptrVal, str, 100)) errs() << str;
      }
  } else if(name == SETDBGLEVEL) {
    Value * lVal = callInst->getOperand(0);
    if(ConstantInt * cint = dyn_cast<ConstantInt>(lVal)) {
      debugLevel = cint->getZExtValue();
      errs() << "set debugLevel to " << debugLevel << "\n";
    }
  } else return false;
  return true;
}

void ConstantFolding::visitReadyToVisit(vector<BasicBlock *> readyToVisit) {
  for(unsigned i = 0; i < readyToVisit.size(); i++) {
    BasicBlock * BB = readyToVisit[i];
    BasicBlock * pred = bbOps.getRfromPred(BB);
    assert(pred != NULL);
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
    debug(Abubakar) << "duplicating\n";
    debug(Usama) << "duplicating from " << from->getName() << " to " << succ->getName();
    duplicateContext(succ, from);
    bbOps.mergeContext(succ, from);
    checkPtrMemory(succ);
  } else {
    debug(Abubakar) << "cloning\n";
    bbOps.imageContext(succ, from);
  }    
  

  bbOps.addAncestor(succ, from);
  bbOps.freeBB(from);
  addToWorklistBB(succ);
  return true;
}

//File StringUtils.cpp

bool ConstantFolding::handleStrStr(CallInst *callInst) {
  Value *val1 = callInst->getOperand(0);
  Value *val2 = callInst->getOperand(1);

  Register *reg1 = processInstAndGetRegister(val1);
  Register *reg2 = processInstAndGetRegister(val2);

  if(!reg1) {
    debug(Usama) << "handleStrStr, argument one not found in map" << "\n";
    return false;
  }

  if(!reg2) {
    debug(Usama) << "handleStrStr, argument two not found in map" << "\n";
    return false;
  }

  if(!bbOps.checkConstContigous(reg1->getValue(), currBB) || !bbOps.checkConstContigous(reg2->getValue(), currBB)) {
    debug(Usama) << "handleStrStr, one of the arguments is non constant \n";
    return false;
  }

  char * buffer1 = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);
  char * buffer2 = (char *) bbOps.getActualAddr(reg2->getValue(), currBB);
  char *result = strstr(buffer1, buffer2);

  if(!result) {
    addSingleVal(callInst, 0, true, true);
    return false;
  }
  debug(Abubakar) << "result = "<< result << "\n";
  debug(Abubakar) << "buffer1 = "<<buffer1 << "\n";
  debug(Abubakar) << "buffer2 = "<<buffer2 << "\n";

  uint64_t size = strlen(result);
  uint64_t address = bbOps.allocateHeap(size, currBB);
  char *pointer = (char *) bbOps.getActualAddr(address, currBB);

  strcpy(pointer, result);
  addSingleVal(callInst, address, true, true);
  return true;
}

bool ConstantFolding::handleStrSep(CallInst *callInst) {
  Value *arg1 = callInst->getOperand(0);
  Value *arg2 = callInst->getOperand(1);
  Register *reg1 = processInstAndGetRegister(arg1);
  Register *reg2 = processInstAndGetRegister(arg2);
  
  if(!reg1 || !reg2) {
    debug(Usama) << "strsep: one of the registers not found \n";
    return false;
  }
  
  char *delim;
  if(!bbOps.checkConstMem(reg1->getValue(), DL->getPointerSize(), currBB) || !getStr(reg2->getValue(), delim)) {
    debug(Usama) << "strsep: non constant register \n";
    return false;
  }
  
  uint64_t stringpAddr = bbOps.loadMem(reg1->getValue(), DL->getPointerSize(), currBB);
  if(!stringpAddr) {
    addSingleVal(callInst, 0, true, true);
    debug(Usama) << "strsep returned null\n";
    return true;
  }
  debug(Usama) << "stringpAddr: " << stringpAddr << "\n";
  char *string;
  if(!getStr(stringpAddr, string)) {
    debug(Usama) << "strsep: string not constant\n";
    return false;
  }
  char **stringp = &string;
  char *stringCopy = string;
  char *result = strsep(stringp, delim);

  addSingleVal(callInst, stringpAddr, true, true);
  if(*stringp)
    bbOps.storeToMem(stringpAddr + (stringCopy - *stringp), DL->getPointerSize(), reg1->getValue(), currBB);
  else {
    bbOps.storeToMem(0, DL->getPointerSize(), reg1->getValue(), currBB);
    debug(Usama) << "after storing null: " << bbOps.loadMem(reg1->getValue(), DL->getPointerSize(), currBB) << "\n";
    debug(Usama) << "storing null" << "\n";
  }
  //addSingleVal(arg1, reg1->getValue() + (stringpCopy - stringp), true, true); //@TODO memory leak for register overwriting
  debug(Usama) << "strsep: returned " << result << "\n";
  return true;
}

void ConstantFolding::handleStrTol(CallInst *call) {
  Value *arg1 = call->getOperand(0);
  Value *arg2 = call->getOperand(1);
  Value *arg3 = call->getOperand(2);

  Register *reg1 = processInstAndGetRegister(arg1),
           *reg2 = processInstAndGetRegister(arg2);

  if(!reg1 || !reg2) {
    debug(Usama) << "strtol: one of the registers not found\n";
    return;
  }
  
  char *str;
  char **endptr = NULL;
  char *strStart = NULL;
  int base;
  if(!getStr(reg1->getValue(), str)) {
    debug(Usama) << "strtol: string non constant\n";
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
    debug(Usama) << "strtol: base not constant\n";
    return;
  }

  long int answer = strtol(str, endptr, base);

  if(endptr) {
    debug(Usama) << "strtol: moved endptr forward by: " << *endptr - strStart << "\n";
    uint64_t newEndPtr = reg1->getValue() + (*endptr - strStart);
    bbOps.storeToMem(reg2->getValue(), DL->getPointerSize(), newEndPtr, currBB);
  }
  addSingleVal(call, answer, true, true);
  return;
}

void ConstantFolding::handleStrnCpy(CallInst *callInst) {
  Value *dest = callInst->getOperand(0);
  Value *src = callInst->getOperand(1);
  ConstantInt *ci = dyn_cast<ConstantInt>(callInst->getOperand(2));

  Register *reg1 = processInstAndGetRegister(dest);
  Register *reg2 = processInstAndGetRegister(src);

  if(!reg2 || !bbOps.checkConstContigous(reg2->getValue(), currBB)) {
    debug(Usama) << "strncpy: source not found or non const\n";
    return;
  }

  if(!ci) {
    debug(Usama) << "strncpy: n not constant\n";
    return;
  }

  if(!dest) {
    debug(Usama) << "strncpy: dest register not found\n";
    return;
  }

  char *destAddr = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);
  char *srcAddr = (char *) bbOps.getActualAddr(reg2->getValue(), currBB);

  strncpy(destAddr, srcAddr, ci->getZExtValue());

  debug(Usama) << "strncpy: folded, dest string = " << destAddr << "\n";
  return;
}

bool ConstantFolding::handleStringFunc(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();

  if(name == "strtol") handleStrTol(callInst);
  else if(simpleStrFunc(name))   simplifyStrFunc(callInst);
  else if(name == "strcasecmp") handleStrCaseCmp(callInst);
  else if(name == "strchr") handleStrChr(callInst);
  else if(name == "strpbrk")handleStrpbrk(callInst);
  else if(name == "atoi")   handleAtoi(callInst);
  else if(name == "strdup")   handleStrDup(callInst);
  else if(name == "strtok")   handleStrTok(callInst);
  else if(name == "strcpy") handleStrCpy(callInst);
  else if(name == "strrchr") handleStrrChr(callInst);
  else if(name == "strcat") handleStrCat(callInst);
  else if(name == "strstr") handleStrStr(callInst);
  else if(name == "strsep") handleStrSep(callInst);
  else return false;
  return true;
}

void ConstantFolding::handleStrrChr(CallInst *callInst) {
  Value *str = callInst->getOperand(0);
  Value *chr = callInst->getOperand(1);

  char *string;
  uint64_t character;
  Register *strReg = processInstAndGetRegister(str);
  
  if(!strReg) {
    debug(Usama) << "handleStrrChr: string not found\n";
    return;
  }

  if(!getStr(strReg->getValue(), string)) {
    debug(Usama) << "handleStrrChr: string not constant\n";
    return;
  }

  if(!getSingleVal(chr, character)) {
    debug(Usama) << "handleStrrChr: failed to find character\n";
    return;
  }

  char *result = strrchr(string, (int) character); 
  debug(Usama) << "handleStrrChr: successfully folded \n";
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
    debug(Usama) << "strcpy: source string not constant" << "\n";
    //mark destination as non constant too
    if(destReg)
      bbOps.setConstContigous(false, destReg->getValue(), currBB);
    else
      debug(Usama) << "strcpy: (Warning) strcpy, destination unknown" << "\n";

    return;
  }

  if(!destReg) {
    debug(Usama) << "strcpy: Destination not found\n";
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
    debug(Usama) << "strcpy: (Warning), src null not found untill upper limit \n";

    if(destReg)
      bbOps.setConstContigous(false, destReg->getValue(), currBB);

    return;
  }
  
  memcpy(destAddr, addr, size);
  debug(Usama) << "strcpy: Successfully folded" << "\n";
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
        debug(Abubakar) << "constant string " << stringRef << "\n";
    } else {    
      uint64_t addr = reg->getValue();
      uint64_t len;
      if(getStrLen(callInst, len)) {
        if(!bbOps.checkConstStr(addr, len, currBB)) {
          debug(Abubakar) << "skipping non constant string\n";
          continue;
        }
      } else if(!bbOps.checkConstStr(addr, currBB))
        continue;
      char * baseStringData = (char *) bbOps.getActualAddr(addr, currBB);
      debug(Abubakar) << "baseStringData : " << baseStringData << "\n";
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
  LibCallSimplifier Simplifier(*DL, TLI, InstCombineRAUW);
  if (Value *With = Simplifier.optimizeCall(callInst)) {
    replaceIfNotFD(callInst, With);
  }
}

void ConstantFolding::handleStrTok(CallInst * callInst)
{
  debug(Abubakar) << " in strtok"<< "\n";
  Value * bufPtr0 = callInst->getOperand(0);
  Value * bufPtr1 = callInst->getOperand(1);  

  Register * reg0 = processInstAndGetRegister(bufPtr0);  
  Register * reg1 = processInstAndGetRegister(bufPtr1); 
  ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(bufPtr0->getType()));

  if(bufPtr0 != nullP)
  {   
    if(!reg0) {
      debug(Abubakar) << "handleStrTok: argument 1 not found in map"<< "\n";
      return;
    }

    if(!bbOps.checkConstContigous(reg0->getValue(), currBB)) {
      debug(Abubakar) << "handleStrTok: non constant"<< "\n";
      return;
    }    
  }

  if(!reg1) {
    debug(Abubakar) << "handleStrTok: argument 2 not found in map"<< "\n";
    return;
  }

  if(!bbOps.checkConstContigous(reg1->getValue(), currBB)) {
    debug(Abubakar) << "handleStrTok: non constant"<< "\n";
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
  debug(Abubakar) << "buffer2 = "<<buffer2 << "\n";
  debug(Abubakar) << "type = "<<BitCastInst->getType() << "\n";
  addSingleVal(BitCastInst,addr1,true, true);
  
}

void ConstantFolding::handleStrCat(CallInst * callInst) {
  debug(Abubakar) << " in str cat"<< "\n";
  Value * bufPtr0 = callInst->getOperand(0);
  Value * bufPtr1 = callInst->getOperand(1);  

  Register * reg0 = processInstAndGetRegister(bufPtr0);  
  Register * reg1 = processInstAndGetRegister(bufPtr1); 

   
  if(!reg0) {
        debug(Abubakar) << "handleStrCat: not found in map"<< "\n";
        return;
  }

  if(!reg1) {
    debug(Abubakar) << "handleStrCat: not found in map"<< "\n";
    return;
  }

  if(!bbOps.checkConstContigous(reg0->getValue(), currBB) || !bbOps.checkConstContigous(reg1->getValue(), currBB)) {
    debug(Abubakar) << "handleStrCat: non constant"<< "\n";
    return;
  }    

  char * buffer0 = (char *) bbOps.getActualAddr(reg0->getValue(), currBB);
  char * buffer1 = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);

  char * result = strcat(buffer0,buffer1);

  debug(Abubakar) << "result = "<<result << "\n";
  debug(Abubakar) << "buffer0 = "<<buffer0 << "\n";
  debug(Abubakar) << "buffer1 = "<<buffer1 << "\n";

  uint64_t addr = bbOps.allocateHeap(strlen(buffer0)+strlen(buffer1) + 1, currBB);
  char * buffer3 = (char *) bbOps.getActualAddr(addr, currBB);
  strcpy(buffer3,result);
  addSingleVal(callInst, addr, true, true);
  
}

void ConstantFolding::handleStrCaseCmp(CallInst * callInst)
{

  debug(Abubakar) << " in str case cmp"<< "\n";
  Value * bufPtr0 = callInst->getOperand(0);
  Value * bufPtr1 = callInst->getOperand(1);  

  Register * reg0 = processInstAndGetRegister(bufPtr0);  
  Register * reg1 = processInstAndGetRegister(bufPtr1); 

   
  if(!reg0) {
        debug(Abubakar) << "handleStrCaseCmp: not found in map"<< "\n";
        return;
  }

  if(!reg1) {
    debug(Abubakar) << "handleStrCaseCmp: not found in map"<< "\n";
    return;
  }

  if(!bbOps.checkConstContigous(reg0->getValue(), currBB) || !bbOps.checkConstContigous(reg1->getValue(), currBB)) {
    debug(Abubakar) << "handleStrCaseCmp: non constant"<< "\n";
    return;
  }    

  char * buffer0 = (char *) bbOps.getActualAddr(reg0->getValue(), currBB);
  char * buffer1 = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);

  int result = strcasecmp(buffer0,buffer1);

  debug(Abubakar) << "result = "<<result << "\n";
  debug(Abubakar) << "buffer0 = "<<buffer0 << "\n";
  debug(Abubakar) << "buffer1 = "<<buffer1 << "\n";
  IntegerType * int32Ty = IntegerType::get(module->getContext(), 32);
  replaceIfNotFD(callInst, ConstantInt::get(int32Ty, result));     
    
}

void ConstantFolding::handleStrDup(CallInst * callInst)
{

  debug(Abubakar) << " in strdup"<< "\n";
  Value * bufPtr = callInst->getOperand(0);
  Register * reg = processInstAndGetRegister(bufPtr);  
   
  if(!reg) {
        debug(Abubakar) << "handleStrDup: not found in map"<< "\n";
        return;
  }

  if(!bbOps.checkConstContigous(reg->getValue(), currBB)) {
    debug(Abubakar) << "handleStrDup: non constant"<< "\n";
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

  debug(Usama) << "strdup: adding register address: " << addr << "\n";
  addSingleVal(callInst, addr, true, true);
    
}

void ConstantFolding::handleStrChr(CallInst * callInst) {
  Value * bufPtr = callInst->getOperand(0);
  Value * flagVal = callInst->getOperand(1);  
  uint64_t flag;
  Register * reg = processInstAndGetRegister(bufPtr);  
  if(!reg) {
    debug(Abubakar) << "handleStrChr : buffer Not found in Map\n";
    return;
  }
  if(!getSingleVal(flagVal, flag)) {
    debug(Abubakar) << "handleStrChr : flag not constant\n";
    bbOps.setConstContigous(false, reg->getValue(), currBB);
    return;   
  }
  char * buffer = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  debug(Abubakar) << "strchr : " << buffer << " with flag " << (char) flag << "\n";
  char * remStr = strchr(buffer, flag);
  Type * ty = callInst->getType();
  if(!remStr) {
    debug(Abubakar) << "strchr : returned NULL\n";
    ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
    replaceIfNotFD(callInst, nullP);
    return;
  }
  uint64_t addr;
  for(addr = reg->getValue(); *buffer && buffer != remStr; addr++, buffer++);
  debug(Abubakar) << "strchr : returned idx " << (addr - reg->getValue()) << "\n";
  pushFuncStack(callInst);
  regOps.addRegister(callInst, ty, addr, reg->getTracked());
}

void ConstantFolding::handleStrpbrk(CallInst * callInst) {
  Value * bufPtr = callInst->getOperand(0);
  Value * keyPtr = callInst->getOperand(1);  
  handleConstStr(keyPtr);
  Register * reg1 = processInstAndGetRegister(bufPtr);  
  if(!reg1) {
    debug(Abubakar) << "handleStrpbrk : buffer Not found in Map\n";
    return;
  }
  Register * reg2 = processInstAndGetRegister(keyPtr);  
  if(!reg2) {
    bbOps.setConstContigous(false, reg1->getValue(), currBB);
    debug(Abubakar) << "handleStrpbrk : key Not found in Map\n";
    return;
  }
  char * buffer = (char *) bbOps.getActualAddr(reg1->getValue(), currBB);
  char * key = (char *) bbOps.getActualAddr(reg2->getValue(), currBB);
  char * remStr = strpbrk(buffer, key);
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
    debug(Abubakar) << "handleAtoi : not found in map\n";
    return;
  }
  if(!bbOps.checkConstContigous(reg->getValue(), currBB)) {
    debug(Abubakar) << "handleAtoi : not constant\n";
    return;
  }
  char * str = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
  int result = atoi(str);
  IntegerType * int32Ty = IntegerType::get(module->getContext(), 32);
  replaceIfNotFD(callInst, ConstantInt::get(int32Ty, result)); 
}

//File FileIO.cpp

/*
   The following code specializes File IO Calls such as open, read, pread, lseek, fopen, fread, fgets, fseek, mmap, munmap, close,fclose

   For each opened file, a File Structure (FdInfo) is defined which stores its file pointer (in case of fopen()), 
   file descriptor (in case of open()), file name, current offset and a tracked boolean, which tells whether it can be specialized 
   or not. File Open calls will be only specialized if they are successful and have constant arguments.

   File Read calls will be specialized if they are successful and there exist a valid File structure associated with it 
   (initialized when file is opened) and a valid buffer,where the contents of file read will be stored. 
   Also the size of the file contents to be read and the offset of the file should be constant. Similarly, for File Seek Calls,
   offset and flag should be constant.

   After File Read Calls, the buffer where the file data is stored is marked as constant and the calls are replaced with memcpys instructions. 
   
   Additional File Seek calls are added for replacing File Read Calls in case the file is not completely specialized. We are handling partial specialization.

   All File IO calls are added to fileIOCalls map so that if they are successfully specialized, they can be deleted at the end.

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

  return sfd;
}

/**
 * Returns true if a valid File Descriptor is found in FdInfoMap
 * For read, pread, lseek, mmap, close only
 */

bool ConstantFolding::getfdi(int sfd, int & fd) {
  uint64_t addr = fdInfoMap[sfd];
  if(!bbOps.checkConstContigous(addr, currBB)) {
    debug(Abubakar) << "skipping non constant fd\n";
    return false;
  }
  FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB);
  if(!fdi->tracked) { 
    debug(Abubakar) << "skipping untracked fd\n";
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
  uint64_t addr = fdInfoMap[sfd];
  if(!bbOps.checkConstContigous(addr,currBB)) {
    debug(Abubakar) << "skipping non constant fptr\n";
    return false;
  }
  FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr,currBB);
  if(!fdi->tracked) { 
    debug(Abubakar) << "skipping untracked fptr\n";
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
  else if(name == "fgets")  handleFGets(ci);
  else if (name == "close")  handleClose(ci);
  else if (name == "fclose")  handleFClose(ci);
  else if (name == "feof")  handleFEOF(ci);
  else return false;
  return true;
}

void ConstantFolding::handleFEOF(CallInst * ci) {
  Value * fptrVal = ci->getOperand(0);
  uint64_t sfd;
  FILE* fptr;
  bool fdConst = getSingleVal(fptrVal, sfd)&& getfptr(sfd, fptr);
  if(!fdConst){
    if(getSingleVal(fptrVal, sfd)){
      string funcNames[2];
      funcNames[0] = "fopen";
      funcNames[1] = "fopen";
      removeFileIOCallsFromMap(funcNames, sfd);
    }
    return;
  }
  int fileC =feof(fptr);
  addSingleVal(ci,fileC,true,true);
  fileIOCalls[sfd]->insts.push_back(ci);
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
    debug(Abubakar) << "handleOpen : fname not found in map\n";
    return;
  }
  if(!getSingleVal(flagVal, flag)) {
    debug(Abubakar) << "handleOpen : flag not constant\n";
    return;   
  }
  if (std::find(std::begin(configFileNames), std::end(configFileNames), fname) != std::end(configFileNames) && flag==0){
    int fd = open(fname, flag);
    if(fd < 0) return;
    fd = initfdi(fd,fname);
    addSingleVal(ci, fd, true, true);
    FileInsts* insts = new FileInsts();
    insts->insts.push_back(ci);
    insts->isSpecialized = true;
    fileIOCalls[fd] = insts;
  } else {
    debug(Usama) << "open not specialized" << "\n";
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
    debug(Abubakar) << "handleFOpen : fname not found in map\n";
    return;
  }
  if(!getStr(modVal,fmode,100)) {
    debug(Abubakar) << "handleFOpen : fmode not found in map\n";
    return;   
  }
  if (std::find(std::begin(configFileNames), std::end(configFileNames), fname) != std::end(configFileNames) && (strcmp(fmode,"rb")==0 || strcmp(fmode,"r")==0)){
    FILE* fptr = fopen(fname, fmode);
    if(!fptr) {
      debug(Abubakar) << "handleFOpen : fopen error\n";
      return;
    }
    int fd = initfptr(fptr,fname);
    addSingleVal(ci, fd, true, true);
    FileInsts* insts = new FileInsts();
    insts->insts.push_back(ci);
    insts->isSpecialized = true;
    fileIOCalls[fd] = insts;
  }
  else {
    debug(Usama) << "fopen not specialized" << "\n";
  }
}

/**
 * Handle read() calls
 * Reads the file and if call is successful, it initializes and sets the buffer(where the file data is read to) to constant
 * Add llvm.memcpy instruction to replace read calls
 * Also updates the file offset
 * Seek call added for partial specialization
 */

void ConstantFolding::handleRead(CallInst * ci) {
  Value * fdVal = ci->getOperand(0);
  Value * bufPtr = ci->getOperand(1);
  Value * sizeVal = ci->getOperand(2);
  uint64_t size, sfd;
  int fd;
  bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);  
  Register * reg = processInstAndGetRegister(bufPtr);  
  if(!reg || !fdConst || !getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "handleRead : failed to specialize\n";
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

  if(bytes_read < 0) {
    debug(Abubakar) << "handleRead : read returned error\n";
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
  Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,gv,bytes_read,1);
  
  Constant *hookFunc;
  hookFunc = module->getOrInsertFunction("lseek", Type::getInt64Ty(module->getContext()), Type::getInt32Ty(module->getContext()),Type::getInt64Ty(module->getContext()),Type::getInt32Ty(module->getContext()),NULL);    
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
}

/**
 * Handle pread() calls
 * Reads the file and if call is successful, it initializes and sets the buffer(where the file data is read to) to constant
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
    debug(Abubakar) << "handlePRead : failed to specialize\n";
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
  if(bytes_read < 0) {
    debug(Abubakar) << "handlePRead : read returned error\n";
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
  Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,gv,bytes_read,1);
  fileIOCalls[sfd]->insts.push_back(ci);
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
    debug(Abubakar) << "handleMMap : failed to specialize\n";
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
  if (mmappedData == MAP_FAILED){
    debug(Abubakar) << "handleMMap : read returned error\n";
    setfdiUntracked(sfd);
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "open";
    removeFileIOCallsFromMap(funcNames, sfd);      
    return;     		
  }

  uint64_t addr1 = bbOps.allocateHeap(sizeof(mmappedData),currBB);
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
    debug(Abubakar) << "handleMUnmap : failed to specialize\n";
    return;
   }

  char * buffer =  (char*)bbOps.getActualAddr(reg->getValue(),currBB);


  for(int i =0; i < mMapBuffer.size();i++)
  {
    
    if(strcmp(buffer,mMapBuffer[i]->buffer)==0)
    {
     debug(Abubakar) <<"sfd equals "<<mMapBuffer[i]->sfd <<"\n";
     debug(Abubakar) <<"buffer equals "<<mMapBuffer[i]->buffer <<"\n";
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
  if (ret!=0){
    debug(Abubakar) << "handleMUnmap : read returned error\n";
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
    debug(Abubakar) << "handleFRead : failed to specialize\n";
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
  uint64_t bytes_read = fread(buffer,size,num,fptr);
  if(ferror(fptr)) {
    debug(Abubakar) << "handleFRead : read returned error\n";
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
  Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,gv,bytes_read,1);
  Constant *hookFunc;
  hookFunc = module->getOrInsertFunction("fseek", Type::getInt32Ty(module->getContext()),fptrVal->getType(),Type::getInt64Ty(module->getContext()),Type::getInt32Ty(module->getContext()),NULL);    
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
    debug(Abubakar) << "handleFGets : failed to specialize\n";
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
  char* bytes_read = fgets(buffer,size,fptr);

  if(feof(fptr)){
    debug(Abubakar) << "handleFGets : read NULL value\n";
    ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(bufPtr->getType()));     
    ci->replaceAllUsesWith(nullP);
    fileIOCalls[sfd]->insts.push_back(ci);

  }

  else if(bytes_read == NULL) {
    debug(Abubakar) << "handleFGets : read returned error\n";
    setfdiUntracked(sfd);
    bbOps.setConstContigous(false, reg->getValue(),currBB); 
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   
  }

  else{
    bbOps.setConstMem(true, reg->getValue(), strlen(bytes_read),currBB);
    setfptrOffset(sfd, fptr);
    debug(Abubakar) << "buffer value " << buffer << "\n";
    Constant * const_array = ConstantDataArray::getString(module->getContext(),StringRef(buffer),true);
    GlobalVariable * gv = new GlobalVariable(*module,const_array->getType(),true,GlobalValue::ExternalLinkage,const_array,"");
    gv->setAlignment(1);
    IRBuilder<> Builder(ci);
    Instruction* MemCpyInst = Builder.CreateMemCpy(bufPtr,gv,strlen(bytes_read),1);
    ci->replaceAllUsesWith(bufPtr);
    Constant *hookFunc;
    hookFunc = module->getOrInsertFunction("fseek", Type::getInt32Ty(module->getContext()),fptrVal->getType(),Type::getInt64Ty(module->getContext()),Type::getInt32Ty(module->getContext()),NULL);    
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
  int fd;
  bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
  if(!fdConst || !getSingleVal(offSetVal, offset) || 
  !getSingleVal(flagVal, flag)) {
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
  if(ret < 0) { 
    setfdiUntracked(sfd);
    debug(Abubakar) << "handleLSeek : seek returned error\n";
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "lseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;   

  }
  setfdiOffset(sfd, fd);
  addSingleVal(ci, ret, true, true);
  fileIOCalls[sfd]->insts.push_back(ci);
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
  if(ret != 0) { 
    setfdiUntracked(sfd);
    debug(Abubakar) << "handleFSeek : seek returned error\n";
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fseek";
    removeFileIOCallsFromMap(funcNames, sfd);    
    return;
  }
  setfptrOffset(sfd, fptr);
  addSingleVal(ci, ret, true, true);
  fileIOCalls[sfd]->insts.push_back(ci);
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
    debug(Abubakar) << "handleClose : failed to specialize\n";
    if(getSingleVal(fdVal, sfd)){
      string funcNames[2];
      funcNames[0] = "open";
      funcNames[1] = "open";
      removeFileIOCallsFromMap(funcNames, sfd);
    }  
    return;   
  }    
  int fileClose = close(fd);
  if(fileClose !=0)
  {
    debug(Abubakar) << "handleClose : close returned error\n";
    string funcNames[2];
    funcNames[0] = "open";
    funcNames[1] = "open";
    removeFileIOCallsFromMap(funcNames, sfd);
    return;

  }
  fileIOCalls[sfd]->insts.push_back(ci);
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
    debug(Abubakar) << "handleFClose : failed to specialize\n";
    if(getSingleVal(fptrVal, sfd)){
       string funcNames[2];
       funcNames[0] = "fopen";
       funcNames[1] = "fopen";
       removeFileIOCallsFromMap(funcNames, sfd);
    }  
    return;   
  }   
  int fileClose =fclose(fptr); 
  if(fileClose !=0)
  {
    debug(Abubakar) << "handleFClose : fclose returned error\n";
    string funcNames[2];
    funcNames[0] = "fopen";
    funcNames[1] = "fopen";
    removeFileIOCallsFromMap(funcNames, sfd);
    return;

  }
  fileIOCalls[sfd]->insts.push_back(ci);
}

void ConstantFolding::removeFileIOCallsFromMap(string buffer[],int sfd) {

  vector<Instruction*> insts = fileIOCalls[sfd]->insts;
  vector<Instruction*>::iterator it = insts.begin() ;
  while (it != insts.end()){
    CallInst *Inst = dyn_cast<CallInst>(*it); 
    if((Inst->getCalledFunction()->getName().str()).compare(buffer[0])==0 || (Inst->getCalledFunction()->getName().str()).compare(buffer[1])==0){
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
    debug(Abubakar) << "long_opts not found\n";
    return false;
  }
  uint64_t addr = reg->getValue();

  errs()<<"Checking if addr: "<<addr<<" is constant\n";
  if(!bbOps.checkConstContigous(addr, currBB)) {
    debug(Abubakar) << "long_opts not constant\n";
    return false;
  }
  unsigned i = 0;
  unsigned size = bbOps.getSizeContigous(addr, currBB);
  errs() << "Size of long options " << size/32<< "\n";

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
    errs()<<"{name: "<<long_opts[i].name<<", has_args: "<<long_opts[i].has_arg<<", flag: "<<long_opts[i].flag<<", val: "<<long_opts[i].val<<"}\n";
    i++;
    addr += 32;
  }
  errs()<<"i: "<<i<<"\n";
  Value * indexVal = callInst->getOperand(4);
  debug(Usama) << indexVal << " indexVal printing" << "\n";
  //errs() << *indexVal << "\n";
  if(dyn_cast<ConstantPointerNull>(indexVal)) {
    errs()<<"indexVal is a Constant Pointer Null\n";
    long_index = NULL;
  } else {
    reg = processInstAndGetRegister(indexVal);
    if(!reg) {
      debug(Abubakar) << "long_index not found\n";
      return false;
    }
    if(!bbOps.checkConstContigous(reg->getValue(), currBB)) {
      debug(Abubakar) << "long_index not constant\n";
      return false;
    }
    long_index = (int *) bbOps.getActualAddr(reg->getValue(), currBB);
  }
  memset((char *) &long_opts[i], '\0', sizeof(option)); 
  return true;
}

bool ConstantFolding::handleGetEnv(CallInst *ci) {
  Value *arg1 = ci->getOperand(0);

  Register *reg = processInstAndGetRegister(arg1);
  if(!reg) {
    debug(Usama) << "handleGetEnv: Register not found\n";
    return false;
  }

  char *str;
  if(!getStr(reg->getValue(), str)) {
    debug(Usama) << "handleGetEnv: string not constant\n";
    return false;
  }

  char *result = getenv(str);
  if(!result) {
    debug(Usama) << "handleGetEnv: returned null\n";
    addSingleVal(ci, 0, true, true);
    return true;
  }

  uint64_t addr = bbOps.allocateStack(strlen(result) + 1, currBB);
  char *actualAddr = (char *) bbOps.getActualAddr(addr, currBB);
  strcpy(actualAddr, result);
  addSingleVal(ci, addr, true, true);
  debug(Usama) << "handleGetEnv: returned " << result << "\n";
  return true;
}
bool ConstantFolding::handleGetOpt(CallInst * ci) {
  string name = ci->getCalledFunction()->getName().str();
  if(name.size() < 6 || name.substr(0, 6) != "getopt")
    return false;
  if(name == "getopt_long_only") {
    errs() << "case not handled " << name << "\n";
    return true;
  }
  uint64_t argc;
  Register * argvReg = processInstAndGetRegister(ci->getOperand(1));
  Register * optsReg = processInstAndGetRegister(ci->getOperand(2));
  Register * optindReg = processInstAndGetRegister(module->getNamedGlobal("optind"));
  debug(Usama) << "optind : " <<  bbOps.checkConstContigous(optindReg->getValue(), currBB) << " argvReg : " <<  bbOps.checkConstContigous(argvReg->getValue(), currBB) << "\n";
  if(!getSingleVal(ci->getOperand(0), argc) || !argvReg || 
  !optsReg || !optindReg || !bbOps.checkConstContigous(argvReg->getValue(), currBB) ||
  !bbOps.checkConstContigous(optindReg->getValue(), currBB)) {
    debug(Abubakar) << "conditions not satisfied\n";
    return true;
  }

  uint64_t ptrSize = DL->getTypeAllocSize(argvReg->getType());
  uint64_t intSize = DL->getTypeAllocSize(ci->getType());

  uint64_t optindAddr = optindReg->getValue();
  optind = bbOps.loadMem(optindAddr, intSize, currBB);
  char ** argv = (char **) malloc(sizeof(char *) * argc);
  uint64_t addr = argvReg->getValue();
  map<char *, uint64_t> realToVirt;
  for(unsigned i = 0, iter = addr; i < argc; i++, iter += ptrSize) {
    uint64_t strAddr = bbOps.loadMem(iter, ptrSize, currBB);
    if(!getStr(strAddr, argv[i])) {
      debug(Abubakar) << "updating argv\n";
      return true;
    }
    realToVirt[argv[i]] = strAddr;
  }
  char * opts = (char *) bbOps.getActualAddr(optsReg->getValue(), currBB);
  int result;
  if(name == "getopt_long") { 
    option * long_opts = (option *) malloc(sizeof(option) * 100);
    int * long_index;
    if(!handleLongArgs(ci, long_opts, long_index))
      return true;
    result = getopt_long_local(argc, argv, opts, long_opts, long_index);
  } else 
    result = getopt_local(argc, argv, opts);

  IntegerType * intTy = IntegerType::get(module->getContext(), intSize * 8);
  ConstantInt * resInt = ConstantInt::get(intTy, result);

  debug(Abubakar) << "getopt returned " << (char) result << "\n";
  replaceIfNotFD(ci, resInt);

  if(optarg) {
    debug(Abubakar) << "optarg is " << optarg << "\n";
    Register * optargReg = processInstAndGetRegister(module->getNamedGlobal("optarg"));
    uint64_t optArgAddr = optargReg->getValue();
    uint64_t strAddr = bbOps.loadMem(optArgAddr, ptrSize, currBB);
    if(!strAddr) {
      Type * ty = optargReg->getType()->getContainedType(0);
      uint64_t charSize = DL->getTypeAllocSize(ty);
      strAddr = bbOps.allocateHeap(charSize * 100, currBB);
      bbOps.storeToMem(strAddr, ptrSize, optArgAddr, currBB);
      debug(Abubakar) << "created new string at " << strAddr << "\n";
    }
    char * source = (char *) bbOps.getActualAddr(strAddr, currBB);
    memcpy(source, optarg, strlen(optarg));
    source[strlen(optarg)] = '\0';
  }
  bbOps.storeToMem(optind, intSize, optindAddr, currBB);
  for(unsigned i = 0, iter = addr; i < argc; i++, iter += ptrSize)
    bbOps.storeToMem(realToVirt[argv[i]], ptrSize, iter, currBB);
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

  if(clonedFnUnroller->runtest(TLI, *AC))
    return clonedFnUnroller;
  delete clonedFnUnroller;
  return NULL;
}

Loop *ConstantFolding::isLoopHeader(BasicBlock *BB, LoopInfo &LI) {
  if(!bbOps.partOfLoop(BB)) {
    return NULL; 
  }
  Loop * L = LI.getLoopFor(BB);
  if(BB != L->getHeader())
    return NULL; 

  return L;
}

/*
void ConstantFolding::updateLoopCost(ProcResult result, Instruction * I) {
  if(!I->getParent()) // constant expressions etc
    return;
  if(!testStack.size())
    return;
  LoopUnrollTest *ti = testStack[testStack.size() - 1];
  if(ti->testTerminated())
    return;
  if(findInMap(ti->InstResults, I))
    return;
  if(bbOps.partOfLoop(I->getParent())) {
    ti->InstResults[I] = PARTOFLOOP;
    ti->partOfLoop++;
    return;
  }
  ti->InstResults[I] = result;
  bool found = false;
  for(unsigned i = 0; i < I->getNumOperands(); i++) {
    Value * val = I->getOperand(i);
    if(!isa<Instruction>(val))
      continue;
    if(findInMap(ti->InstResults, dyn_cast<Instruction>(val))) {
      found = true;
      break;
    }
  }
  if(!found)
    ti->indepInsts.push_back(I);
}

unsigned ConstantFolding::getNumNodesBelow(Instruction * I, 
  map<Instruction *, unsigned> & cache, LoopUnrollTest *ti) {
  if(findInMap(cache, I))
    return cache[I];
  // getNumNodesBelow called on a use outside the loop
  if(!findInMap(ti->InstResults, I))
    return 1;
  ProcResult result = ti->InstResults[I];
  if(result == FOLDED || result == PARTOFLOOP)
    return 0;
  unsigned num = 0;
  for(Use &U : I->uses()) {
    Instruction * user = dyn_cast<Instruction>(U.getUser());
    assert(user);
    if(!bbOps.isVisited(user->getParent()))
      continue;
    num += getNumNodesBelow(user, cache, ti);      
  }      
  num = num > 0 ? num + 1 : result; // 0 if undecided, 1 if not folded
  cache[I] = num;
  return num;
}

unsigned ConstantFolding::getCost(LoopUnrollTest *ti) {
  unsigned cost = 0;
  map<Instruction *, unsigned> cache;
  for(unsigned i = 0; i < ti->indepInsts.size(); i++) {
    unsigned num = 0;
    Instruction * I = ti->indepInsts[i];
    num = getNumNodesBelow(I, cache, ti);
    cost += num;   
  }
  return cost + ti->partOfLoop;
}
*/

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
    return regOps.getRegister(ptr);

  }
  else 
    I = dyn_cast<Instruction>(ptr);
  errs()<<"ptr: "<<ptr<<", I: "<<I<<"\n";

  if(I && !I->getParent()) { // if it has a parent then it must have been visited 
    runOnInst(I);
    if(reg = regOps.getRegister(I)) {
      regOps.addRegister(ptr, reg);
    }
    I->dropAllReferences();
  }

  return reg;
}

void ConstantFolding::addToWorklistBB(BasicBlock *BB) {
  assert(BB->getParent() == currfn);
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
  if(!(unroller = unrollLoop(dyn_cast<BasicBlock>(vmap[L->getHeader()]), temp))) {
    //remove clone info
    bbOps.cleanUpFuncBBInfo(cloned);
    regOps.cleanUpFuncBBRegisters(cloned, popFuncValStack());
    return NULL;
  }

  FuncInfo *fi = initializeFuncInfo(cloned);
  addFuncInfo(cloned, fi);

  LoopInfo *LI = unroller->getLoopInfo();
  bbOps.recomputeLoopInfo(cloned, *LI);

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
  if (currFn->getName().str().substr(0,12) == "branchPruned") {
    oldFn->setName(oldFn->getName() + "_old");

    Function *f = module->getFunction("branchPruned_clone");
    if(f)
      f->setName("branchPruned_clone_old");
    currFn->setName("branchPruned_clone");
  }
  if(currFn->getName().str().substr(0,4) == "main") {
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
  
  errs() << "SIZE : " << preds.size() << "\n";
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
  errs() << *ty << " " << address <<  "\n";
  if(!ty || ty->isFunctionTy())
    return;

  if(!address)
    return;

  //if(!ty->isPointerTy())
    //return;
  if(!bbOps.checkConstMem(address, DL->getTypeAllocSize(ty), BB)) {
    debug(Usama) << "Address already non constant: " << address << "\n";
    return;
  }

  if(ty->isStructTy()) {

    errs() << "is struct type" << "\n";
    auto structLayout = DL->getStructLayout(dyn_cast<StructType>(ty));
    for(unsigned i = 0; i < ty->getStructNumElements(); i++) {
      Type *t = ty->getStructElementType(i);
      PointerType *pty = dyn_cast<PointerType>(t);
      if(!pty || pty->getElementType()->isFunctionTy()) {
        continue;
      }

      uint64_t offset = address + structLayout->getElementOffset(i);
      uint64_t size = DL->getTypeAllocSize(t);
      uint64_t val = bbOps.loadMem(offset, size, BB);
      markMemNonConst(dyn_cast<PointerType>(t)->getElementType(), val, BB); 
    }
  } else if(ty->isArrayTy() || ty->isVectorTy()) {
    errs() << "is array type " << "\n";
    auto *arrayTy = dyn_cast<SequentialType>(ty);
    Type *t = arrayTy->getElementType();
    unsigned offsetTotal = 0;
    if(t->isPointerTy()) {
      errs() << "array pointer ty " <<"\n";
      for(unsigned i = 0; i < arrayTy->getNumElements(); i++) {
        uint64_t offset = address + offsetTotal;
        uint64_t ptrSize = DL->getPointerSize();
        uint64_t value = bbOps.loadMem(offset, ptrSize, BB);
        markMemNonConst(dyn_cast<PointerType>(t)->getElementType(), value, BB);
      }
    }
  } else if(ty->isPointerTy()) {
    PointerType *t = dyn_cast<PointerType>(ty);
    if(!t->getElementType()->isFunctionTy()) {
      uint64_t value = bbOps.loadMem(address, DL->getTypeAllocSize(t->getElementType()), BB);
      markMemNonConst(t->getElementType(), value, BB);
    }
  }

  errs() << "marking mem non const in loop at address " << address << " to " << address + DL->getTypeAllocSize(ty)  <<"\n";
  bbOps.setConstContigous(false, address, BB);
}
