// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// This pass outputs all the function names to a file, whose name is given as an argument to the pass.

#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include <string>  
#include <fstream>


using namespace llvm;
using namespace std;

static cl::opt<string> out_file("out_file",
			    cl::desc("Name of output file containing function names"));


namespace {
  struct ListFunctions : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    ListFunctions() : ModulePass(ID) {}
  
    virtual bool runOnModule(Module &M) {

      ofstream fout(out_file.c_str());      
      for (Module::iterator mit = M.getFunctionList().begin(); mit != M.getFunctionList().end(); ++mit) {        
        Function* F = &*mit; 
        if (!F->isDeclaration() && F->getName().str() != "main") {
          fout<<F->getName().str()<<"\n";
        }
      }

      fout.close();
      return true;
    }
  };
}

char ListFunctions::ID = 0;
static RegisterPass<ListFunctions> X("list-functions", "Lists all the module functions in an output file",
                                     false, false);
