
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
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
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Analysis/CallGraph.h"

#include "llvm/Transforms/Scalar.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Transforms/Utils/UnrollLoop.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/Analysis/OptimizationDiagnosticInfo.h"

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

#include "debug.h"
#include "BBOps.h"

using namespace llvm;
using namespace std;

struct ConstantFolding : public ModulePass {

  static char ID;  
  Module * module;  
  BBOps bbOps;
  TargetLibraryInfo * TLI;
  DataLayout * DL;
  DominatorTree * DT;
  CallGraph * CG;

  BasicBlock * currBB;
  bool terminateBB;
  Function * currfn;
  BasicBlockContInfoMap BasicBlockContexts;
  FuncInfoMap fimap;
  vector<InstPair> toReplace;
  ValToRegisterMap Registers;

  vector<TestInfo *> testStack;
  bool PreserveLCSSA;

  vector<ValSet> funcValStack;
  bool currContextIsAnnotated;
  bool useAnnotations;
  set<Value *> AnnotationList;

  ConstantFolding(): ModulePass(ID){}
  void getAnalysisUsage(AnalysisUsage &AU) const;

  ProcResult processAllocaInst(AllocaInst *);
  ProcResult processStoreInst(StoreInst *);
  ProcResult processLoadInst(LoadInst *);
  ProcResult processGEPInst(GetElementPtrInst *);
  ProcResult processCallInst(CallInst *);
  ProcResult processMemcpyInst(MemCpyInst *);
  ProcResult processMemSetInst(MemSetInst * memsetInst);
  ProcResult processMallocInst(CallInst *);
  ProcResult processCallocInst(CallInst *);
  ProcResult processBitCastInst(BitCastInst *);  
  ProcResult processPHINode(PHINode *);
  ProcResult processReturnInst(ReturnInst *);
  ProcResult processTermInst(TerminatorInst *);   
  ProcResult tryfolding(Instruction *);

  void createAnnotationList();
  void createAnnotationList2();
  void updateAnnotationContext(Function * F);
  bool trackAllocas();
  
  void initializeFuncInfo(Function *);
  void updatefuncInfo(Function *, FuncInfo *);
  bool satisfyConds(Function *);
  
  Instruction * simplifyInst(Instruction *);
  CmpInst * foldCmp(CmpInst *);
  bool getPointerAddr(Value *, uint64_t&);

  Function * addClonedFunction(Function *, ValueToValueMapTy& vmap);
  Function * addClonedFunction(CallInst *, Function *);
  bool predecessorsVisited(BasicBlock *);
  void handleStringFunction(CallInst *, Function *);
  void handleGetOpt(CallInst *);
  void handleAtoi(CallInst *);
  bool handleLongArgs(CallInst *, option *, int *&);
  void replaceUses();
  void markArgsAsNonConst(CallInst* callInst);
  void addGlobals();
  void initializeGlobal(uint64_t, Constant *);
  
  bool getSingleVal(Value * val, uint64_t& i);
  // bool getStr(Value * ptr, char *& str);
  bool getStr(Value * ptr, char *& str, uint64_t size);
  bool getStr(uint64_t addr, char *& str);
  bool handleConstStr(Value *);
  void handleInt(Value *, uint64_t);
  void replaceAndLog(Value *, Value *);

  CallInst * getTestInst(string name);
  void createNewContext(BasicBlock * BB);
  void cloneContext(BasicBlock *);  
  void duplicateContext(BasicBlock *);
  void initializeBBInfo(BasicBlock * BB);
  Memory * duplicateMem();
  ContextInfo * getCurrContext();
  void copyContext(Memory *);
  uint64_t allocateStack(uint64_t);
  uint64_t allocateHeap(uint64_t);
  uint64_t loadMem(uint64_t, uint64_t);
  void storeToMem(uint64_t, uint64_t, uint64_t);  
  void * getActualAddr(uint64_t);
  void setConstMem(bool, uint64_t, uint64_t);
  void setConstContigous(bool, uint64_t);
  bool checkConstContigous(uint64_t addr);
  uint64_t getRemainingContigousSize(uint64_t);
  bool checkConstMem(uint64_t, uint64_t);
  bool checkConstStr(uint64_t);
  bool checkConstStr(uint64_t, uint64_t);
  void addRegister(Value *, Register *);
  void addRegister(Value *, Type *, uint64_t);
  void addGlobalRegister(Value *, Type *, uint64_t);
  bool cloneRegister(Value *, Value *);
  bool replaceOrCloneRegister(Value *, Value *);
  Register * getRegister(Value *);

  LoopOp simplifyLoop(BasicBlock *);
  TestInfo * runtest(Loop *, LoopOp &, unsigned &);
  bool runOp(BasicBlock *, LoopOp, unsigned);
  LoopOp getOp(BasicBlock *, unsigned &);
  void checkTermCond(BasicBlock *);
  void updateCM(ProcResult, Instruction *);
  bool testTerminated();
  unsigned getCost(TestInfo * ti);
  unsigned getNumNodesBelow(Instruction * I,
  map<Instruction *, unsigned> &, TestInfo *);

  virtual bool runOnModule(Module &);
  void runOnFunction(CallInst *, Function *);
  void runOnBB(BasicBlock *);
  void runOnInst(Instruction *);
};

#endif