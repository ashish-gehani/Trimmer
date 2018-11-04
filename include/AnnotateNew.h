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

using namespace llvm;
using namespace std;

bool isLoad(Value *);
void getLoadsOnSlps(Value* pointer, set<Value*> &singleLevelLoads);
void getScalarStores(Value *scalar, set<Value*>& stores);

struct AnnotateNew: public ModulePass {

  static char ID;  
  Module *module;
  AnnotateNew(): ModulePass(ID){}
  //void getAnalysisUsage(AnalysisUsage &AU) const;
  bool runOnModule(Module &);
  string print(SVFGNode *node, SVFG *graph);
  PAG *pag;
  SVFGOPT *svfg;
  void getTaintedBranches(set<BranchInst *> &, map<Value *, set<Value *> > &, set<const Value*>&);
  void run(GlobalValue* argv, Value *, set<const Value*> &);
  void getBranchAndArgcInstructions(set<BranchInst*> &branches, set<CallInst*> &calls, set<Instruction*> &argcValues, set<SVFGNode*>&);
  void getMemoryFlow(const SVFGNode *current, set<const Value *> &singleLevelPointers, set<SVFGNode*> &storeSvfg, set<CallInst*> calls);
  void getSourceAllocas(set<SVFGNode*> &, vector<const SVFGNode*> &, set<const Value*> &);
  void getStoreSvfg(set<Value*> &, set<SVFGNode*> &);
  SVFGNode *getSvfgNode(Value *);
  void getAnalysisUsage(AnalysisUsage &AU) const; 
  void classifyValAndOperands(Value *value, set<SVFGNode *> &backwardPtr, set<const Value *> &slps, set<Value*> &scalars); 
  void classifyVal(Value *value, set<SVFGNode*>& backwardPtr, set<const Value *> &singleLevelPointers, set<Value*>& scalar);
  void getLoopIterators(Module &M, set<const Value *> &trackedAllocas, vector<const SVFGNode *>& worklistSvfg);
  void getBranchMemory(set<BranchInst *> &allBranches, map<Value *, set<Value *> > &dp, set<BranchInst*>&);
  void getTrackedBranchBBs(BranchInst *, set<BasicBlock *> &, set<PHINode*> &, map<Function *, PostDominatorTree *> &);
};

#endif
