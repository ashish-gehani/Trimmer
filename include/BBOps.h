#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Pass.h"
#include "llvm/Analysis/LoopInfo.h"

#include <set>

#include "LoopUnrollTest.h"
#include "VecUtils.h"
#include "ConstantFolding.h"
#include "ContextInfo.h"
#include "BBInfo.h"

#ifndef BBOPS_H_
#define BBOPS_H_

typedef map<BasicBlock *, ContextInfo *> BasicBlockContInfoMap;

using namespace std;
using namespace llvm;

class BBOps {
public:
	BBOps() {}
  BBInfo* initializeBBInfo(BasicBlock * BB, LoopInfo& LI);
  void addBBInfo(BasicBlock * BB, BBInfo* bbi);
  bool isBBInfoInitialized(BasicBlock *BB);
  void initAndAddBBInfo(BasicBlock * BB, LoopInfo &LI);

  bool partOfLoop(Value * val);
  bool partOfLoop(BasicBlock * BB); 
  bool writesToMemory(BasicBlock * BB); 
  void markVisited(BasicBlock * BB); 
  bool isVisited(BasicBlock * BB); 
  bool isUnReachable(BasicBlock * BB); 

  // returns true if there is a single child and it is equal to succ
  bool isSingleSucc(BasicBlock * pred, BasicBlock * succ); 
  // returns true if there is a single child and it is not equal to succ
  bool isnotSingleSucc(BasicBlock * pred, BasicBlock * succ); 
  bool needToduplicate(BasicBlock * BB, BasicBlock * from, BasicBlockContInfoMap bbc); 

  void addAncestor(BasicBlock * succ, BasicBlock * anc);
  bool visitBB(BasicBlock * BB, LoopInfo& LI); 
  bool predecessorsVisited(BasicBlock * BB, LoopInfo &LI); 

  bool mergeContext(BasicBlock * BB, BasicBlock * prev, BasicBlockContInfoMap bbc);  
  void freePredecessors(BasicBlock * BB, BasicBlockContInfoMap bbc); 
  void freeBB(BasicBlock * BB, BasicBlockContInfoMap bbc); 
  void propagateUR(BasicBlock * BB, LoopInfo& LI);  
  void checkReadyToVisit(BasicBlock * BB); 
  void markSuccessorsAsUR(TerminatorInst * termInst, LoopInfo& LI);  
  bool foldToSingleSucc(TerminatorInst * termInst, vector<BasicBlock *> & readyToVisit, 
      LoopInfo& LI);
  bool straightPath(BasicBlock * from, BasicBlock * to, BasicBlockContInfoMap bbc); 
  Value * foldPhiNode(PHINode * phiNode, BasicBlockContInfoMap bbc);
  BasicBlock * getRfromPred(BasicBlock * BB);
  void recomputeLoopInfo(Function * F, LoopInfo& LI);
  /* todo : how to recompute ancestors */
  void copyFuncBlocksInfo(Function * F, ValueToValueMapTy & vmap);
private:
  map<BasicBlock *, BBInfo *> BBInfoMap;
  set<BasicBlock *> visited;
  set<BasicBlock *> unReachable;
  vector<BasicBlock *> readyToVisit;
};
#endif
