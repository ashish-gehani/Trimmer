#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Transforms/Utils/SimplifyLibCalls.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include <unistd.h>
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include <fcntl.h>


#include <unistd.h>


#include "llvm/IR/Function.h"
#include "ConstantFolding.h"
#include "Utils.h"
#include "getopt_local.h"
#include "StringUtils.h"
#include "Debug.h"

using namespace llvm;
using namespace std;


void split(string str, vector<string>& tokens) {
    size_t pos = str.find(';');
    size_t initialPos = 0;
    while(pos != string::npos) {
        tokens.push_back( str.substr(initialPos, pos - initialPos));
        initialPos = pos + 1;
        pos = str.find(';', initialPos);
    }
    tokens.push_back(str.substr(initialPos, str.size() - initialPos - 1));
}

Value * getArg(Function * func, int index){
  int i = 0;
  for(auto arg = func->arg_begin(), argEnd = func->arg_end(); arg != argEnd; arg++){
    if(i == index) 
      return &*arg;
    i++;
  }
  return NULL;  
}

void cleanUpfuncBBs(Function * f, BasicBlockContInfoMap bbc,
  ValToRegisterMap& Registers, ValSet valSet) {
  for(auto f_it = f->begin(), f_ite = f->end(); f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    if(bbc.find(BB) == bbc.end())
      continue;
    ContextInfo * ci = bbc[BB];
    if(!ci->deleted && !ci->imageOf)
      delete ci->memory;
    delete ci;
  }
  for(auto val : valSet) {
    assert(Registers.find(val) != Registers.end() && "unexpected behavior");
    Register * reg = Registers[val];
    delete reg;
    Registers.erase(val);    
  }  
}

bool ignorefunc(Function * F) {
  if(F->getName() == "printf" || F->getName() == "strncpy" || F->getName() == "__printf_chk")
    return true;
  if(F->isIntrinsic())
    return true;
  return false;
}

CallInst * getTestInst(string name, Module * module) {
  Value * val = module->getNamedValue(name);
  if(!val) {
    vector<Type *> ArgTypes;
    Type * voidType = Type::getVoidTy(module->getContext());
    FunctionType * FTy = FunctionType::get(voidType, ArgTypes, false);     
    val = Function::Create(FTy, Function::ExternalLinkage, name, module);
  }
  vector<Value *> args;
  CallInst * testCall = CallInst::Create(dyn_cast<Function>(val), args);
  return testCall;
}
