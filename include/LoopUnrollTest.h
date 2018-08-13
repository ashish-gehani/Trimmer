using namespace std;
using namespace llvm;

#ifndef TYPES_H_
#define TYPES_H_

#include "llvm/Analysis/LoopInfo.h"

#include "Debug.h"
#include "Mem.h"

#define LOOPEXITBB "__loop_termination_test__"
#define LOOPITERBB "__loop_iteration_test__"
#define PRNTDBGSTR "__print_debug_string__"
#define SETDBGLEVEL "__set_debug_level__"

#define DEFAULT_TRIP_COUNT 20

/*
 * This enumeration is used to keep track of the results of constant propagation 
 * on instruction.
 * e.g. i32 %a = load i32* %b
 * if we replace %a with the loaded value the above instruction will be marked as
 * folded
 */

enum ProcResult {
  UNDECIDED,
  NOTFOLDED,
  PARTOFLOOP,
  FOLDED
};

CallInst * getTestInst(string, Module *);
/*
  structure used for loop unroll testing
*/
struct LoopUnrollTest {
  bool terminated, ConstTripCount;              
  vector<Instruction *> indepInsts;
  map<Instruction *, ProcResult> InstResults; 
  unsigned numOrigInsts, partOfLoop, iterations;
  vector<Instruction *> instrumented;
  LoopUnrollTest(Loop * L, Module * module, bool tripCount) {
    terminated = false;
    ConstTripCount = tripCount;
    CallInst * testCall = getTestInst(LOOPEXITBB, module);
    CallInst * iterCall = getTestInst(LOOPITERBB, module);  
    SmallVector<BasicBlock*, 16> ExitBlocks;
    L->getUniqueExitBlocks(ExitBlocks);
    for(unsigned i = 0; i < ExitBlocks.size(); i++) {
      BasicBlock * BB = ExitBlocks[i];
      Instruction *I = testCall->clone();
      I->insertBefore(firstInst(BB));
      instrumented.push_back(I);
    }
    testCall->dropAllReferences();
    BasicBlock * latchBB = L->getLoopLatch();
    iterCall->insertBefore(firstInst(latchBB));
    numOrigInsts = partOfLoop = iterations = 0;
    for(auto block : L->blocks()) {
      BasicBlock * BB = &*block;
      numOrigInsts += distance(BB->begin(), BB->end());
    }
  } 
  Instruction * firstInst(BasicBlock * BB) {
    BasicBlock::iterator it;
    for(it = BB->begin(); it != BB->end(); it++) {
      if(!isa<PHINode>(&*it))
        break;
    }
    return &*it;    
  }
  bool checkTestInst(Instruction * I, string testName) {
    if(CallInst * ci = dyn_cast<CallInst>(I)) {
      if(ci->getCalledFunction()->getName().str() == testName)
        return true;
    }
    return false;
  }
  bool containsTestInst(BasicBlock * BB, string testName) {
    for(BasicBlock::iterator it = BB->begin(); it != BB->end(); it++)
      if(checkTestInst(&*it, testName)) return true;
    return false;
  }
  bool checkBreakInst(Instruction * I) {
    return checkTestInst(I, LOOPEXITBB);  
  }
  void updateIter(Instruction * I) {
    if(checkTestInst(I, LOOPITERBB)) iterations++;  
  }
  bool checkPassed() {
    if(!terminated) return false;
    if(!ConstTripCount) return iterations <= DEFAULT_TRIP_COUNT;
    return true;
  }
  ~LoopUnrollTest() {
    for(unsigned i = 0; i < instrumented.size(); i++) {
      Instruction *I = instrumented[i]; 
      I->eraseFromParent();
      I->dropAllReferences();
    }
  }
};

#endif
