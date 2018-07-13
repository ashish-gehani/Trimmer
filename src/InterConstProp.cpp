#include "ProcessInstructions.cpp"

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
  updateCM(result, I);
}
/*
  run on each Instruction of the basic.
*/
void ConstantFolding::runOnBB(BasicBlock * BB) {
  bbOps.addAncestor(BB, currBB);
  bbOps.markVisited(BB);
  BasicBlock * temp = currBB;
  currBB = BB;
  ContextInfo * ci = BasicBlockContexts[currBB];
  for(ci->inst = BB->begin(); ci->inst != BB->end(); ci->inst++) {
    Instruction * I = &*(ci->inst);
    checkTermInst(I);    
    if(testTerminated()) // test terminated in the  term condition above
      break;
    runOnInst(I);
  }  
  currBB = temp;
  bbOps.freeBB(BB, BasicBlockContexts);
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
  initializeFuncInfo(toRun);

  Function * temp = currfn;
  currfn = toRun; //update to callee

  BasicBlock * entry = &toRun->getEntryBlock();
  runOnBB(entry);

  if(!ci) return;

  FuncInfo * fi = fimap[toRun];
  if(!fi->context) {
    errs() << "Unexpected behavior -> no context returned : only possible if cant return from function\n";
    return;
  }
  copyContext(fi->context);
  currfn = temp; //restore to caller
  currContextIsAnnotated = tempAnnot;

  cleanUpfuncBBs(toRun, BasicBlockContexts, Registers, pop_back(funcValStack));
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
  createNewContext(entry);

  currBB = entry;
  currContextIsAnnotated = true;
  addGlobals();
  runOnFunction(NULL, func);

  replaceUses();

  return true;
}   
  
char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);
