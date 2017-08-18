
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
   
  // map<Value*, StringAlloca*> stringAllocas;  
  // stringPointers is a map of constant pointers - string pointers with constant index into alloca   
  //map<Value*, StringPointer*> stringPointers;
  map<Instruction *, vector<CallOperand*>> replaceOperands;
  map<Function *, SpecializedCall*> specializedCalls;
  vector<GlobalIdPair> GlobalIdList;
  BasicBlockContInfoMap BasicBlockContexts;
  BasicBlock * currBB;
  set<BasicBlock *> visited;
  set<BasicBlock *> writesToMemory;
  Module * M;  
  const TargetLibraryInfo *TLI;
  DataLayout * DL;
  DominatorTree * DT;
  CallGraph * CG;
  map<Function*, FuncInfo*> FuncInfoMap;  
  unsigned numGlobals;

  void processAllocaInst(AllocaInst * allocaInst, BasicBlock::iterator & inst);

  void processBitCastInst(BitCastInst * bitcastInst, BasicBlock::iterator & inst);
 
  void processMemcpyInst(MemCpyInst * memcpyInst, BasicBlock::iterator & inst);

  void processMallocInst(CallInst * mallocInst, Instruction* I);
 
  void processStoreInst(StoreInst * storeInst, BasicBlock::iterator & inst);

  void processLoadInst(LoadInst * loadInst, BasicBlock::iterator & inst);

  void processGEPInst(GetElementPtrInst * GEPInst, BasicBlock::iterator & inst);

  void processCallInst(CallInst * callInst, BasicBlock::iterator & inst, clock_t & timeVal);

  void processBranchInst(BranchInst * branchInst, BasicBlock::iterator & inst, clock_t & timeVal);

  void processSwitchInst(SwitchInst * switchInst, BasicBlock::iterator & inst, clock_t & timeVal);
  
  void VisitSuccessors(TerminatorInst * termInst, clock_t & timeVal);
  
  void processReturnInst(ReturnInst * returnInst, BasicBlock::iterator & inst);
 
  ConstantFolding(): ModulePass(ID){}

  // Adding llvm::MemoryDependenceAnalysis as a required PrePass                                                         
  virtual void getAnalysisUsage(AnalysisUsage &AU) const;
  
  void replaceCallOperands(); 
  SSAPointer * getSSAPointer(Value * val, ContextInfo * ci);
  void gatherFuncInfo();
  void gatherGlobals();
  void allocate(Type * ty, Value * val);
  void allocate(AggregateAlloca * aa, Value * val);
  void allocate(SSAPointer * sptr, Value * val);
  void markGlobalUses(Value * val, GlobalVariable * gv);
  void propagateGlobalUses();
  Function * addClonedFunction(CallInst * ci, Function * F);
  // TODO: Make sure cloned functions calling other specialized routines are correctly retained
  void replaceCallInsts();  
 
  void markSpecialized(BasicBlock * BB);
 
  bool satisfyConds(Function* F);

  /* IMP: New policy - visited passed by reference; no basic block visited twice - important to avoid wrongly 
          duplicating contexts e.g function cloning */ 
  void runOnBB();
  void runOnInst(Instruction * I, BasicBlock::iterator & inst);
  virtual bool runOnModule(Module & module);

};