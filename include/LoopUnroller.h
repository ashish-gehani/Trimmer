#include "ConstantFolding.h"
#include "LoopUnrollTest.h"

#ifndef LOOPUNROLLER_H_
#define LOOPUNROLLER_H_

class LoopUnroller {
  public:
  LoopUnroller(Module *m, bool PreserveLCSSA, bool useAnnotations, Loop *, LoopInfo *);
  ~LoopUnroller();
  void checkTermInst(Instruction * I);
  bool testTerminated();
  bool doUnroll(TargetLibraryInfo * TLI, AssumptionCache &, unsigned);
  static bool checkUnrollHint(BasicBlock * hdr, LoopInfo &LI, Module *);
  static bool shouldSimplifyLoop(BasicBlock *BB, LoopInfo &LI, Module *, bool);
  bool getTripCount(TargetLibraryInfo * TLI, AssumptionCache &, unsigned &);
  bool runtest(TargetLibraryInfo * TLI, AssumptionCache &);
  LoopInfo *getLoopInfo();

  bool checkPassed();
  void setCloneOf(Function *);
  Function *getCloneOf();

  Loop *loop;
  private:
  LoopUnrollTest *ti;
  bool PreserveLCSSA;
  Module *module;
  bool useAnnotations;
  LoopInfo *LI;
  Function *cloneOf;
};

#endif
