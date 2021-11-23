/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */
 /* This is the main header file for the ConstantFolding Pass. It defines a class ConstantFolding, which is inherited from LLVM Module Pass. All the methods 
of the class are defined in src/Transforms/ConstantFolding.cpp.*/

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
#include "llvm/Analysis/OptimizationRemarkEmitter.h"

#include <getopt.h>
#include <list>

#ifndef INTERCONSTPROP_H_
#define INTERCONSTPROP_H_

#include "Debug.h"
#include "BBOps.h"
#include "ContextInfo.h"
#include "BBInfo.h"
#include "FuncInfo.h"
#include "RegOps.h"
#include "LoopUnroller.h"
#include "FileInsts.h"
#include "MMapInfo.h"
#include "Stats.h"

typedef map<Function *, FuncInfo *> FuncInfoMap;
typedef pair<Instruction *, Instruction *> InstPair;
typedef set<Value *> ValSet;
typedef vector<BasicBlock *> BBList;

using namespace llvm;
using namespace std;

struct Cycle {
  set<Function *> nodes;
  set<GlobalVariable *> values;
};

struct FuncSpecDetail {
  Memory *context;
  bool fail;
  CallInst *call;
};

struct ConstantFolding : public ModulePass {

  static char ID;  
  Module * module;  
  BBOps bbOps;
  Stats stats;
  TargetLibraryInfo * TLI;
  DataLayout * DL;
  DominatorTree * DT;
  CallGraph * CG;
  RegOps regOps;
  map<Value*, Value*> ptrMap;
  map<Function *, set<GlobalVariable *> > modSet;
  map<Function *, FuncSpecDetail *> funcSpecMap;
  bool exit;

  set<Value *> trackedValues;

  BasicBlock * currBB;
  bool terminateBB;
  Function * currfn;
  
  FuncInfoMap fimap;
  vector<InstPair> toReplace;

  vector<LoopUnroller*> testStack;
  vector<BBList> worklistBB;
  bool PreserveLCSSA;

  vector<ValSet> funcValStack;
  bool currContextIsAnnotated;
  bool useAnnotations;
  bool trackAllocas;
  set<Value *> AnnotationList;
  map<int, uint64_t> fdInfoMap; 
  map<uint64_t,FileInsts*> fileIOCalls;
  list<string> configFileNames;
  int numConfigFiles;
  vector<MMapInfo*> mMapBuffer; 
  const unsigned short int * traitsTable;

  ConstantFolding(): ModulePass(ID){ exit = 0;}
  void getAnalysisUsage(AnalysisUsage &AU) const;

  ProcResult processAllocaInst(AllocaInst *);
  ProcResult processStoreInst(StoreInst *);
  ProcResult processLoadInst(LoadInst *);
  ProcResult processGEPInst(GetElementPtrInst *);
  ProcResult processCallInst(CallInst *);
  ProcResult processMemcpyInst(CallInst *);
  ProcResult processPtrToInt(PtrToIntInst *);
  ProcResult processIntToPtr(IntToPtrInst *);
  ProcResult processMemSetInst(CallInst *);
  ProcResult processMemMoveInst(CallInst *); 
  ProcResult processMallocInst(CallInst *);
  ProcResult processReallocInst(CallInst *);
  ProcResult processCallocInst(CallInst *);
  ProcResult processBitCastInst(BitCastInst *);  
  ProcResult processPHINode(PHINode *);
  ProcResult processReturnInst(ReturnInst *);
  ProcResult processTermInst(TerminatorInst *);   
  ProcResult processPtrToIntInst(PtrToIntInst *);
  ProcResult tryfolding(Instruction *);

  Register *processInstAndGetRegister(Value *);

  void createAnnotationList();
  void createAnnotationList2();
  void updateAnnotationContext(Function * F);
  bool isAllocaTracked(Instruction *);
  
  FuncInfo* initializeFuncInfo(Function *);
  bool isFuncInfoInitialized(Function *F);
  void addFuncInfo(Function *F, FuncInfo *fi);
  bool satisfyConds(Function *, CallInst *);
  
  Instruction * simplifyInst(Instruction *);
  CmpInst * foldCmp(CmpInst *);
  bool getPointerAddr(Value *, uint64_t&);

  CallInst *cloneAndAddFuncCall(CallInst *);
  bool predecessorsVisited(BasicBlock *);

  Function *simplifyCallback(CallInst *);
  bool handleDbgCall(CallInst *);
  bool handleHeapAlloc(CallInst *);
  bool handleMemInst(CallInst *);

  bool handleStringFunc(CallInst *);
  bool handleStrSep(CallInst *);
  void handleStrChr(CallInst *); 
  void handleStrpbrk(CallInst * );
  void handleStrnCpy(CallInst *);
  void handleStrCpy(CallInst *);
  void handleStrrChr(CallInst *);
  void simplifyStrFunc(CallInst *);
  void handleAtoi(CallInst *);
  void handleStrCaseCmp(CallInst *); 
  void handleStrDup(CallInst *); 
  void handleStrTok(CallInst *); 
  void handleStrCat(CallInst *);
  void handleStrTol(CallInst *);
  void handleStrnDup(CallInst *);
  void handleCTypeFuncs(CallInst *);

  void handleCIsSpace(CallInst *);
  void handleCIsalnum(CallInst *);
  void handleCToLower(CallInst *);
  void handleCIsDigit(CallInst *);

  bool handleGetOpt(CallInst *);  
  bool handleLongArgs(CallInst *, option *, int *&);
  
