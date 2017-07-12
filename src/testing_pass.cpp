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
      vector<Function*> pruned;
      vector<Function*> not_pruned;
      for (Module::iterator mit = M.getFunctionList().begin(); mit != M.getFunctionList().end(); ++mit) {
        Function* F = &*mit;
        string name = F->getName().str();
        if(name.substr (0,12) == "branchPruned") 
          pruned.push_back(F);
        else if(name.substr (0,15) == "branchNotPruned")
          not_pruned.push_back(F);
      }
      bool passed = true;
      for(unsigned i = 0; i < pruned.size(); i++) {
        Function* F = pruned[i];
        for (Function::iterator f_it = F->begin(), f_ite = F->end(); f_it != f_ite; ++f_it) {
          for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); b_it != b_ite; ++b_it) {
            Instruction* I = &*b_it;
            if(isa<BranchInst>(I)) {
              errs() << "branchInst found in " << F->getName().str() << "\n";
              passed = false;
            }
          }
        }
      }
      for(unsigned i = 0; i < not_pruned.size(); i++) {
        Function* F = not_pruned[i];
        bool found = false;
        for (Function::iterator f_it = F->begin(), f_ite = F->end(); f_it != f_ite; ++f_it) {
          for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); b_it != b_ite; ++b_it) {
            Instruction* I = &*b_it;
            if(isa<BranchInst>(I)) {
              found = true;
            }
          }
        }
        if(!found) {
          errs() << "branchInst not found in Function " << F->getName().str() << "\n";
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
