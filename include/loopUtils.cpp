using namespace llvm;
using namespace std;

#include "InterConstProp.h"
#include "Utils.cpp"

#ifndef LOOP_UTILS_H_
#define LOOP_UTILS_H_

#define DEFAULT_TRIP_COUNT 20

static bool canPeel(Loop *L) {
  // Make sure the loop is in simplified form
  if (!L->isLoopSimplifyForm())
   return false;

  // Only peel loops that contain a single exit
  if (!L->getExitingBlock() || !L->getUniqueExitBlock())
   return false;


  // Don't try to peel loops where the latch is not the exiting block.
  // This can be an indication of two different things:
  // 1) The loop is not rotated.
  // 2) The loop contains irreducible control flow that involves the latch.
  if (L->getLoopLatch() != L->getExitingBlock())
   return false;

  return true;
}

bool ConstantFolding::peel(unsigned tripCount, BasicBlock * header) {
  Function * F = header->getParent();
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
  ScalarEvolution * SE = &getAnalysis<ScalarEvolutionWrapperPass>(*F).getSE();
  DominatorTree * DT = new DominatorTree(*F);
  Loop * L = LI.getLoopFor(dyn_cast<BasicBlock>(header));
  if(!canPeel(L)) {
    debug(Abubakar) << "failed in peeling\n";
    return false;
  }
  bool peeled = peelLoop(L, tripCount, &LI, SE, DT, PreserveLCSSA);
  assert(peeled);
  debug(Abubakar) << "succeeded in peeling\n";
  return true;
}

TestInfo * ConstantFolding::runtest(Loop * L) {

  ValueToValueMapTy vmap;
  Function * toRun = addClonedFunction(currfn, vmap);
  BasicBlock * header = L->getHeader();

  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*toRun).getLoopInfo();
  BasicBlock * hdrClone = dyn_cast<BasicBlock>(vmap[header]);
  Loop * newLoop = LI.getLoopFor(dyn_cast<BasicBlock>(hdrClone));

  TestInfo * ti = new TestInfo(newLoop);
  testStack.push_back(ti);
  BasicBlock * entry = newLoop->getLoopPreheader();
  duplicateContext(entry);

  ValSet oldValSet = funcValStack[funcValStack.size() - 1];
  push_back(funcValStack);

  for(auto val : oldValSet)
    addRegister(vmap[val], Registers[val]);

  if(!peel(DEFAULT_TRIP_COUNT, hdrClone)) {
    pop_back(testStack);
    return ti; // the default value for ti->passed is false
  }
  Function * temp = currfn; 
  currfn = toRun;
  initializeFuncInfo(toRun);

  debug(Abubakar) << "running test\n";
  runOnBB(entry);

  currfn = temp;
  cleanUpfuncBBs(toRun, BasicBlockContexts, Registers, pop_back(funcValStack));
  return pop_back(testStack);
}

bool ConstantFolding::simplifyLoop(BasicBlock * BB) {
  if(testStack.size()) // for now dont run a test from within a test.
    return false;
	if(!bbOps.partOfLoop(BB)) {
  	return false;	
  }
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  Loop * L = LI.getLoopFor(BB);
  if(BB != L->getHeader()) {
  	return false;
  }
  TestInfo * ti = runtest(L);
  if(!ti->passed) {
    debug(Abubakar) << "test failed\n";
    return false;  
  } else {
    debug(Abubakar) << "test passed : peeling loop\n";
    peel(DEFAULT_TRIP_COUNT, BB);
  }
  return true;
}

bool ConstantFolding::testTerminated() {
  if(!testStack.size())
    return false;
  TestInfo * ti = testStack[testStack.size() - 1];
  return ti->terminated;
}

void ConstantFolding::checkTermCond(BasicBlock * BB) {
  if(!testStack.size())
    return;
  TestInfo * ti = testStack[testStack.size() - 1];
  if(ti->terminated)
    return;
  if(ti->exitBB == BB) {
    ti->terminated = true;
    ti->passed = true;
    debug(Abubakar) << "marking test at level " << testStack.size() << " as passed\n";
  } else if(ti->headerBB == BB) {
    ti->terminated = true;
    ti->passed = false;
    debug(Abubakar) << "marking test at level " << testStack.size() << " as failed\n";
  }  
}

#endif