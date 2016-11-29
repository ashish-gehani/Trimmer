/*
  Author: Hashim Sharif
  Email: hsharif3@illinois.edu
  LLVM_version: 3.8.0

*/

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Dominators.h"
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
#include <sstream>

using namespace llvm;
using namespace std;

#define debugPrint 0

struct SpecString : public FunctionPass {
 
  static char ID;
  map<Instruction*, Value*> replaceOperands;

  SpecString() : FunctionPass(ID) { }         


  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<DominatorTreeWrapperPass>();
  }


  void replaceCallOperands(){
    for (auto & e : replaceOperands){
      e.first->setOperand(0, e.second);
    }
    
    replaceOperands.clear();    
  }


  char* substring(const char * source, int start, int end){
    source = source + start;
    int nbytes = end - start;
    char * newString = (char*) malloc((nbytes + 1) * sizeof(char));
    memcpy(newString, source, nbytes);
    newString[nbytes] = '\0';
    return newString;     
  }


  virtual bool runOnFunction(Function & F) {
  
    Function * func = &F;
    Instruction * lastMemcpy = NULL;
    Value * globalStringPtr;

    for(Function::iterator i = func->begin(), e = func->end(); i != e; ++i){
      BasicBlock * BB = &*i;
      for(auto & I : *BB){
        Instruction * inst = &I;
        if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(&*inst)){
          if(debugPrint) errs()<<"memcpyInst = "<<*memcpyInst<<"\n";
          lastMemcpy = memcpyInst;
	  globalStringPtr = lastMemcpy->getOperand(1);
	}
        if(CallInst * callInst = dyn_cast<CallInst>(&*inst)){
	  string name = callInst->getCalledFunction()->getName().str();
	  if(name == "substring"){
            if(debugPrint) errs()<<"substring = "<<*callInst<<"\n";
            replaceOperands[callInst] = globalStringPtr;
	  }
	}
      }
    }

    replaceCallOperands(); 
    return true;
  }

};


char SpecString::ID = 0;
static RegisterPass<SpecString> X("spec-string1", "specialising string functions", false, false);
