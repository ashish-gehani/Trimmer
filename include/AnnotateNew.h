/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This is the main header file for the Annotation Pass. It defines a class AnnotateNew, which is inherited from LLVM Module Pass. All the methods 
of the class are defined in src/AnnotateNew.cpp.*/

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"

#ifndef ANNOTATE_NEW
#define ANNOTATE_NEW

#include "MSSA/SVFGOPT.h"
#include "MSSA/SVFG.h"

#include <map>
#include <unordered_map>

using namespace llvm;
using namespace std;

Function *createFunction(Type *returnType, vector<Type*> &args, bool isVarArg, const string &name, Module *M);
struct AnnotateNew: public ModulePass {

  static char ID;  
  int LOOP_ID;
  Module *module;
  AnnotateNew(): ModulePass(ID){}
  //void getAnalysisUsage(AnalysisUsage &AU) const;
  bool runOnModule(Module &);
  string print(SVFGNode *node, SVFG *graph);
  PAG *pag;
  SVFGOPT *svfg; 
  map<Value*, set<Value*> *> isLoadOrArgcDp;
  map<Value*, set<Value*> *> isLoadDp;
  map<SVFGNode*, set<SVFGNode*> *> backwardDp;

  set<const BasicBlock *> markedLoops;
  unordered_map<const BasicBlock *, const BasicBlock *> loopHeaders;


  void setDepthFunctions(int depth, set<const Function *>& depthCG, const Function* F);

  void getTaintedBranches(set<BranchInst *> &, map<Value *, set<Value *> > &, set<const Value*>&);
  void run(vector<Value*>, Value *, set<const Value*> &);
  void getBranchAndArgcInstructions(set<BranchInst*> &branches, set<CallInst*> &calls, set<Instruction*> &argcValues);
  void getMemoryFlow(const SVFGNode *current, set<const Value *> &singleLevelPointers, set<SVFGNode*> &storeSvfg, set<CallInst*> &calls);
  void getSourceAllocas(set<SVFGNode*> &, vector<const SVFGNode*> &, set<const Value*> &, bool trackLoops = true, bool dpMem = true);
  void getStoreSvfg(set<Value*> &, set<SVFGNode*> &);
  //SVFGNode *getSvfgNode(Value *);
  SVFGNode *getSvfgNode(const Value *);

  void getAnalysisUsage(AnalysisUsage &AU) const; 
  void classifyValAndOperands(Value *value, set<SVFGNode *> &backwardPtr, set<const Value *> &slps, set<Value*> &scalars); 
  void classifyVal(Value *value, set<SVFGNode*>& backwardPtr, set<const Value *> &singleLevelPointers, set<Value*>& scalar);
  //void getLoopIterators(Module &M, set<const Value *> &trackedAllocas, vector<const SVFGNode *>& worklistSvfg);
  void getLoopIterators(const BasicBlock *, set<const Value *> &trackedAllocas);
  void getLoopBbs(Module *);
  void getBranchMemory(set<BranchInst *> &allBranches, map<Value *, set<Value *> > &dp, set<BranchInst*>&);
  void getTrackedBranchBBs(BranchInst *, set<BasicBlock *> &, set<PHINode*> &, map<Function *, PostDominatorTree *> &);

  static bool isLoad(Value *);
  static vector<Value*> genericScalarDfsBackward(Value *current);
  static vector<Value*> genericScalarDfs(Value *current);
  static vector<SVFGNode*> forwardDfsLambda(SVFGNode *current);
  static vector<SVFGNode*> forwardDfsLambdaLimited(SVFGNode *current);


  static vector<SVFGNode*> forwardLimitedDfsLambda(SVFGNode *current, int depth);


  void getLoadsOnSlps(Value* pointer, set<Value*> &singleLevelLoads);
  void getSlpStores(set<const Value *>& singleLevelPointers, set<Value*>& stores);
  void getSlpScalarStores(set<const Value*> slps, set<Value *>& scalars, set<Value *> stores);
  void getScalarStores(Value *scalar, set<Value*>& stores);

  set<Value*> *dfs_rec(Value* root, std::function<vector<Value*> (Value*)> nextNodes, std::function<bool (Value *)> condition, set<Value *> &visited, map<Value *, set<Value *>* > *dpData = NULL, bool trackLoops = true);

  
  set<SVFGNode*> *dfs_rec(SVFGNode* root, std::function<vector<SVFGNode*> (SVFGNode*)> nextNodes, std::function<bool (SVFGNode*)> condition, set<SVFGNode*> &visited, map<SVFGNode*, set<SVFGNode*>* > *dpData = NULL, bool trackLoops = true);
  set<SVFGNode*> *dfs_rec_limit(SVFGNode* root, std::function<vector<SVFGNode*> (SVFGNode*, int)> nextNodes, std::function<bool (SVFGNode*)> condition, set<SVFGNode*> &visited,int depth, map<SVFGNode*, set<SVFGNode*>* > *dpData = NULL, bool trackLoops = true);


  void dfs(SVFGNode* root, std::function<vector<SVFGNode*> (SVFGNode*)> nextNodes, std::function<bool (SVFGNode*)> condition, set<SVFGNode*> &output);
  void dfs(Value* root, std::function<vector<Value*> (Value*)> nextNodes, std::function<bool (Value*)> condition, set<Value*> &output);


  void checkIfLoop(SVFGNode *node);
  void checkIfLoop(Value *node);

  const BasicBlock *partOfLoop(const BasicBlock *BB);
  Function *insertLoopFuncAnnot(Module *M, const string &name);
  void annotateLoop(const BasicBlock *, Function *F, unsigned);

  void trackStats(Value *);
  void trackStats(SVFGNode *);
};

#endif

