#include <string>

#include "BBOps.h"

#ifndef UTILS_H_
#define UTILS_H_

using namespace llvm;
using namespace std;


void split(string str, vector<string>& tokens);
Value * getArg(Function * func, int index);
void cleanUpfuncBBs(Function * f, BasicBlockContInfoMap bbc, ValToRegisterMap& Registers, ValSet valSet);
bool ignorefunc(Function * F);
CallInst * getTestInst(string name, Module * module);

#endif
