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

#include "../include/vecUtils.h"
using namespace llvm;
using namespace std;

struct FuncInfo {
  vector<Function *> callers;
  vector<Function *> called;
  bool addrTaken;
};

FuncInfo * initFuncInfo(Function * F) {
  FuncInfo * fi = new FuncInfo;
  fi->addrTaken = F->hasAddressTaken();
  return fi;
}

namespace {

  struct CloneOrReplace : public ModulePass {
    map<Function *, FuncInfo *> FuncInfoMap;
    static char ID; 
    CloneOrReplace() : ModulePass(ID) {}
    bool runOnModule(Module& M) {
      for (Module::iterator mit = M.getFunctionList().begin(); 
          mit != M.getFunctionList().end(); ++mit) {
        Function * currFunc = &*mit;
        if(FuncInfoMap.find(currFunc) == FuncInfoMap.end())
          FuncInfoMap[currFunc] = initFuncInfo(currFunc);
        for (Function::iterator f_it = mit->begin(), f_ite = mit->end(); 
          f_it != f_ite; ++f_it) {
          for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); 
            b_it != b_ite; ++b_it) {    
            Instruction * I = &*b_it; 
            if(CallInst * ci = dyn_cast<CallInst>(I)) {
              Function * F = ci->getCalledFunction();
              if(!F || F->isDeclaration())
                continue;
              if(FuncInfoMap.find(F) == FuncInfoMap.end())
                FuncInfoMap[F] = initFuncInfo(F);
              InsertUnique(FuncInfoMap[currFunc]->called, F);
              InsertUnique(FuncInfoMap[F]->callers, currFunc);
            }
          }
        }
      }  
      for(auto const &ent : FuncInfoMap) {
        Function * F = ent.first;
        FuncInfo * fi = ent.second;
        errs() << F->getName() << "\n";
        for(unsigned i = 0; i < fi->called.size(); i++) {
          errs() << fi->called[i]->getName();
          if(i < (fi->called.size() - 1))
            errs() << ",";
        }
        errs() << "\n";
        for(unsigned i = 0; i < fi->callers.size(); i++) {
          errs() << fi->callers[i]->getName();
          if(i < (fi->callers.size() - 1))
            errs() << ",";
        }
        errs() << "\n";
        errs() << fi->addrTaken << "\n";
      }
      return true;
    }
  };
}

char CloneOrReplace::ID = 0;
static RegisterPass<CloneOrReplace>
W("CloneOrReplace", "");
