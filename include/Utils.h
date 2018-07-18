#ifndef UTILS_H_
#define UTILS_H_

#include "llvm/IR/Function.h"

#include <string>

#include "BBOps.h"
#include "ConstantFolding.h"

using namespace llvm;
using namespace std;


void split(string str, vector<string>& tokens, char delim);
Value * getArg(Function * func, int index);
void cleanUpfuncBBs(Function * f, BasicBlockContInfoMap bbc, ValToRegisterMap& Registers, ValSet valSet);
bool ignorefunc(Function * F);
CallInst * getTestInst(string name, Module * module);

#endif
