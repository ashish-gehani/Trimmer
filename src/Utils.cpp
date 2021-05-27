// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/* This file contains some utils functions such as split string, cloning function, creating function call, get argument at index i of a function, read names of
read-only functions from dat/readOnlyFunc.txt and test whether the function is read-only or not.*/ 

#include "Utils.h"

using namespace llvm;
using namespace std;

map<string,int> readOnlyFuncs;

void split(string str, vector<string>& tokens, char delim) {
    size_t pos = str.find(delim);
    size_t initialPos = 0;
    while(pos != string::npos) {
        tokens.push_back( str.substr(initialPos, pos - initialPos));
        initialPos = pos + 1;
        pos = str.find(delim, initialPos); 
    }
    size_t to = str.size() - initialPos;
    if(str[str.size() - 1] == delim) to--;
    tokens.push_back(str.substr(initialPos, to));
}

Function *cloneFunc(Function *F, ValueToValueMapTy& vmap) {
  ClonedCodeInfo info;
  string name = F->getName().str();
  Function * clonedFunc = llvm::CloneFunction(F, vmap, &info);
  // F->getParent()->getFunctionList().push_back(clonedFunc);
  clonedFunc->setName(StringRef(name + "_clone")); 
  return clonedFunc;
}

CallInst *createFuncCall(Function *F, vector<Value*>& args) {
  CallInst * specCallInst = CallInst::Create(F, args);
  return specCallInst;
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

void getReadonlyFuncNames()
{
  string const HOME = std::getenv("TRIMMER_HOME") ? std::getenv("TRIMMER_HOME") : ".";
  char fileName[1000];
  strcpy(fileName,HOME.c_str());
  strcat(fileName,"/data/readOnlyFuncs.txt");
  FILE * stream = fopen(fileName,"r");
  if(stream == NULL)
  {

    exit(1);
  }
  char buffer[100];

  while(fgets(buffer,100,stream) !=NULL)
  {
    char * cp= strchr(buffer,'\n');
    if(cp)
     *cp = '\0';
    string buffer2(buffer);
    readOnlyFuncs[buffer2] = 1;

  }
}

bool checkIfReadOnlyFunc(Function * F)
{
  string funcName = F->getName().str();
  std::map<string,int>::iterator it;
  it = readOnlyFuncs.find(funcName);

  if (it != readOnlyFuncs.end())
  {

    return true;
  }
  if(F->isIntrinsic())
    return true;
  return false;
}
