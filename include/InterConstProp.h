
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
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Analysis/CallGraph.h"
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
#include <set>
#include <ctime>

#ifndef INTERCONSTPROP_H_
#define INTERCONSTPROP_H_
#include "mem.h"

using namespace llvm;
using namespace std;

struct ConstantFolding : public ModulePass {

  static char ID;  
  Module * module;  
  const TargetLibraryInfo *TLI;
  DataLayout * DL;
  DominatorTree * DT;
  CallGraph * CG;

  Memory * memory;
  BasicBlock * currBB;
  ValToRegisterMap Registers;
  BasicBlock::iterator inst;
  set<BasicBlock *> visited;
  vector<pair<Instruction *, Instruction *> > toReplace;

  ConstantFolding(): ModulePass(ID){}
  void getAnalysisUsage(AnalysisUsage &AU) const;

  void processAllocaInst(AllocaInst *);
  void processStoreInst(StoreInst *);
  void processLoadInst(LoadInst *);
  void processGEPInst(GetElementPtrInst *);
  void processTermInst(TerminatorInst *);   
  void processCallInst(CallInst *);
  void processMemcpyInst(MemCpyInst *);
  
  Function * addClonedFunction(CallInst *, Function *);
  bool predecessorsVisited(BasicBlock *);
  void handleStringFunction(CallInst *, Function *);
  bool isStringFunction(Function * calledFunction);
  void replaceUses();
 
  virtual bool runOnModule(Module &);
  void runOnFunction(Function *);
  void runOnBB(BasicBlock *);
  void runOnInst(Instruction *);
};

#endif
