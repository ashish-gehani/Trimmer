#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/Module.h"

#include <string>
#include <fstream>
#include <set>

using namespace llvm;
using namespace std;

int numFunc = 0;
int numInst = 0;
static cl::opt<string> filePath("filePath", cl::init(""));
namespace {
  struct CountPass: public ModulePass {
    static char ID;
    CountPass() : ModulePass(ID) {}
    virtual bool runOnModule(Module &M) {
      ifstream f;
      if(filePath.size())
        f.open(filePath);	
      string str;
      set<string> functions;

      set<string> decRemoved;
      set<string> funcRemoved;

      set<string> decNotRemoved;
      set<string> funcNotRemoved;

      int filteredInsts = 0;
      int numFuncDefinitions = 0;
      int functionsRemoved = 0;
      int declarationsRemoved = 0;

      if(filePath.size())
        while(getline(f, str))
          functions.insert(str);

      for(auto &F: M){
        if(F.isDeclaration()) {
           numFuncDefinitions++; 
	   if(functions.find(F.getName().str()) != functions.end()) {
	     declarationsRemoved++;
	     decRemoved.insert(F.getName().str());
 	   } else {
	     decNotRemoved.insert(F.getName().str());
	   }
     	   continue;
	}

        numFunc++;
	int flag = 0;
        if(functions.find(F.getName().str()) != functions.end()) {
	  functionsRemoved++;
	  funcRemoved.insert(F.getName().str());
	  flag = 1;
	} else {
	  funcNotRemoved.insert(F.getName().str());
	}

        for (auto &BB: F) { 
          for (auto &I: BB) {
            numInst++;
            filteredInsts += flag;
          }
        }
	errs() << F.getName() << "\n";
      }

      errs() << "Declarations Removed\n";
      for(auto &F: decRemoved) {
	errs() << F << "\n";
      }

      errs() << "Functions not removed\n";
      for(auto &F: funcNotRemoved) {
	errs() << F << "\n";
      }

      errs() <<"number of functions: "<<numFunc<<"\n";
      errs() <<"number of function definitions: " << numFuncDefinitions << "\n";
      errs() <<"number of functions removed: " << functionsRemoved << "\n";
      errs() <<"number of declarations removed: " << declarationsRemoved << "\n";
      errs() <<"number of instructions: "<<numInst<<"\n";
      errs() <<"number of instructions removed:" << filteredInsts << "\n";
      return false;
    }
  };
}

char CountPass::ID = 0;

// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
static RegisterPass<CountPass> X("count", "", false, false);
