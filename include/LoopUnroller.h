#include "ConstantFolding.h"
#include "LoopUnrollTest.h"

#ifndef LOOPUNROLLER_H_
#define LOOPUNROLLER_H_

class LoopUnroller {
  public:
  LoopUnroller(Module *m, bool PreserveLCSSA, bool useAnnotations);
  static void checkTermInst(Instruction * I, LoopUnrollTest *ti);
  static bool testTerminated(LoopUnrollTest *ti);
  bool checkUnrollHint(BasicBlock * hdr, LoopInfo &LI);
  bool shouldSimplifyLoop(BasicBlock *BB, LoopInfo &LI);
  bool getTripCount(BasicBlock * header, TargetLibraryInfo * TLI, LoopInfo &, AssumptionCache &, unsigned &);
  LoopUnrollTest *runtest(BasicBlock *hdrClone, TargetLibraryInfo * TLI, LoopInfo &, AssumptionCache &);
  LoopUnrollTest *createLoopUnrollTest(BasicBlock *hdrClone);
  bool doUnroll(BasicBlock * header, TargetLibraryInfo * TLI, LoopInfo &, AssumptionCache &, unsigned);
  BasicBlock *getLoopPreHeader(BasicBlock *hdrClone, LoopInfo &LI);

  LoopUnrollTest *createTest(BasicBlock *hdrClone);

  private:
  bool PreserveLCSSA;
  Module *module;
  bool useAnnotations;
};

#endif
