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

using namespace llvm;
using namespace std;

bool isLoad(Value *);

struct AnnotateNew: public ModulePass {

  static char ID;  
  Module *module;
  AnnotateNew(): ModulePass(ID){}
  //void getAnalysisUsage(AnalysisUsage &AU) const;
  bool runOnModule(Module &);
  string print(SVFGNode *node, SVFG *graph);
  PAG *pag;
  SVFGOPT *svfg;
  void getTaintedBranches(set<BranchInst*>& trackedBranches, set<BranchInst*> &, Value *argv, set<const Value*>& trackedAllocas);
  void run(GlobalValue* argv, Value *, set<const Value*> &);

  void getBranchAndArgcInstructions(set<BranchInst*> &branches, set<CallInst*> &calls, set<Instruction*> &argcValues, set<SVFGNode*>&);
  void getMemoryFlow(const SVFGNode *current, set<const Value *> &singleLevelPointers, set<SVFGNode*> &storeSvfg, set<CallInst*> calls);
  void getSourceAllocas(set<SVFGNode*> &, vector<const SVFGNode*> &, set<const Value*> &);
  void getStoreSvfg(set<Value*> &, set<SVFGNode*> &);
  SVFGNode *getSvfgNode(Value *);
  void getAnalysisUsage(AnalysisUsage &AU) const; 
};

#endif
