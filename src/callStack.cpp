
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
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
#include "parse_args.h"
#include "processInstructions.h"
#include <fstream>

using namespace llvm;
using namespace std;

#define debugPrint 0

static cl::opt<string> func_name("func_name",
			    cl::desc("Name of function to be gather info for"));


namespace {

  struct FindCallStack : public ModulePass {

    static char ID;
    FindCallStack() : ModulePass(ID) {}
    
    bool runOnModule(Module& M) {
      string func_name_str = func_name.c_str();
      Function * func = M.getFunction(StringRef(func_name_str));
      if(func)
        string stack = getStack(func);
      return false;
    } 


  };
}
char FindCallStack::ID = 0;
static RegisterPass<FindCallStack> W("rem-func-body", "Clear function body");


