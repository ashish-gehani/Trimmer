#include "processInstructions.h"

using namespace llvm;
using namespace std;

void ConstantFolding::getAnalysisUsage(AnalysisUsage &AU) const { 
  //AU.addRequired<MemoryDependenceAnalysis>();
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addRequired<TargetLibraryInfoWrapperPass>();
  AU.addRequired<CallGraphWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
}

void ConstantFolding::runOnInst(Instruction * I) {
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
  } else if(ReturnInst * retInst = dyn_cast<ReturnInst>(I)) {
    processReturnInst(retInst);
  } else if(TerminatorInst * termInst = dyn_cast<TerminatorInst>(I)) {
    processTermInst(termInst);
  } else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(I)) {
    processMemcpyInst(memcpyInst);
  } else if(CallInst * callInst = dyn_cast<CallInst>(I)) {
    processCallInst(callInst);
  }
}

void ConstantFolding::runOnBB(BasicBlock * BB) {
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
  Function * temp = currfn;
  currfn = toRun;
  BasicBlock * entry = &toRun->getEntryBlock();
  FuncInfo * fi = new FuncInfo();
  fimap[toRun] = fi;
  runOnBB(entry);
  if(!ci) {
    assert(toRun->getName().str() == "main" && "callInst not given");
    return;
  }
  if(fi->retReg)
    handleConst(ci, fi->retReg->getValue(), Registers);
  assert(fi->context != NULL && "unexpected behaviour");
  copyContext(fi->context);
  currfn = temp;
  cleanUpfuncBBs(toRun, BasicBlockContexts);
}

bool ConstantFolding::runOnModule(Module & M) {
  initDebugLevel();
  debug(Abubakar) << "  ---------------- *** ----------------\n";
  module = &M;
  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  DL = new DataLayout(module);   
  CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();  

  Function * func = module->getFunction(StringRef("main"));
  BasicBlock * entry = &func->getEntryBlock();
  BasicBlockContexts[entry] = new ContextInfo(module);
  currBB = entry;
  addGlobals();
  runOnFunction(NULL, func);

  replaceUses();

  return true;
}   
  
char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);