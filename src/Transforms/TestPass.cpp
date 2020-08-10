// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/CommandLine.h"
#include <string> 
#include <unistd.h>  
using namespace llvm;
using namespace std;

GlobalVariable*
materializeStringLiteral(llvm::Module& m, const char* data) {
    Constant* ary = llvm::ConstantDataArray::getString(m.getContext(), data, true);
    GlobalVariable* gv = new GlobalVariable(m, ary->getType(), true, GlobalValue::LinkageTypes::PrivateLinkage, ary, "");
    gv->setConstant(true);
    return gv;
}

struct StatBuf {
  GlobalVariable* cic;
  GlobalVariable* mic;
};

namespace {
  struct testing : public ModulePass {
    static char ID;
    int num;
    testing() : ModulePass(ID) {}
    bool runOnModule(Module& M) {
      Function* pruned, *not_pruned;
      pruned = not_pruned = NULL;
      bool passed = true;
      for (Module::iterator mit = M.getFunctionList().begin(); mit != M.getFunctionList().end(); ++mit) {
        Function* F = &*mit;
        string name = F->getName().str();
        if(name == "branchPruned_clone")
          pruned = F;
        else if(name == "branchNotPruned_clone")
          not_pruned = F;
      }
      if(!pruned && !not_pruned) {
        errs() << "niether branchPruned_clone nor branchNotPruned_clone\n";
        passed = false;
      }
      if(pruned) {
        bool found = false;
        for (Function::iterator f_it = pruned->begin(), f_ite = pruned->end(); f_it != f_ite; ++f_it) {
          for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); b_it != b_ite; ++b_it) {
            Instruction* I = &*b_it;
            if(isa<BranchInst>(I)) {
              errs() << "branchInst found in " << pruned->getName().str() << "\n";
              passed = false;
            } else if(CallInst* ci = dyn_cast<CallInst>(I)) {
              string fname = ci->getCalledFunction()->getName().str();
              if(fname == "printf" || fname == "puts")
                found = true;
            }
          }
        }
        if(!found) {
          errs() << "print statement not found in " << pruned->getName().str() << "\n";
          passed = false;
        }
      }
      if(not_pruned) {
        bool found = false;
        for (Function::iterator f_it = not_pruned->begin(), f_ite = not_pruned->end(); f_it != f_ite; ++f_it) {
          for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); b_it != b_ite; ++b_it) {
            Instruction* I = &*b_it;
            if(isa<BranchInst>(I)) {
              found = true;
            }
          }
        }
        if(!found) {
          errs() << "branchInst not found in Function " << not_pruned->getName().str() << "\n";
          passed = false;
        }
      }
      if(passed)
        errs() << "Test passed\n";
      else
        errs() << "Test failed\n";
      return false;
    }
  };
}

char testing::ID = 0;
static RegisterPass<testing>
W("testing", "");
