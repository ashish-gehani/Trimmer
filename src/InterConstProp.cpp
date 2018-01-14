#include "processInstructions.h"

using namespace llvm;
using namespace std;


static cl::opt<bool> isAnnotated("isAnnotated",
                  cl::desc("are annotations found or should the whole program be tracked"));

void ConstantFolding::getAnalysisUsage(AnalysisUsage &AU) const { 
  //AU.addRequired<MemoryDependenceAnalysis>();
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addRequired<TargetLibraryInfoWrapperPass>();
  AU.addRequired<CallGraphWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
}


void ConstantFolding::runOnInst(Instruction * I) {
  // printMem(BasicBlockContexts[currBB]->memory, 1, 20);
  // printConstMem(BasicBlockContexts[currBB]->memory, 1, 20);

  debug(Abubakar) << *I << " is the inst "; 
  if(I->getParent()) {
    debug(Abubakar) << " in BB ";
    if(debugLevel == Abubakar)
      currBB->printAsOperand(errs(), false);
    if(I->getFunction())
      debug(Abubakar) << " " << I->getFunction()->getName() << " ";
  }
  debug(Abubakar) << "\n";
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
  }
  currBB = temp;
  bbOps.freeBB(BB, BasicBlockContexts);
}

void ConstantFolding::runOnFunction(CallInst * ci, Function * toRun) {
  bool tempAnnot = currContextIsAnnotated;
  Function * temp = currfn;
  if(ci)
    updateAnnotationContext(ci->getCalledFunction());
  initializeFuncInfo(toRun);
  currfn = toRun;
  BasicBlock * entry = &toRun->getEntryBlock();
  runOnBB(entry);
  if(!ci) {
    assert(toRun->getName().str() == "main" && "callInst not given");
    return;
  }
  FuncInfo * fi = fimap[toRun];
  if(fi->retReg)
    handleInt(ci, fi->retReg->getValue(), Registers);
  assert(fi->context != NULL && "unexpected behaviour");
  copyContext(fi->context);
  currfn = temp;
  currContextIsAnnotated = tempAnnot;
  cleanUpfuncBBs(toRun, BasicBlockContexts);
}

bool ConstantFolding::runOnModule(Module & M) {
  initDebugLevel();
  debug(Abubakar) << "  ---------------- ** inter-constprop ** ----------------\n";
  module = &M;
  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  DL = new DataLayout(module);   
  CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();  

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
  currContextIsAnnotated = true;
  addGlobals();
  runOnFunction(NULL, func);

  replaceUses();

  return true;
}   
  
char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);