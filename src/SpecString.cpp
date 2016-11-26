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

  SpecString() : FunctionPass(ID) { }       

  Value * getLastMemcpy(Instruction * instruction){
    Value * buff = instruction->getOperand(1);
    Value * lastMemcpy = NULL;
    for(User * user : buff->users()){
      if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(&*user))
        lastMemcpy = memcpyInst;
      if(user == instruction)
        break;    
    }

    return lastMemcpy;
  }

  virtual bool runOnFunction(Function & F) {
    Function * func = &F;
    for(inst_iterator inst = inst_begin(func), e = inst_end(func); inst != e;) {
      Instruction * I = &(*inst++);
      if(CallInst * callInst = dyn_cast<CallInst>(&*I)){
	string name = callInst->getCalledFunction()->getName().str();
	if(name == "printf"){	  
	  Value * lastMemcpy = getLastMemcpy(callInst);
          if(lastMemcpy != NULL) 
            errs()<<" Last memcpy = "<<*lastMemcpy<<"\n";
          else
            errs()<<"NULL Value \n";     
	}
      }
    }
 
    ////--- replaceReadCalls();
    return true;
  }

};


char SpecString::ID = 0;
static RegisterPass<SpecString> X("spec-string", "specialising string functions", false, false);