  bool handleLibCCall(CallInst *callInst);
  bool handleBasename(CallInst *);
  bool handleCTypeBLoc(CallInst *callInst);
  bool handleCTypeBLocLower(CallInst *callInst);
  int initfdi(int,char*); 
  int initfptr(FILE*,char*); 
  bool getfdi(int, int &);
  bool getfptr(int, FILE* &);
  void setfdiUntracked(int);
  bool getfdiUntracked(int);
  void setfdiOffset(int, int);
  long getfdiOffset(int, int);
  void setfptrOffset(int, FILE*);
  long getfptrOffset(int, FILE*);
  bool handleFileIOCall(CallInst *);
  bool handleSysCall(CallInst *);
  bool handleGetUid(CallInst *);
  bool handleGetGid(CallInst *);
  bool handleGetPwUid(CallInst *);
  bool handleGetCwd(CallInst *);
  bool handleCBM(CallInst *);
  void handleOpen(CallInst *);
  void handleFOpen(CallInst *);
  void handleFEOF(CallInst *);
  void handleRead(CallInst *);
  void handlePRead(CallInst *);
  void handleMMap(CallInst *);
  void handleMUnmap(CallInst *);
  void handleFRead(CallInst *);
  void handleLSeek(CallInst *);
  void handleFSeek(CallInst *);
  void handleFGets(CallInst *);
  void handleGetLine(CallInst *);
  void handleClose(CallInst *);
  void handleFClose(CallInst *);
  void removeFileIOCallsFromMap(string buffer[],int);
  bool handleStat(CallInst *);
  bool handleFileNo(CallInst *);
  bool handleFStat(CallInst *);	
  bool handleGetEnv(CallInst *);

      
  void replaceUses();
  void deleteFileIOCalls();
  void markArgsAsNonConst(CallInst* callInst);
  void addGlobals();
  uint64_t addGlobal(GlobalVariable* );

  void initializeGlobal(uint64_t, Constant *);
  
  bool getSingleVal(Value *, uint64_t&);
  void addSingleVal(Value *, uint64_t, bool replace64 = false, bool tracked = false);

  // bool getStr(Value * ptr, char *& str);
  bool getStr(Value * ptr, char *& str, uint64_t size);
  bool getStr(uint64_t addr, char *& str);
  uint64_t createConstStr(string str);
  bool handleConstStr(Value *);
  
  bool isFileDescriptor(Value *);
  void replaceIfNotFD(Value *, Value *);

  void copyCallerContext(CallInst *, Function *);
  void duplicateContext(BasicBlock *, BasicBlock *);
  void propagateArgs(CallInst *, Function *);

  bool cloneRegister(Value *, Value *);
  bool replaceOrCloneRegister(Value *, Value *);

  bool visitBB(BasicBlock *, BasicBlock *);
  void visitReadyToVisit(vector<BasicBlock *>);

  LoopUnroller *unrollLoop(BasicBlock *, BasicBlock *&);
  LoopUnrollTest* runtest(Loop *);
  void checkTermInst(Instruction *);
  void checkTermBB(BasicBlock *);
  bool checkUnrollHint(BasicBlock *, LoopInfo &LI);
  void updateLoopCost(ProcResult, Instruction *);
  bool testTerminated();
  unsigned getCost(LoopUnrollTest* ti);
  unsigned getNumNodesBelow(Instruction * I,
  map<Instruction *, unsigned> &, LoopUnrollTest *);

  bool runOnModule(Module &);
  void runOnFunction(CallInst *, Function *);
  bool runOnBB(BasicBlock *);
  void runOnInst(Instruction *);

  void pushFuncStack(Value *val);

  bool isLoopTest();
  Loop *isLoopHeader(BasicBlock *BB, LoopInfo &LI);
  void cloneFuncStackAndRegisters(ValueToValueMapTy &vmap, ValSet &);

  LoopInfo &getLoopInfo(Function *);
  AssumptionCache &getAssumptionCache(Function *);

  void addToWorklistBB(BasicBlock *);
  void copyFuncIntoClone(Function *, ValueToValueMapTy &, Function *, vector<ValSet> &);

  LoopUnroller *unrollLoopInClone(Function *, Loop *L, ValueToValueMapTy &, vector<ValSet> &);
  void copyWorklistBB(ValueToValueMapTy &, vector<BBList> &);

  void renameFunctions(Function *, Function *);
  void eraseToReplace(CallInst *, vector<InstPair> &);

  ValSet popFuncValStack();

  void checkPtrMemory(BasicBlock *currBB);
  void markInstMemNonConst(Instruction *);
  void markMemNonConst(Type *, uint64_t, BasicBlock *);

  void collectCallGraphGlobals(CallGraph *);
  void collectModSet(GlobalVariable *, map<Function *, set<GlobalVariable *> > &);
  set<GlobalVariable *> dfs(CallGraphNode *root, map<Function *, set<GlobalVariable *> >&modSet, set<Function *> &openNodes, vector<Function *> &recStack, map<Function *, Cycle * > &cycles);

  Cycle *mergeCycles(set<Cycle *> &);

  set<GlobalVariable *> &getFuncModset(Function *F);
  void markGlobAsNonConst(Function *);

  bool hasTrackedMalloc(Function *);
  void getTrackedValues(set<Value *> &);


  bool exceedsRecursion(Function *called, Function *callee);
  bool exceedClone(string name, int level);
  Value *getLoadSource(LoadInst *LI);
  string removeCloneName(string name);
  bool copyMemory(char *address, Type *ty, char *localAddress);

  bool handleStrStr(CallInst *);
  bool processMallocUsableSize(CallInst *);
  bool handleOverFlowInst(CallInst *callInst);
  ProcResult handleExtractValue(ExtractValueInst *inst);

  bool handleToLower(CallInst *);
};


#endif
