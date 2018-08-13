#include "LoopUnroller.h"

LoopUnroller::LoopUnroller(Module *m, bool preserveLcssa, bool useAnnot, Loop *L, LoopInfo *li) {
  module = m;
  PreserveLCSSA = preserveLcssa;
  useAnnotations = useAnnot;
  loop = L;
  ti = NULL;
  cloneOf = NULL;
  LI = li;
}

LoopUnroller::~LoopUnroller() {
  if(ti)
    delete ti;
}

void LoopUnroller::checkTermInst(Instruction * I) {
  assert(ti && "no loop unroll test");
  if(ti->terminated)
    return;
  if(ti->checkBreakInst(I)) {
    ti->terminated = true;
    //debug(Abubakar) << "marking test at level " << testStack.size() << " as terminated\n";
  } else ti->updateIter(I); 
}

bool LoopUnroller::testTerminated() {
  assert(ti && "no loop unroll test");
  return ti->terminated;
}

bool LoopUnroller::checkUnrollHint(BasicBlock * hdr, LoopInfo &LI, Module *module) {
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

bool LoopUnroller::shouldSimplifyLoop(BasicBlock *BB, LoopInfo &LI, Module *m, bool useAnnotations) {
  if(useAnnotations && !checkUnrollHint(BB, LI, m))
    return false;
  return true;
}

bool LoopUnroller::getTripCount(TargetLibraryInfo * TLI, AssumptionCache &AC, unsigned &tripCount) {
  BasicBlock *header = loop->getHeader();
  Function * F = loop->getHeader()->getParent();
  DominatorTree * DT = new DominatorTree(*F);
  ScalarEvolution SE(*F, *TLI, AC, *DT, *LI);
  tripCount =  SE.getSmallConstantMaxTripCount(loop);

  if(!tripCount) {
    tripCount = DEFAULT_TRIP_COUNT + 5;
    return false;
  }
  return true;
}

void LoopUnroller::runtest(TargetLibraryInfo * TLI, AssumptionCache &AC) {
  unsigned tripCount;
  bool constTripCount = getTripCount(TLI, AC, tripCount);
  ti = new LoopUnrollTest(loop, module, constTripCount);
  if(!doUnroll(TLI, AC, tripCount)) {
    delete ti;
    ti = NULL;
  }
}


bool LoopUnroller::doUnroll(TargetLibraryInfo * TLI, AssumptionCache &AC, unsigned tripCount) {
  Function * F = loop->getHeader()->getParent();
  DominatorTree * DT = new DominatorTree(*F);

  ScalarEvolution SE(*F, *TLI, AC, *DT, *LI);
  Loop * L = LI->getLoopFor(loop->getHeader());
  OptimizationRemarkEmitter ORE(F); 
  int UnrollResult = UnrollLoop(L, tripCount, tripCount, true, false, false, 
                true, false, 1, 0, LI, &SE, DT, &AC, &ORE, PreserveLCSSA);
  if(!UnrollResult) {
    debug(Abubakar) << "failed in unrolling\n";
    return false;
  }
  debug(Abubakar) << "succeeded in unrolling for " << tripCount << " iterations\n";
  return true;
}

bool LoopUnroller::checkPassed() {
  assert(ti && "no loop unroll test");
  return ti->checkPassed();
}

void LoopUnroller::setCloneOf(Function *F) {
  cloneOf = F;
}

Function *LoopUnroller::getCloneOf() {
  return cloneOf;
}

LoopInfo *LoopUnroller::getLoopInfo() {
  return LI;
}
