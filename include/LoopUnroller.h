/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This file is the header class for LoopUnroller. It contains methods for loop unrolling such as getting trip count, whether the loop is a File I/O loop, 
whether the loop should be unrolled etc and performs loop unrolling using UnrollLoop function in LLVM. All the methods  of the class are defined in 
src/LoopUnroller.cpp.*/

#include "llvm/IR/Module.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/Analysis/OptimizationRemarkEmitter.h"
#include "llvm/Transforms/Utils/UnrollLoop.h"
#include "RegOps.h"
#include "BBOps.h"
#include "FdInfo.h"
#include "LoopUnrollTest.h"

#ifndef LOOPUNROLLER_H_
#define LOOPUNROLLER_H_

using namespace llvm;
using namespace std;

class LoopUnroller {
  public:
  LoopUnroller(Module *m, bool PreserveLCSSA, Loop *, LoopInfo *);
  ~LoopUnroller();
  void checkTermInst(Instruction * I, uint64_t);
  bool testTerminated();
  bool doUnroll(TargetLibraryInfo * TLI, AssumptionCache &, unsigned);
  static bool checkUnrollHint(BasicBlock * hdr, LoopInfo &LI, Module *);
  static bool shouldSimplifyLoop(BasicBlock *BB, LoopInfo &LI, Module *, bool);
  static bool deleteLoop(BasicBlock *);
  bool getTripCount(TargetLibraryInfo * TLI, AssumptionCache &, unsigned &, bool);
  bool runtest(TargetLibraryInfo * TLI, AssumptionCache &, RegOps regOps, BBOps bbOps,map<int,uint64_t> fdInfoMap, BasicBlock * currBB);
  LoopInfo *getLoopInfo();
  bool checkIfFileIOLoop(Loop * L, RegOps regOps,BBOps bbOps,map<int,uint64_t> fdInfoMap, BasicBlock * currBB);
  int getNumLines(char * fileName);
  int getNumCharacters(char * fileName,int);

  bool checkPassed();
  void setCloneOf(Function *);
  Function *getCloneOf();

  Loop *loop;
  private:
  LoopUnrollTest *ti;
  bool PreserveLCSSA;
  Module *module;
  LoopInfo *LI;
  Function *cloneOf;
  int fileTripCount;
};

#endif
