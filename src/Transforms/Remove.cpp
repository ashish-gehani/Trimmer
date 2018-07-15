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

namespace {
  struct Remove : public ModulePass {
    static char ID;
    int num;
    Remove() : ModulePass(ID) {}
    bool runOnModule(Module& M) {
      GlobalVariable * annotVar = M.getGlobalVariable(StringRef("llvm.global.annotations"));
      vector<Instruction *> toRemove;
      for (Module::iterator mit = M.getFunctionList().begin(); 
          mit != M.getFunctionList().end(); ++mit) {
        for (Function::iterator f_it = mit->begin(), f_ite = mit->end(); 
          f_it != f_ite; ++f_it) {
          for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end();       
            b_it != b_ite; ++b_it) {
            Instruction * I = &*b_it;
            if(CallInst * ci = dyn_cast<CallInst>(I)) {
              if(!ci->getCalledFunction())
                continue;
              string name = ci->getCalledFunction()->getName();
              if(name == "unroll_loop" || name == "__loop_termination_test__" ||
              name == "__loop_iteration_test__" || name == "__print_debug_string__" ||
              name == "__set_debug_level__")
                toRemove.push_back(I);
            }
          }
        }
      }
      // errs() << toRemove.size() << " removed\n";
      for(unsigned i = 0; i < toRemove.size(); i++)
        toRemove[i]->eraseFromParent();
      if(annotVar)
        annotVar->eraseFromParent();
      return true;
    }
  };
}

char Remove::ID = 0;
static RegisterPass<Remove>
W("remove", "");
