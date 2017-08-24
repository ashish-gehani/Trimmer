
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
#include "Utils.cpp"
#include <set>
#include <ctime>

using namespace llvm;
using namespace std;

struct ConstantFolding : public ModulePass {

  static char ID;  
  Module * M;  
  
  bool useAnnotations;
  bool currContextIsAnnotated;
  set<Value *> AnnotationList;

  const TargetLibraryInfo *TLI;
  DataLayout * DL;
  DominatorTree * DT;
  CallGraph * CG;
  
  map<Function*, FuncInfo*> FuncInfoMap;  
  map<BasicBlock *, BBInfo *> BBInfoMap;

  map<Instruction *, vector<CallOperand*>> replaceOperands;
  map<Function *, SpecializedCall*> specializedCalls;

  BasicBlock * currBB;
  BasicBlockContInfoMap BasicBlockContexts;
  set<BasicBlock *> visited;

  vector<GlobalIdPair> GlobalIdList;

  void processAllocaInst(AllocaInst * allocaInst);

  void processBitCastInst(BitCastInst * bitcastInst);
 
  void processMemcpyInst(MemCpyInst * memcpyInst);

  void processMallocInst(CallInst * mallocInst, Instruction* I);
 
  void processStoreInst(StoreInst * storeInst);

  void processLoadInst(LoadInst * loadInst);

  void processGEPInst(GetElementPtrInst * GEPInst);

  void processCallInst(CallInst * callInst);

  void processBranchInst(BranchInst * branchInst);

  void processSwitchInst(SwitchInst * switchInst);
  
  void VisitSuccessors(TerminatorInst * termInst);
  
  void processReturnInst(ReturnInst * returnInst);
 
  ConstantFolding(): ModulePass(ID){}

  // Adding llvm::MemoryDependenceAnalysis as a required PrePass                                                         
  virtual void getAnalysisUsage(AnalysisUsage &AU) const;

  // TODO: Make sure cloned functions calling other specialized routines are correctly retained
  void replaceCallInsts();  
  
  void replaceCallOperands(); 
  void gatherFuncInfo();
  void gatherGlobals();
  bool satisfyConds(Function* F);

  void allocate(Type * ty, Value * val);
  void allocate(AggregateAlloca * aa, Value * val);
  void allocate(SSAPointer * sptr, Value * val);
  bool trackAllocas();

  void createAnnotationList(); 
  void updateAnnotationContext(Function * F);
  void markGlobalUses(Value * val, GlobalVariable * gv);
  void propagateGlobalUses();
  void initializeGlobal(GlobalVariable * gv);  

  bool predecessorsVisited(BasicBlock * BB);
  bool mergeContext(BasicBlock * BB, BasicBlock * prev, ContextInfo * newCi);
  
  SSAPointer * getSSAPointer(Value * val, ContextInfo * ci);
  Function * addClonedFunction(CallInst * ci, Function * F);

  void markSpecialized(BasicBlock * BB);
 
  void runOnBB();
  void runOnInst(Instruction * I);
  virtual bool runOnModule(Module & module);

};