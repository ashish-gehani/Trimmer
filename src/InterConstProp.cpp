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
#include "processInstructions.h"

using namespace llvm;
using namespace std;

void ConstantFolding::getAnalysisUsage(AnalysisUsage &AU) const { 
  //AU.addRequired<MemoryDependenceAnalysis>();
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addRequired<TargetLibraryInfoWrapperPass>();
  AU.addRequired<CallGraphWrapperPass>();
}

void ConstantFolding::runOnInst(Instruction * I) {
  Registers[I] = new Register(I->getType(), 1);
  errs() << "first done\n";
  errs() << *I << " is the inst in " << I->getFunction()->getName() << "\n";
  Registers[I] = new Register(I->getType(), 1);
  errs() << "second done\n";
  if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(I)) {
    processAllocaInst(allocaInst);  
  } else if(StoreInst * storeInst = dyn_cast<StoreInst>(I)) {
    processStoreInst(storeInst);
  } else if(LoadInst * loadInst = dyn_cast<LoadInst>(I)) {
    processLoadInst(loadInst);
  } else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(I)) {
    processGEPInst(GEPInst);
  } else if(TerminatorInst * termInst = dyn_cast<TerminatorInst>(I)) {
    processTermInst(termInst);
  } else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(I)) {
    processMemcpyInst(memcpyInst);
  } else if(CallInst * callInst = dyn_cast<CallInst>(I)) {
    processCallInst(callInst);
  } 
}

void ConstantFolding::runOnBB(BasicBlock * BB) {
  visited.insert(BB);
  BasicBlock::iterator temp = inst;
  for (inst = BB->begin(); inst != BB->end(); inst++) {
    Instruction * I = &*inst;
    runOnInst(I);
  }
  inst = temp;
}

void ConstantFolding::runOnFunction(Function * toRun) {
  BasicBlock * entry = &toRun->getEntryBlock();
  runOnBB(entry);
}

bool ConstantFolding::runOnModule(Module & M) {
  errs() << "***************************************************\n";
  module = &M;
  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  DL = new DataLayout(module);   
  CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();  
  memory = new Memory(module);

  Function * func = module->getFunction(StringRef("main"));
  BasicBlock * entry = &(func->getEntryBlock());
  errs() << "first\n";
  Register * reg = new Register(NULL, 1);
  errs() << "done\n";
  runOnBB(entry);   

  replaceUses();

  return true;
}   
  


char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);