// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//This pass sets the linkages of Globals(variables and functions) as Internal.


#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include <string>  

using namespace llvm;
using namespace std;

namespace {
  struct Internalize : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    Internalize() : ModulePass(ID) {}
  
    static inline GlobalValue::LinkageTypes
    localizeLinkage(GlobalValue::LinkageTypes l)
    {
      switch (l) {
	// TODO I'm not sure if all external definitions have an appropriate internal counterpart
      default:
	return l;
      case GlobalValue::ExternalLinkage:
	return GlobalValue::InternalLinkage;
      case GlobalValue::ExternalWeakLinkage:
	return GlobalValue::WeakODRLinkage;
      case GlobalValue::AppendingLinkage:
	return GlobalValue::AppendingLinkage;
      }
    }
   

    virtual bool runOnModule(Module &M) {

      for (Module::iterator mit = M.getFunctionList().begin(); mit != M.getFunctionList().end(); ++mit) {        
        Function* F = &*mit; 
        if (!F->isDeclaration() && F->hasExternalLinkage() && F->getName().str() != "main") {
          F->setLinkage(GlobalValue::InternalLinkage);
        }
      }

      for (Module::const_global_iterator I = M.global_begin(), E = M.global_end();
            I != E; ++I) {
        GlobalVariable* gv = const_cast<GlobalVariable*>(&*I);
          if (gv->hasExternalLinkage() && !gv->isDeclaration())
            gv->setLinkage(GlobalValue::InternalLinkage);    
      }

      for (Module::alias_iterator i = M.alias_begin(), e = M.alias_end(); i != e; ++i) {
        if (i->hasExternalLinkage() || i->hasWeakLinkage()) {
          i->setLinkage(GlobalValue::InternalLinkage);
        }
      }

      return true;
    }
  };
}

char Internalize::ID = 0;
static RegisterPass<Internalize> X("intern", "Internalize Pass", false, false);
