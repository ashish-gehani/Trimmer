using namespace llvm;
using namespace std;

#include "InterConstProp.h"
#include "Utils.cpp"

#ifndef LOOP_UTILS_H_
#define LOOP_UTILS_H_

bool ConstantFolding::checkUnrollHint(BasicBlock * hdr, LoopInfo &LI) {
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

bool ConstantFolding::getTripCount(BasicBlock * header, unsigned & tripCount) {
  Function * F = header->getParent();
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
  DominatorTree * DT = new DominatorTree(*F);
  AssumptionCache &AC = getAnalysis<AssumptionCacheTracker>(*F).getAssumptionCache(*F);
  ScalarEvolution SE(*F, *TLI, AC, *DT, LI);
  Loop * L = LI.getLoopFor(dyn_cast<BasicBlock>(header));
  tripCount =  SE.getSmallConstantMaxTripCount(L);
  if(!tripCount) {
    tripCount = DEFAULT_TRIP_COUNT + 5;
    return false;
  }
  return true;
}

bool ConstantFolding::doUnroll(BasicBlock * header, unsigned tripCount) {
  Function * F = header->getParent();
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
  DominatorTree * DT = new DominatorTree(*F);
  AssumptionCache &AC = getAnalysis<AssumptionCacheTracker>(*F).getAssumptionCache(*F);
  ScalarEvolution SE(*F, *TLI, AC, *DT, LI);
  Loop * L = LI.getLoopFor(dyn_cast<BasicBlock>(header));
  OptimizationRemarkEmitter ORE(F); 
  int UnrollResult = UnrollLoop(L, tripCount, tripCount, true, false, false, 
                true, false, 0, 0, &LI, &SE, DT, &AC, &ORE, PreserveLCSSA);
  if(!UnrollResult) {
    debug(Abubakar) << "failed in unrolling\n";
    return false;
  }
  debug(Abubakar) << "succeeded in unrolling for " << tripCount << " iterations\n";
  return true;
}

TestInfo * ConstantFolding::runtest(Loop * L) {
  ValueToValueMapTy vmap;
  Function * toRun = addClonedFunction(currfn, vmap);
  bbOps.copyFuncBlocksInfo(currfn, vmap);
  BasicBlock * hdrClone = dyn_cast<BasicBlock>(vmap[L->getHeader()]); 
  unsigned tripCount;
  bool constTripCount = getTripCount(hdrClone, tripCount);
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*toRun).getLoopInfo();
  Loop * newLoop = LI.getLoopFor(dyn_cast<BasicBlock>(hdrClone));
  TestInfo * ti = new TestInfo(newLoop, module, constTripCount);
  testStack.push_back(ti);
  BasicBlock * entry = newLoop->getLoopPreheader();

  ValSet oldValSet = funcValStack[funcValStack.size() - 1];
  push_back(funcValStack);
  for(auto val : oldValSet) 
    addRegister(vmap[val], Registers[val]);
  if(!doUnroll(hdrClone, tripCount)) {
    pop_back(testStack);
    cleanUpfuncBBs(toRun, BasicBlockContexts, Registers, pop_back(funcValStack));
    return ti; // the default value for ti->passed is false
  }
  duplicateContext(entry);
  Function * temp = currfn; 
  currfn = toRun;
  LoopInfo &newLI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  bbOps.recomputeLoopInfo(currfn, newLI);

  if(!isFuncInfoInitialized(toRun)) {
    FuncInfo *fi = initializeFuncInfo(toRun);
    addFuncInfo(toRun, fi);
  }
  runOnBB(entry);

  currfn = temp;
  cleanUpfuncBBs(toRun, BasicBlockContexts, Registers, pop_back(funcValStack));
  return pop_back(testStack);
}

void ConstantFolding::simplifyLoop(BasicBlock * BB) {
  if(testStack.size()) // for now dont run a test from within a test.
    return;
  if(!bbOps.partOfLoop(BB)) {
    return; 
  }
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  Loop * L = LI.getLoopFor(BB);
  if(BB != L->getHeader())
    return;
  if(useAnnotations && !checkUnrollHint(BB, LI))
    return;
  debug(Abubakar) << "running test\n";
  TestInfo * ti = runtest(L);
  if(!ti->checkPassed()) {
    debug(Abubakar) << "test failed\n";
    return;  
  }
  debug(Abubakar) << "loop broken in " << ti->iterations << " iterations\n";
  debug(Abubakar) << "test passed : modifying loop\n";
  doUnroll(BB, ti->iterations + 1);
  LoopInfo &newLI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  /*TODO : what other information may change as a result of unrolling/peeling?*/
  bbOps.recomputeLoopInfo(currfn, newLI);
}

bool ConstantFolding::testTerminated() {
  if(!testStack.size())
    return false;
  TestInfo * ti = testStack[testStack.size() - 1];
  return ti->terminated;
}

void ConstantFolding::checkTermInst(Instruction * I) {
  if(!testStack.size())
    return;
  TestInfo * ti = testStack[testStack.size() - 1];
  if(ti->terminated)
    return;
  if(ti->checkBreakInst(I)) {
    ti->terminated = true;
    debug(Abubakar) << "marking test at level " << testStack.size() << " as terminated\n";
  } else ti->updateIter(I); 
}

void ConstantFolding::updateCM(ProcResult result, Instruction * I) {
  if(!I->getParent()) // constant expressions etc
    return;
  if(!testStack.size())
    return;
  TestInfo * ti = testStack[testStack.size() - 1];
  if(ti->terminated)
    return;
  if(findInMap(ti->InstResults, I))
    return;
  if(bbOps.partOfLoop(I->getParent())) {
    ti->InstResults[I] = PARTOFLOOP;
    ti->partOfLoop++;
    return;
  }
  ti->InstResults[I] = result;
  bool found = false;
  for(unsigned i = 0; i < I->getNumOperands(); i++) {
    Value * val = I->getOperand(i);
    if(!isa<Instruction>(val))
      continue;
    if(findInMap(ti->InstResults, dyn_cast<Instruction>(val))) {
      found = true;
      break;
    }
  }
  if(!found)
    ti->indepInsts.push_back(I);
}

unsigned ConstantFolding::getNumNodesBelow(Instruction * I, 
  map<Instruction *, unsigned> & cache, TestInfo * ti) {
  if(findInMap(cache, I))
    return cache[I];
  // getNumNodesBelow called on a use outside the loop
  if(!findInMap(ti->InstResults, I))
    return 1;
  ProcResult result = ti->InstResults[I];
  if(result == FOLDED || result == PARTOFLOOP)
    return 0;
  unsigned num = 0;
  for(Use &U : I->uses()) {
    Instruction * user = dyn_cast<Instruction>(U.getUser());
    assert(user);
    if(!bbOps.isVisited(user->getParent()))
      continue;
    num += getNumNodesBelow(user, cache, ti);      
  }      
  num = num > 0 ? num + 1 : result; // 0 if undecided, 1 if not folded
  cache[I] = num;
  return num;
}

unsigned ConstantFolding::getCost(TestInfo * ti) {
  unsigned cost = 0;
  map<Instruction *, unsigned> cache;
  for(unsigned i = 0; i < ti->indepInsts.size(); i++) {
    unsigned num = 0;
    Instruction * I = ti->indepInsts[i];
    num = getNumNodesBelow(I, cache, ti);
    cost += num;   
  }
  return cost + ti->partOfLoop;
}

#endif
