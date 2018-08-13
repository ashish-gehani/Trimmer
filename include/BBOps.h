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
  bool needToduplicate(BasicBlock * BB, BasicBlock * from); 

  void addAncestor(BasicBlock * succ, BasicBlock * anc);
  bool visitBB(BasicBlock * BB, LoopInfo& LI); 
  bool predecessorsVisited(BasicBlock * BB, LoopInfo &LI); 

  bool mergeContext(BasicBlock * BB, BasicBlock * prev);  
  void freePredecessors(BasicBlock * BB); 
  void freeBB(BasicBlock * BB); 
  void propagateUR(BasicBlock * BB, LoopInfo& LI);  
  void checkReadyToVisit(BasicBlock * BB); 
  void markSuccessorsAsUR(TerminatorInst * termInst, LoopInfo& LI);  
  bool foldToSingleSucc(TerminatorInst * termInst, vector<BasicBlock *> & readyToVisit, 
      LoopInfo& LI);
  bool straightPath(BasicBlock * from, BasicBlock * to); 
  Value * foldPhiNode(PHINode * phiNode);
  BasicBlock * getRfromPred(BasicBlock * BB);
  void recomputeLoopInfo(Function * F, LoopInfo& LI);
  /* todo : how to recompute ancestors */
  void copyFuncBlocksInfo(Function * F, ValueToValueMapTy & vmap);

  void createNewContext(BasicBlock * BB, Module *);
  void duplicateContext(BasicBlock * to, BasicBlock *);
  void imageContext(BasicBlock * to, BasicBlock *);
  Memory * duplicateMem(BasicBlock *);
  bool hasContext(BasicBlock * BB);
  void copyContext(Memory * mem, BasicBlock *);
  uint64_t allocateStack(uint64_t size, BasicBlock *);
  uint64_t allocateHeap(uint64_t size, BasicBlock *);
  uint64_t loadMem(uint64_t addr, uint64_t size, BasicBlock *);
  void storeToMem(uint64_t val, uint64_t size, uint64_t addr, BasicBlock *);
  void setConstMem(bool val, uint64_t addr, uint64_t size, BasicBlock *);
  void setConstContigous(bool val, uint64_t addr, BasicBlock *);
  uint64_t getRemainingContigousSize(uint64_t addr, BasicBlock *);
  void * getActualAddr(uint64_t addr, BasicBlock *);
  bool checkConstMem(uint64_t addr, uint64_t size, BasicBlock *);
  bool checkConstContigous(uint64_t addr, BasicBlock *);
  bool checkConstStr(uint64_t addr, BasicBlock *);
  bool checkConstStr(uint64_t addr, uint64_t max, BasicBlock *);

  ContextInfo *getContextInfo(BasicBlock *bb);
  void cleanUpFuncBBInfo(Function *f);

  void copyContexts(Function *to, Function *from, ValueToValueMapTy& vmap, Module *);
  bool isContextDeleted(BasicBlock *);
private:
  map<BasicBlock *, BBInfo *> BBInfoMap;
  BasicBlockContInfoMap BasicBlockContexts;
  set<BasicBlock *> visited;
  set<BasicBlock *> unReachable;
  vector<BasicBlock *> readyToVisit;
};
#endif
