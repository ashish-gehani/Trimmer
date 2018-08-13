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
#include "Debug.h"
#include "ConstantFolding.h"
#include "BBInfo.h"
#include "ContextInfo.h"
#include "Utils.h"
#include "StringUtils.h"
#include "FdInfo.h"
#include "GetOptLocal.h"
#include "LoopUnroller.h"


using namespace llvm;
using namespace std;


//File InterConstProp.cpp
static cl::opt<bool> isAnnotated("isAnnotated",
                  cl::desc("are annotations found or should the whole program be tracked"));

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

/**
 * Process a single instruction appropriately
 */
void ConstantFolding::runOnInst(Instruction * I) {
  ProcResult result;
  printInst(I, Abubakar);
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

  if(isLoopTest())
    updateLoopCost(result, I);
}
/*
  run on each Instruction of the basic.
*/
void ConstantFolding::runOnBB(BasicBlock * BB) {
  bbOps.markVisited(BB);
  currBB = BB;
  ContextInfo * ci = bbOps.getContextInfo(currBB);
  for(ci->inst = BB->begin(); ci->inst != BB->end(); ci->inst++) {
    Instruction * I = &*(ci->inst);

    if(isLoopTest()) {
      LoopUnroller::checkTermInst(I, testStack.back());
      if (LoopUnroller::testTerminated(testStack.back())) // test terminated in the  term condition above
        break;
    }
    runOnInst(I);
  }  
  bbOps.freeBB(BB);
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

  while(worklistBB[worklistBB.size() - 1].size()) {
    int size = worklistBB.size() - 1;
    BasicBlock *current = worklistBB[size].back();

    worklistBB[size].pop_back();

    runOnBB(current);
  }

  currBB = tempBB;
  pop_back(worklistBB);

  if(!ci) return;

  FuncInfo * fi = fimap[toRun];
  if(!fi->context) {
    errs() << "Unexpected behavior -> no context returned : only possible if cant return from function\n";
    return;
  }
  bbOps.copyContext(fi->context, currBB);
  currfn = temp; //restore to caller
  currContextIsAnnotated = tempAnnot;

  bbOps.cleanUpFuncBBInfo(toRun);
  regOps.cleanUpFuncBBRegisters(toRun, pop_back(funcValStack));
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
  if(useAnnotations) {
    createAnnotationList();
    // createAnnotationList2();
  }

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

//File ProcessInstructions.cpp

/**
 * Process Alloca Instructions:
 * ty * %a = ty
 * allocate shadow memory of bytes sizeof(ty) on the stack and add shadow register 
 * with value equal to the starting address of the allocated memory
 */
ProcResult ConstantFolding::processAllocaInst(AllocaInst * ai) {
  if(!trackAllocas()) {
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
  if(!trackAllocas()) {
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
  if(!trackAllocas()) {
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
  
  if(bbOps.partOfLoop(li))
    return NOTFOLDED;  
  
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
  if(bbOps.partOfLoop(phiNode))
    return NOTFOLDED;
  Value * val = bbOps.foldPhiNode(phiNode);
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
  if(bbOps.partOfLoop(I))
    return NOTFOLDED;
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
  for(unsigned int index = 0; index < numS; index++) {
    BasicBlock * succ = termInst->getSuccessor(index);
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
ProcResult ConstantFolding::processCallInst(CallInst * callInst) {
  if(bbOps.partOfLoop(callInst)) {
    markArgsAsNonConst(callInst);
    return NOTFOLDED;
  }

  if(!callInst->getCalledFunction() && !simplifyCallback(callInst)) {
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
    bbOps.setConstContigous(false, reg->getValue(), currBB);
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
    if(useAnnotations && AnnotationList.find(gv) == AnnotationList.end() && 
    gv->getName() != "optarg" && gv->getName() != "optind" &&
    gv->getName() != "__argv_new__")
      continue; 
    // if(gv->isConstant() && isa<ArrayType>(contTy) && contTy->getContainedType(0)->isIntegerTy(8))
    //   continue;
    debug(Abubakar) << gv->getName() << "\n"; 
    uint64_t size = DL->getTypeAllocSize(contTy);
    uint64_t addr = bbOps.allocateStack(size, currBB);
    debug(Abubakar) << "addGlobal : size " << size << " at address " << addr << "\n";
    pushFuncStack(gv);
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

bool ConstantFolding::trackAllocas() {
  if(useAnnotations && !currContextIsAnnotated)
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
  if(Instruction * I = dyn_cast<Instruction>(from))
    updateLoopCost(FOLDED, I);
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
    duplicateContext(succ, from);
    bbOps.mergeContext(succ, from);
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
    pushFuncStack(vmap[val]);
    regOps.addRegister(vmap[val], processInstAndGetRegister(val));
  }
}

void ConstantFolding::simplifyLoop(BasicBlock * BB) {  
  LoopInfo *LI= &getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();;
  AssumptionCache *AC;

  LoopUnroller currFnUnroller(module, PreserveLCSSA, useAnnotations);
  Loop *L = NULL;

  if (!(L = isLoopHeader(BB, *LI)) || !currFnUnroller.shouldSimplifyLoop(BB, *LI) || testStack.size() > 0)
    return;

  ValueToValueMapTy vmap;
  Function *cloned = cloneFunc(currfn, vmap); //clone function

  bbOps.copyFuncBlocksInfo(currfn, vmap); //copy over old function bbinfo into cloned function

  BasicBlock * hdrClone = dyn_cast<BasicBlock>(vmap[L->getHeader()]);
  LI = &getAnalysis<LoopInfoWrapperPass>(*cloned).getLoopInfo();;
  AC = &getAnalysis<AssumptionCacheTracker>(*cloned).getAssumptionCache(*cloned);

  LoopUnroller clonedFnUnroller(module, PreserveLCSSA, useAnnotations);
  //clonedFnUnroller.getTripCount(hdrClone, TLI, *LI, *AC);

  BasicBlock *entry = clonedFnUnroller.getLoopPreHeader(hdrClone, *LI);

  ValSet oldValSet = funcValStack.back();
  push_back(funcValStack);


  cloneFuncStackAndRegisters(vmap, oldValSet ); //copy over stack and registers

  LoopUnrollTest *ti = clonedFnUnroller.runtest(hdrClone, TLI, *LI, *AC);

  if (ti) {
    testStack.push_back(ti);

    duplicateContext(entry, currBB); 
    Function * temp = currfn; 
    currfn = cloned;
    bbOps.recomputeLoopInfo(currfn, *LI);

    if(!isFuncInfoInitialized(cloned)) {
      FuncInfo *fi = initializeFuncInfo(cloned);
      addFuncInfo(cloned, fi);
    }

    runOnBB(entry);
    currfn = temp;
  }

  bbOps.cleanUpFuncBBInfo(cloned); //remove cloned BBinfo
  regOps.cleanUpFuncBBRegisters(cloned, pop_back(funcValStack)); //remove cloned registers and stack

  if(!ti)
    return;

  ti = pop_back(testStack);
  if(!ti->checkPassed())
    return;

  LI = &getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  AC = &getAnalysis<AssumptionCacheTracker>(*currfn).getAssumptionCache(*currfn);

  currFnUnroller.doUnroll(BB, TLI, *LI, *AC, ti->iterations + 1);
  LoopInfo &newLI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();

  bbOps.recomputeLoopInfo(currfn, newLI);
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

void ConstantFolding::updateLoopCost(ProcResult result, Instruction * I) {
  if(!I->getParent()) // constant expressions etc
    return;
  if(!testStack.size())
    return;
  LoopUnrollTest *ti = testStack[testStack.size() - 1];
  if(ti->terminated)
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

/*
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
  worklistBB[worklistBB.size()-1].push_back(BB);
}
