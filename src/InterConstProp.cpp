#include "processInstructions.h"

using namespace llvm;
using namespace std;


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
  AU.addPreserved<ScalarEvolutionWrapperPass>();
  AU.addRequired<TargetTransformInfoWrapperPass>();
  // FIXME: Loop unroll requires LCSSA. And LCSSA requires dom info.
  // If loop unroll does not preserve dom info then LCSSA pass on next
  // loop will receive invalid dom info.
  // For now, recreate dom info, if loop is unrolled.
  AU.addPreserved<DominatorTreeWrapperPass>();

}


void ConstantFolding::runOnInst(Instruction * I) {
  printInst(I, Abubakar);
  if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(I)) {
    processAllocaInst(allocaInst);  
  } else if(BitCastInst * bitCastInst = dyn_cast<BitCastInst>(I)) {
    processBitCastInst(bitCastInst);
  } else if(StoreInst * storeInst = dyn_cast<StoreInst>(I)) {
    processStoreInst(storeInst);
  } else if(LoadInst * loadInst = dyn_cast<LoadInst>(I)) {
    processLoadInst(loadInst);
  } else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(I)) {
    processGEPInst(GEPInst);
  } else if(PHINode * phiNode = dyn_cast<PHINode>(I)) {
    processPHINode(phiNode);
  } else if(ReturnInst * retInst = dyn_cast<ReturnInst>(I)) {
    processReturnInst(retInst);
  } else if(TerminatorInst * termInst = dyn_cast<TerminatorInst>(I)) {
    processTermInst(termInst);
  } else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(I)) {
    processMemcpyInst(memcpyInst);
  } else if(MemSetInst * memsetInst = dyn_cast<MemSetInst>(I)) {
    processMemSetInst(memsetInst);
  } else if(CallInst * callInst = dyn_cast<CallInst>(I)) {
    processCallInst(callInst);
  } else 
    tryfolding(I);
}

void ConstantFolding::runOnBB(BasicBlock * BB) {
  bbOps.addAncestor(BB, currBB);
  BasicBlock * temp = currBB;
  currBB = BB;
  ContextInfo * ci = BasicBlockContexts[currBB];
  bbOps.markVisited(BB);
  for(ci->inst = BB->begin(); ci->inst != BB->end(); ci->inst++) {
    Instruction * I = &*(ci->inst);
    runOnInst(I);
    if(terminateBB) { // loop peeled and as a result this inst has changed
      terminateBB = false;
      break;
    } 
  }  
  currBB = temp;
  bbOps.freeBB(BB, BasicBlockContexts);
}

void ConstantFolding::runOnFunction(CallInst * ci, Function * toRun) {

  if(!ci) assert(toRun->getName().str() == "main" && "callInst not given");

  push_back(funcValStack);

  bool tempAnnot = currContextIsAnnotated;
  Function * temp = currfn;
  if(ci) {
    Function * calledFunction = ci->getCalledFunction();
    unsigned index = 0;
    for(auto arg = calledFunction->arg_begin(); arg != calledFunction->arg_end();
        arg++, index++) {
      Value * callerVal = ci->getOperand(index);
      Value * calleeVal = getArg(toRun, index);
      replaceOrCloneRegister(calleeVal, callerVal);
    }
    updateAnnotationContext(calledFunction);
  }
  initializeFuncInfo(toRun);
  currfn = toRun;
  BasicBlock * entry = &toRun->getEntryBlock();
  runOnBB(entry);

  if(!ci) return;

  FuncInfo * fi = fimap[toRun];
  assert(fi->context != NULL && "unexpected behaviour");
  copyContext(fi->context);
  currfn = temp;
  currContextIsAnnotated = tempAnnot;
  cleanUpfuncBBs(toRun, BasicBlockContexts, Registers, pop_back(funcValStack));
  if(fi->retReg)
    handleInt(ci, fi->retReg->getValue());

}

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
  initializeFuncInfo(func);
  createNewContext(entry);
  currBB = entry;
  terminateBB = false;
  currContextIsAnnotated = true;
  addGlobals();
  runOnFunction(NULL, func);

  replaceUses();

  return true;
}   
  
char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);