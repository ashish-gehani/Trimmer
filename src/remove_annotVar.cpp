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
      if(annotVar)
        annotVar->eraseFromParent();
      return true;
    }
  };
}

char Remove::ID = 0;
static RegisterPass<Remove>
W("remove", "");
