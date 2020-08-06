#ifndef UTILS_H_
#define UTILS_H_

#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include <string>

#include "BBOps.h"

using namespace llvm;
using namespace std;


void split(string str, vector<string>& tokens, char delim);
Value * getArg(Function * func, int index);
bool ignorefunc(Function * F);
CallInst * getTestInst(string name, Module * module);
Function *cloneFunc(Function *F, ValueToValueMapTy& vmap);
CallInst *createFuncCall(Function *F, vector<Value*>& args);
void getReadonlyFuncNames();
bool checkIfReadOnlyFunc(Function * F);


#endif
