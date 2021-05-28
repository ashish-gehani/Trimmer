/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/*This is the main header file for the AnnotationTest Pass. It defines a class AnnotateTest, which is inherited from LLVM Module Pass. All the methods 
of the class are defined in src/AnnotateTest.cpp.*/


#ifndef ANNOTATE_TEST_H
#define ANNOTATE_TEST_H

#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Instruction.h"

#include <set>

using namespace std;
using namespace llvm;

class AnnotateTest : public ModulePass {
  public:
  static char ID;
  AnnotateTest(): ModulePass(ID) {}

  void getTrackedVariables(set<Value *> &, Module &);
  void getCheckValues(Value *user, set<Value *> &toCheck);
  bool runOnModule(Module &M);
};

#endif
