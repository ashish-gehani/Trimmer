// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "LoopUnrollTest.h"
#include "llvm/Analysis/LoopInfo.h"

using namespace llvm;
using namespace std;

int LoopUnrollTest::GLOBAL_LOOP_ID = 0;

LoopUnrollTest::LoopUnrollTest(Loop * L, Module * module, bool tripCount, bool isFileIO, int fileCount) {
  elapsedTime = 0;
  terminated = false;
  ConstTripCount = tripCount;
  isFileIOLoop = isFileIO;
  fileTripCount = fileCount;
  id = GLOBAL_LOOP_ID;
  GLOBAL_LOOP_ID++;
  CallInst * testCall = getTestInst(getExitName(), module);
  CallInst * iterCall = getTestInst(getIterName(), module);  
  SmallVector<BasicBlock*, 16> ExitBlocks;
  L->getUniqueExitBlocks(ExitBlocks);
  for(unsigned i = 0; i < ExitBlocks.size(); i++) {
    BasicBlock * BB = ExitBlocks[i];
    Instruction *I = testCall->clone();
    I->insertBefore(firstInst(BB));
    //instrumented.push_back(I);
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

string LoopUnrollTest::getExitName() {
  return string(LOOPEXITBB) + "_" + to_string(id);
}

string LoopUnrollTest::getIterName() {
  return string(LOOPITERBB) + "_" + to_string(id);
}

Instruction *LoopUnrollTest::firstInst(BasicBlock * BB) {
  BasicBlock::iterator it;
  for(it = BB->begin(); it != BB->end(); it++) {
    if(!isa<PHINode>(&*it))
      break;
  }
  return &*it;    
}

bool LoopUnrollTest::checkTestInst(Instruction * I, string testName) {
  if(CallInst * ci = dyn_cast<CallInst>(I)) {
    debug(Yes) << "testname = " << testName << "\n"; 
    debug(Yes) << "testing for " << *ci << "\n";
    if(ci->getCalledFunction() && ci->getCalledFunction()->getName().str() == testName)
      return true;
  }
  return false;
}

bool LoopUnrollTest::containsTestInst(BasicBlock * BB, string testName) {
  for(BasicBlock::iterator it = BB->begin(); it != BB->end(); it++)
    if(checkTestInst(&*it, testName)) return true;
  return false;
}

bool LoopUnrollTest::checkBreakInst(Instruction * I) {
  return checkTestInst(I, getExitName());  
}

void LoopUnrollTest::updateIter(Instruction * I) {
  if(checkTestInst(I, getIterName())) {
    iterations++;  
  }
}

bool LoopUnrollTest::checkPassed() {
  if(!terminated) return false;
  if(elapsedTime > 300) return false;
  debug(Yes) << "iterations = " << iterations << "\n";
  if(!ConstTripCount){ 
    if(isFileIOLoop)
     return iterations < fileTripCount + 5;
   else
     return iterations < DEFAULT_TRIP_COUNT + 5;
  }
  return true;
}

void LoopUnrollTest::updateTime(Instruction *I, uint64_t seconds) {
  elapsedTime = seconds;
  //debug(Yes) << "updateTime: seconds = " << seconds << "\n";
  Module *m = I->getParent()->getParent()->getParent();
  //CallInst *iterCall = getTestInst(getIterName(), module);
  Function *f = m->getFunction(getExitName());
  CallInst *call = NULL;

  for(auto use: f->users()) {
    if(auto CI = dyn_cast<CallInst>(use))
      call = CI;
  }

  if(!call) {
    debug(Yes) << "updateTime: call not found\n";
    return;
  }

  //if in the same function, only then fail the test
  if(I->getParent()->getParent() == call->getParent()->getParent())
    if(elapsedTime > 300) {
      debug(Yes) << "updateTime: loop terminated due to overtime\n";
      terminated = true;
    }
}

void LoopUnrollTest::removeInstructions(Function *F) {
  string exitName = getExitName();
  string iterName = getIterName();

  for(auto &BB: *F) {
    for(auto &I: BB) {
      if(auto call = dyn_cast<CallInst>(&I)) {
        if(call->getCalledFunction() && (call->getCalledFunction()->getName() == exitName || call->getCalledFunction()->getName() == iterName)) {
          I.eraseFromParent();
          I.dropAllReferences();
        }
      }
    } 
  }
}
