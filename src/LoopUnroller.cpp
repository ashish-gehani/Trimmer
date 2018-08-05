#include "LoopUnroller.h"

LoopUnroller::LoopUnroller(Module *m, bool preserveLcssa, bool useAnnot) {
  module = m;
  PreserveLCSSA = preserveLcssa;
  useAnnotations = useAnnot;
}

void LoopUnroller::checkTermInst(Instruction * I, LoopUnrollTest *ti) {
  if(ti->terminated)
    return;
  if(ti->checkBreakInst(I)) {
    ti->terminated = true;
    //debug(Abubakar) << "marking test at level " << testStack.size() << " as terminated\n";
  } else ti->updateIter(I); 
}

bool LoopUnroller::testTerminated(LoopUnrollTest *ti) {
  return ti->terminated;
}

bool LoopUnroller::checkUnrollHint(BasicBlock * hdr, LoopInfo &LI) {
  Value * unrollH = module->getNamedValue("unroll_loop");
  if(!unrollH) return false;
  for(Use &U : unrollH->uses()) {
    Instruction * user = dyn_cast<Instruction>(U.getUser());
    if(!user) continue;
    BasicBlock * BB = user->getParent();
    Loop * L = LI.getLoopFor(BB);
    if(L && L->getHeader() == hdr) return true;
  }
  return false;
}

bool LoopUnroller::shouldSimplifyLoop(BasicBlock *BB, LoopInfo &LI) {
  if(useAnnotations && !checkUnrollHint(BB, LI))
    return false;
  return true;
}

bool LoopUnroller::getTripCount(BasicBlock * header, TargetLibraryInfo * TLI, LoopInfo &LI, AssumptionCache &AC, unsigned &tripCount) {
  Function * F = header->getParent();
  DominatorTree * DT = new DominatorTree(*F);
  ScalarEvolution SE(*F, *TLI, AC, *DT, LI);
  Loop * L = LI.getLoopFor(dyn_cast<BasicBlock>(header));
  tripCount =  SE.getSmallConstantMaxTripCount(L);
  if(!tripCount) {
    tripCount = DEFAULT_TRIP_COUNT + 5;
    return false;
  }
  return true;
}

LoopUnrollTest *LoopUnroller::runtest(BasicBlock *hdrClone, TargetLibraryInfo * TLI, LoopInfo &LI, AssumptionCache &AC) {
  unsigned tripCount;
  bool constTripCount = getTripCount(hdrClone, TLI, LI, AC, tripCount);
  Loop *newLoop = LI.getLoopFor(dyn_cast<BasicBlock>(hdrClone));
  LoopUnrollTest *ti = new LoopUnrollTest(newLoop, module, constTripCount);
  if(!doUnroll(hdrClone, TLI, LI, AC, tripCount)) {
    return NULL;
  }

  return ti;
}


bool LoopUnroller::doUnroll(BasicBlock * header, TargetLibraryInfo * TLI, LoopInfo &LI, AssumptionCache &AC, unsigned tripCount) {
  Function * F = header->getParent();
  DominatorTree * DT = new DominatorTree(*F);

  ScalarEvolution SE(*F, *TLI, AC, *DT, LI);
  Loop * L = LI.getLoopFor(dyn_cast<BasicBlock>(header));
  OptimizationRemarkEmitter ORE(F); 
  int UnrollResult = UnrollLoop(L, tripCount, tripCount, true, false, false, 
                true, false, 1, 0, &LI, &SE, DT, &AC, &ORE, PreserveLCSSA);
  if(!UnrollResult) {
    debug(Abubakar) << "failed in unrolling\n";
    return false;
  }
  debug(Abubakar) << "succeeded in unrolling for " << tripCount << " iterations\n";
  return true;
}

BasicBlock *LoopUnroller::getLoopPreHeader(BasicBlock *hdrClone, LoopInfo &LI) {
  return LI.getLoopFor(dyn_cast<BasicBlock>(hdrClone))->getLoopPreheader();
}
