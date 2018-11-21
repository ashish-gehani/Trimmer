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

#include "ConstantFolding.h"
#include "Utils.h"
#include "StringUtils.h"
#include "FdInfo.h"
#include "GetOptLocal.h"

using namespace llvm;
using namespace std;


//File InterConstProp.cpp
static cl::opt<bool> isAnnotated("isAnnotated",
                  cl::desc("are annotations found or should the whole program be tracked"));
static cl::opt<bool> trackAlloc("trackAllocas",cl::init(false),
                  cl::desc("are allocas tracked"));

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
    if(val->getType()->isPointerTy() && reg) {
      markMemNonConst(dyn_cast<PointerType>(val->getType())->getElementType(), reg->getValue(), currBB);
    } else if(reg) {
      markMemNonConst(val->getType(), reg->getValue(), currBB);
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
/*
  run on each Instruction of the basic.
*/
bool ConstantFolding::runOnBB(BasicBlock * BB) {
  bbOps.markVisited(BB);
  currBB = BB;
  ContextInfo * ci = bbOps.getContextInfo(currBB);
  for(ci->inst = BB->begin(); ci->inst != BB->end(); ci->inst++) {
    Instruction * I = &*(ci->inst);

    if(isLoopTest()) {
      LoopUnroller *unroller = testStack.back();
      unroller->checkTermInst(I);
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

        testStack.push_back(unroller);
        push_back(worklistBB);

        currfn = cloned;
        copyWorklistBB(vmap, worklistBB);
        LI = unroller->getLoopInfo();
        continue;
      } 
    }

    if(runOnBB(current)) { //loop test terminated
      LoopUnroller *unroller = pop_back(testStack);
      if(!unroller->checkPassed()) {
        BasicBlock *failedLoop;
        bbOps.cleanUpFuncBBInfo(currfn); //remove cloned BBinfo
        regOps.cleanUpFuncBBRegisters(currfn, popFuncValStack()); //remove cloned registers and stack
        pop_back(worklistBB);

        failedLoop = worklistBB[worklistBB.size() -1].back();
        worklistBB[worklistBB.size() - 1].pop_back();

        currfn = unroller->getCloneOf();
        toRun = currfn;

        LI = &getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
        //TODO hackish way of running on old failed loopHeader
        runOnBB(failedLoop);
      }else {
        //replace old function with new one
        Function *oldFn = unroller->getCloneOf();
        addToWorklistBB(current);

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
          eraseToReplace(ci, toReplace);
          toReplace.push_back(make_pair(ci, clonedCall));
        }
        renameFunctions(currfn, oldFn);
        toRun = currfn;
      }
    }
  }

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
  if(fi->retReg) addSingleVal(ci, fi->retReg->getValue());
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

  if(useAnnotations) {
    createAnnotationList();
    // createAnnotationList2();
  }

  collectCallGraphGlobals(CG);

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
    errs() << "Function: " << F->getName() << "\n";
    for(auto &val: kv.second) {
      errs() << *val << "\n";
    }
  }
}
//File ProcessInstructions.cpp

/**
 * Process Alloca Instructions:
 * ty * %a = ty
 * allocate shadow memory of bytes sizeof(ty) on the stack and add shadow register 
 * with value equal to the starting address of the allocated memory
 */
