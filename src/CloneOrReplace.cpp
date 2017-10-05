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
#include "llvm/Transforms/Utils/Cloning.h"
#include <string> 
#include <unistd.h>  
#include <sstream>
using namespace llvm;
using namespace std;

static cl::opt<string> args("args",
                  cl::desc("' ' space seperated argument list"));

namespace {
  struct CloneOrReplace : public ModulePass {
    static char ID;
    string mode, func1, func2;

    void parse() {
      string buf;
      stringstream ss(args);
      vector<string> tokens;

      while(ss >> buf)
        tokens.push_back(buf);
      mode = tokens[0];
      func1 = tokens[1];
      func2 = tokens[2];
    }

    void replaceCalls(Function * oldFunc, Function * newFunc, Module& M) {
      for (Module::iterator mit = M.getFunctionList().begin(); 
          mit != M.getFunctionList().end(); ++mit) {
        for (Function::iterator f_it = mit->begin(), f_ite = mit->end(); 
          f_it != f_ite; ++f_it) {
          for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end();       
            b_it != b_ite; ++b_it) {
            Instruction * I = &*b_it;
            if(CallInst * ci = dyn_cast<CallInst>(I)) {
              Function * F = ci->getCalledFunction();
              if(!F)
                continue;
              string name = F->getName().str();
              if(name.size() >= func2.size() && name.substr(func2.size()) == func2)
                ci->setCalledFunction(newFunc);
            }
          }
        }
      }
    }

    void clone(Module& M) {
      Function * oldFunc = M.getFunction(StringRef(func1));
      ClonedCodeInfo info;
      ValueToValueMapTy vmap;      
      Function * newFunc = llvm::CloneFunction(oldFunc, vmap, true, &info);
      newFunc->setName(StringRef(func2)); 
      M.getFunctionList().push_back(newFunc);
      replaceCalls(oldFunc, newFunc, M);
    }

    void replace(Module& M) {
      Function * oldFunc = M.getFunction(StringRef(func1));
      Function * newFunc = M.getFunction(StringRef(func2));      
      replaceCalls(oldFunc, newFunc, M);
    }

    CloneOrReplace() : ModulePass(ID) {}
    bool runOnModule(Module& M) {
      parse();
      if(mode == "clone")
        clone(M);
      else if(mode == "replace")
        replace(M);
      return true;
    }
  };
}

char CloneOrReplace::ID = 0;
static RegisterPass<CloneOrReplace>
W("CloneOrReplace", "");
