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