ProcResult ConstantFolding::processAllocaInst(AllocaInst * ai) {
  if(!isAllocaTracked(ai)) {
    debug(Abubakar) << "skipping untracked alloca\n";
    return NOTFOLDED;
  }  
  Type * ty = ai->getAllocatedType();
  unsigned size = DL->getTypeAllocSize(ty);
  uint64_t addr = bbOps.allocateStack(size, currBB);

  pushFuncStack(ai);
  regOps.addRegister(ai, ty, addr);
  debug(Abubakar) << "allocaInst : size " << size << " at address " << addr << "\n";
  return UNDECIDED;
}
ProcResult ConstantFolding::processMallocInst(CallInst * mi) {   
  if(!isAllocaTracked(mi)) {
    debug(Abubakar) << "skipping untracked malloc\n";
    return NOTFOLDED;
  }
  Value * sizeVal = mi->getOperand(0);
  uint64_t size;
  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "mallocInst : size not constant\n";
    return NOTFOLDED;
  }
  uint64_t addr = bbOps.allocateHeap(size, currBB);  

  pushFuncStack(mi);
  regOps.addRegister(mi, mi->getType(), addr);
  debug(Abubakar) << "mallocInst : size " << size << " at address " << addr << "\n";  
  return UNDECIDED;
}
ProcResult ConstantFolding::processCallocInst(CallInst * ci) {   
  if(!isAllocaTracked(ci)) {
    debug(Abubakar) << "skipping untracked calloc\n";
    return NOTFOLDED;
  }
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

  pushFuncStack(ci);
  regOps.addRegister(ci, ci->getType(), addr);
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
  regOps.addRegister(bi, bi->getType(), reg->getValue());
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
  if(!bbOps.checkConstMem(addr, size, currBB)) {
    debug(Abubakar) << "LoadInst : skipping non constant\n";
    return NOTFOLDED;
  }
  uint64_t val = bbOps.loadMem(addr, size, currBB);
  addSingleVal(li, val);
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
  regOps.addRegister(gi, gi->getType(), val);
  return UNDECIDED;
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
    for(auto &val: incPtrs)
      if(Register *reg = processInstAndGetRegister(val))
        markMemNonConst(reg->getType(), reg->getValue(), currBB);

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
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
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
  debug(Usama) << "marking globals for " << F->getName() << " as false \n";
  for(auto &gv: data) {
    auto reg = processInstAndGetRegister(gv);  
    if(!reg)
      continue;
    errs() << "marking global non constant: " << *gv << "\n";
    bbOps.setConstMem(false, reg->getValue(), DL->getTypeAllocSize(reg->getType()), currBB);
  }
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
  else if(calledFunction->isDeclaration()) {
    debug(Abubakar) << "skipping function : declaration\n";
    markArgsAsNonConst(callInst);
    return NOTFOLDED;
  } else {
    if (!isFuncInfoInitialized(calledFunction)) {
        FuncInfo *fi = initializeFuncInfo(calledFunction);
        addFuncInfo(calledFunction, fi);
    }
    if(useAnnotations && !satisfyConds(calledFunction)) {
      debug(Abubakar) << "skipping function : does not satisfy conds\n";
      markArgsAsNonConst(callInst);
      markGlobAsNonConst(callInst->getCalledFunction());
      return NOTFOLDED;
    }
    CallInst *clonedInst = cloneAndAddFuncCall(callInst); 
    toReplace.push_back(make_pair(callInst, clonedInst));
    runOnFunction(callInst, clonedInst->getCalledFunction()); 
  }
  return UNDECIDED;  
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
  regOps.addRegister(from, from->getType(), val);
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
    regOps.addRegister(from, ty, reg->getValue());    
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

void ConstantFolding::markArgsAsNonConst(CallInst * callInst) {
  Function* calledFunction = callInst->getCalledFunction();
  if(calledFunction && ignorefunc(calledFunction))
    return;
  if(calledFunction && calledFunction->onlyReadsMemory()) {
    return;
  }
  for(unsigned index = 0; index < callInst->getNumArgOperands(); index++) {
    Value * pointerArg = callInst->getOperand(index);
    Register * reg = processInstAndGetRegister(pointerArg);
    if(!reg)
      continue;

    if(pointerArg->getType()->isPointerTy()) {
      //assert(reg->getType()  == pointerArg->getType());
      markMemNonConst(dyn_cast<PointerType>(pointerArg->getType())->getElementType(), reg->getValue(), currBB);
    } else if(reg) {
      bbOps.setConstContigous(false, reg->getValue(), currBB); 
    }
    debug(Abubakar) << "markArgsAsNonConst : index " << index << "\n"; 
  }
}

void ConstantFolding::initializeGlobal(uint64_t addr, Constant * CC) {

  /* already initialize with zero */
  if(isa<ConstantPointerNull>(CC))
    return;    

  if(isa<ConstantAggregateZero>(CC))
    return;
  ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(CC);
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
  } else {
    for(unsigned i = 0; i < CC->getNumOperands(); i++) {
      Constant * CGI = CC->getAggregateElement(i);
      initializeGlobal(addr, CGI);
      addr += DL->getTypeAllocSize(CGI->getType());
    }
  }
}

