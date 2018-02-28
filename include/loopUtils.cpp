using namespace llvm;
using namespace std;

#include "InterConstProp.h"
#include "Utils.cpp"


#ifndef LOOP_UTILS_H_
#define LOOP_UTILS_H_

#define DEFAULT_TRIP_COUNT 20

static bool canPeel(Loop *L) {
  // Make sure the loop is in simplified form
  if(!L->isLoopSimplifyForm())
    debug(Abubakar) << "not L->isLoopSimplifyForm\n";
  if(!L->getExitingBlock())
    debug(Abubakar) << "not L->getExitingBlock\n";
  if(!L->getUniqueExitBlock())
    debug(Abubakar) << "not L->getUniqueExitBlock\n";
  if(L->getLoopLatch() != L->getExitingBlock())
    debug(Abubakar) << "LoopLatch is not the exiting block\n";    

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

LoopOp ConstantFolding::getOp(BasicBlock * header, unsigned & tripCount) {
  Function * F = header->getParent();
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
  DominatorTree * DT = new DominatorTree(*F);
  AssumptionCache &AC = getAnalysis<AssumptionCacheTracker>(*F).getAssumptionCache(*F);
  ScalarEvolution SE(*F, *TLI, AC, *DT, LI);
  Loop * L = LI.getLoopFor(dyn_cast<BasicBlock>(header));
  tripCount =  SE.getSmallConstantTripCount(L);
  if(!tripCount) {
    tripCount = DEFAULT_TRIP_COUNT;
    return PEELOP;
  }
  return UNROLLOP;
}

bool ConstantFolding::runOp(BasicBlock * header, LoopOp op, 
                      unsigned tripCount) {
  if(!op)
    return false;
  Function * F = header->getParent();
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo();
  DominatorTree * DT = new DominatorTree(*F);
  AssumptionCache &AC = getAnalysis<AssumptionCacheTracker>(*F).getAssumptionCache(*F);
  ScalarEvolution SE(*F, *TLI, AC, *DT, LI);
  Loop * L = LI.getLoopFor(dyn_cast<BasicBlock>(header));
  if(op == PEELOP) {
    if(!canPeel(L)) {
      debug(Abubakar) << "failed in peeling\n";
      return false;
    }
    bool peeled = peelLoop(L, tripCount, &LI, &SE, DT, PreserveLCSSA);
    assert(peeled);
    debug(Abubakar) << "succeeded in peeling for " << tripCount << " iterations\n";
  } else {
    OptimizationRemarkEmitter ORE(F); 
    int UnrollResult = UnrollLoop(L, tripCount, tripCount, true, false, false, 
                  false, false, 0, 0, &LI, &SE, DT, &AC, &ORE, PreserveLCSSA);
    if(!UnrollResult) {
      debug(Abubakar) << "failed in unrolling\n";
      return false;
    }
    debug(Abubakar) << "succeeded in unrolling for " << tripCount << " iterations\n";
  }
  return true;
}

TestInfo * ConstantFolding::runtest(Loop * L, LoopOp & op, unsigned & tripCount) {

  ValueToValueMapTy vmap;
  Function * toRun = addClonedFunction(currfn, vmap);
  BasicBlock * header = L->getHeader();
  BasicBlock * hdrClone = dyn_cast<BasicBlock>(vmap[header]); 
  op = getOp(hdrClone, tripCount);

  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*toRun).getLoopInfo();
  Loop * newLoop = LI.getLoopFor(dyn_cast<BasicBlock>(hdrClone));

  TestInfo * ti = new TestInfo(newLoop, op);
  testStack.push_back(ti);
  BasicBlock * entry = newLoop->getLoopPreheader();
  duplicateContext(entry);

  ValSet oldValSet = funcValStack[funcValStack.size() - 1];
  push_back(funcValStack);

  for(auto val : oldValSet)
    addRegister(vmap[val], Registers[val]);

  if(!runOp(hdrClone, op, tripCount)) {
    pop_back(testStack);
    cleanUpfuncBBs(toRun, BasicBlockContexts, Registers, pop_back(funcValStack));
    return ti; // the default value for ti->passed is false
  }
  Function * temp = currfn; 
  currfn = toRun;
  initializeFuncInfo(toRun);
  runOnBB(entry);

  currfn = temp;
  cleanUpfuncBBs(toRun, BasicBlockContexts, Registers, pop_back(funcValStack));
  return pop_back(testStack);
}

LoopOp ConstantFolding::simplifyLoop(BasicBlock * BB) {
  if(testStack.size()) // for now dont run a test from within a test.
    return NOOP;
	if(!bbOps.partOfLoop(BB)) {
  	return NOOP;	
  }
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  Loop * L = LI.getLoopFor(BB);
  if(BB != L->getHeader())
  	return NOOP;
  debug(Abubakar) << "running test\n";
  LoopOp op;
  unsigned tripCount;
  TestInfo * ti = runtest(L, op, tripCount);
  if(!ti->passed) {
    debug(Abubakar) << "test failed\n";
    return NOOP;  
  }
  debug(Abubakar) << "test passed : modifying loop\n";
  runOp(BB, op, tripCount);
  LoopInfo &newLI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  bbOps.recomputeInfo(currfn, newLI);

  return op;
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
  if(ti->termBB == BB) {
    ti->terminated = true;
    ti->passed = true;
    debug(Abubakar) << "marking test at level " << testStack.size() << " as passed\n";
  } else if(ti->headerBB == BB) {
    ti->terminated = true;
    ti->passed = false;
    debug(Abubakar) << "marking test at level " << testStack.size() << " as failed\n";
  }  
}

void ConstantFolding::updateCM(ProcResult result, Instruction * I) {
  if(!I->getParent()) // constant expressions etc
    return;
  if(!testStack.size())
    return;
  TestInfo * ti = testStack[testStack.size() - 1];
  if(ti->terminated)
    return;
  if(ti->InstResults.find(I) != ti->InstResults.end())
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
    if(ti->InstResults.find(dyn_cast<Instruction>(val)) != 
      ti->InstResults.end()) {
      found = true;
      break;
    }
  }
  if(!found)
    ti->indepInsts.push_back(I);
}

unsigned ConstantFolding::getNumNodesBelow(Instruction * I, 
  map<Instruction *, unsigned> & cache, TestInfo * ti) {

  if(cache.find(I) != cache.end())
    return cache[I];

  // getNumNodesBelow called on a use outside the loop
  if(ti->InstResults.find(I) == ti->InstResults.end())
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