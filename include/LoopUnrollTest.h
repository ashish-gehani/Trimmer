/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "Debug.h"
#include "Mem.h"

#ifndef TYPES_H_
#define TYPES_H_

#include "llvm/Analysis/LoopInfo.h"

#define LOOPEXITBB "__loop_termination_test__"
#define LOOPITERBB "__loop_iteration_test__"
#define PRNTDBGSTR "__print_debug_string__"
#define SETDBGLEVEL "__set_debug_level__"

#define DEFAULT_TRIP_COUNT 15

using namespace std;
using namespace llvm;


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
  static int GLOBAL_LOOP_ID;
  bool terminated, ConstTripCount, isFileIOLoop;              
  vector<Instruction *> indepInsts;
  map<Instruction *, ProcResult> InstResults; 
  unsigned numOrigInsts, partOfLoop, iterations; 
  int id, fileTripCount;
  //vector<Instruction *> instrumented;
  LoopUnrollTest(Loop * L, Module * module, bool tripCount, bool isFileIOLoop, int fileCount);
  string getExitName(); 
  string getIterName(); 

  Instruction * firstInst(BasicBlock * BB);
  bool checkTestInst(Instruction * I, string testName);
  bool containsTestInst(BasicBlock * BB, string testName);
  bool checkBreakInst(Instruction * I);
  void updateIter(Instruction * I);
  bool checkPassed();
  
  void removeInstructions(Function *F);
  void updateTime(Instruction *, uint64_t);
  uint64_t elapsedTime;
};
#endif