// important globals : optind, optarg, __argv_new__
void ConstantFolding::addGlobals() {
  for(auto& global : module->globals()) {
    GlobalVariable *  gv = &global;
    Type * contTy = gv->getType()->getContainedType(0);
    if(trackAllocas && !gv->getMetadata("track") && 
    gv->getName() != "optarg" && gv->getName() != "optind" &&
    gv->getName() != "__argv_new__")
      continue; 
    // if(gv->isConstant() && isa<ArrayType>(contTy) && contTy->getContainedType(0)->isIntegerTy(8))
    //   continue;
    debug(Abubakar) << gv->getName() << "\n"; 
    uint64_t size = DL->getTypeAllocSize(contTy);
    uint64_t addr = bbOps.allocateStack(size, currBB);
    debug(Abubakar) << "addGlobal : size " << size << " at address " << addr << "\n";
    //pushFuncStack(gv);
    regOps.addRegister(gv, contTy, addr);
    if(gv->hasInitializer()) 
      initializeGlobal(addr, gv->getInitializer());
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
    //AnnotationList.insert(module->getFunction("mkCell"));
    //AnnotationList.insert(module->getFunction("snocString"));
    errs() << "Inserted custom function " << module->getFunction("snocString") << "\n";
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

bool ConstantFolding::satisfyConds(Function * F) {
  if(fimap.find(F) == fimap.end())
    return false;

  FuncInfo* fi = fimap[F];  
  if(AnnotationList.find(F) != AnnotationList.end()) 
    return true;

  return !(fi->calledInLoop || fi->addrTaken || fi->directCallInsts > 1); 
}


void ConstantFolding::addSingleVal(Value * val, uint64_t num) {
  Type * ty = val->getType();
  if(ty->isPointerTy()) {
    if(!num) {
      debug(Abubakar) << "replacing with null\n";
      ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
      replaceIfNotFD(val, nullP);
    } else {
      debug(Abubakar) << "adding Register\n";
      pushFuncStack(val);
      regOps.addRegister(val, ty, num); 
    }
  } else if(IntegerType * intTy = dyn_cast<IntegerType>(ty)) {
    debug(Abubakar) << "replacing with constant int\n";
    replaceIfNotFD(val, ConstantInt::get(intTy, num));
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
    regOps.addRegister(from, from->getType(), val);
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

bool ConstantFolding::handleStringFunc(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(simpleStrFunc(name))   simplifyStrFunc(callInst);
  else if(name == "strchr") handleStrChr(callInst);
  else if(name == "strpbrk")handleStrpbrk(callInst);
  else if(name == "atoi")   handleAtoi(callInst);
  else return false;
  return true;
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
  regOps.addRegister(callInst, ty, addr);
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
  regOps.addRegister(callInst, ty, addr);
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

int ConstantFolding::initfdi(int fd) {
	uint64_t addr = bbOps.allocateHeap(sizeof(FdInfo), currBB);
	FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB);
	fdi->fd = fd;
	fdi->offset = 0;
	fdi->tracked = true;
	srand(time(NULL));
	int sfd = rand() % 100000000 + 100000;
	fdInfoMap[sfd] = addr;
	return sfd;
}

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

void ConstantFolding::setfdiUntracked(int sfd) {
	((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd], currBB))->tracked = false;
}

void ConstantFolding::setfdiOffset(int sfd, int fd) {
	((FdInfo *) bbOps.getActualAddr(fdInfoMap[sfd], currBB))->offset = lseek(fd, 0, SEEK_CUR);
}

bool ConstantFolding::handleFileIOCall(CallInst * ci) {
	string name = ci->getCalledFunction()->getName();
	if(name == "open") 		 handleFileIOOpen(ci);
	else if(name == "read")  handleFileIORead(ci);
	else if(name == "lseek") handleFileIOLSeek(ci);
	else return false;
	return true;
}

void ConstantFolding::handleFileIOOpen(CallInst * ci) {
	Value * nameptr = ci->getOperand(0);
	char * fname;
	Value * flagVal = ci->getOperand(1);
	uint64_t flag; 
	if(!getStr(nameptr, fname, 100)) {
		debug(Abubakar) << "handleFileIOOpen : fname not found in map\n";
		return;
	}
	if(!getSingleVal(flagVal, flag)) {
		debug(Abubakar) << "handleFileIOOpen : flag not constant\n";
		return;   
	}
	int fd = open(fname, flag);
	if(fd < 0) return;
	fd = initfdi(fd);
	addSingleVal(ci, fd);
}

void ConstantFolding::handleFileIORead(CallInst * ci) {
	Value * fdVal = ci->getOperand(0);
	Value * bufPtr = ci->getOperand(1);
	Value * sizeVal = ci->getOperand(2);
	uint64_t sfd, size;
	int fd;
	bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
	Register * reg = processInstAndGetRegister(bufPtr);  
	if(!reg || !fdConst || !getSingleVal(sizeVal, size)) {
		debug(Abubakar) << "handleFileIORead : failed to specialize\n";
		if(fdConst) setfdiUntracked(sfd);
		if(reg) bbOps.setConstContigous(false, reg->getValue(), currBB);
		return;   
	}
	char * buffer = (char *) bbOps.getActualAddr(reg->getValue(), currBB);
	int bytes_read = read(fd, buffer, size);
	if(bytes_read < 0) {
		debug(Abubakar) << "handleFileIORead : read returned error\n";
		setfdiUntracked(sfd);
		bbOps.setConstContigous(false, reg->getValue(), currBB);
		return;   		
	}
	bbOps.setConstMem(true, reg->getValue(), bytes_read, currBB);
	setfdiOffset(sfd, fd);
	addSingleVal(ci, bytes_read);
}
void ConstantFolding::handleFileIOLSeek(CallInst * ci) {
	Value * fdVal = ci->getOperand(0);
	Value * offSetVal = ci->getOperand(1);
	Value * flagVal = ci->getOperand(2);
	uint64_t sfd, offset, flag;
	int fd;
	bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
	if(!fdConst || !getSingleVal(offSetVal, offset) || 
		!getSingleVal(flagVal, flag)) {
		if(fdConst) setfdiUntracked(sfd);
		debug(Abubakar) << "handleFileIOLSeek : failed to specialize\n";
		return;   
	}	
	int ret = lseek(fd, offset, flag);
	if(ret < 0) { 
		setfdiUntracked(sfd);
		debug(Abubakar) << "handleFileIOLSeek : seek returned error\n";
		return;
	}
	setfdiOffset(sfd, fd);
	addSingleVal(ci, ret);
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
  if(!bbOps.checkConstContigous(addr, currBB)) {
    debug(Abubakar) << "long_opts not constant\n";
    return false;
  }
  unsigned i = 0;
  while(1) {
    uint64_t nameAddr = bbOps.loadMem(addr, 8, currBB);
    if(!nameAddr)
      break;
    long_opts[i].name = (char *) bbOps.getActualAddr(nameAddr, currBB);
    long_opts[i].has_arg = bbOps.loadMem(addr + 8, 4, currBB);
    uint64_t flagAddr = bbOps.loadMem(addr + 12, 8, currBB);
    long_opts[i].flag = !flagAddr ? 0 : (int *) bbOps.getActualAddr(flagAddr, currBB);
    long_opts[i].val = bbOps.loadMem(addr + 20, 4, currBB);
    if(!long_opts[i].name)
      break;
    i++;
    addr += 32;
  }
  Value * indexVal = callInst->getOperand(4);
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
  memset((char *) &long_opts[i], '\0', sizeof(option)); 
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
    pushFuncStack(vmap[val]);
    regOps.addRegister(vmap[val], processInstAndGetRegister(val));
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
  else 
    I = dyn_cast<Instruction>(ptr);

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
      Value *ptr = dyn_cast<StoreInst>(&I)->getOperand(1);
      PointerType *type = dyn_cast<PointerType>(ptr->getType());
      Register *reg = processInstAndGetRegister(ptr);
      if(!reg)
        continue;
      uint64_t size = DL->getTypeAllocSize(reg->getType()); 
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
  if(!ty)
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

      if(!t->isPointerTy()) {
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
    uint64_t value = bbOps.loadMem(address, DL->getTypeAllocSize(t->getElementType()), BB);
    markMemNonConst(t->getElementType(), value, BB);
  }

  errs() << "marking mem non const in loop at address " << address << " to " << address + DL->getTypeAllocSize(ty)  <<"\n";
  bbOps.setConstContigous(false, address, BB);
}
