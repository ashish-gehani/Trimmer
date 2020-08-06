#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include "llvm/ADT/StringRef.h"

#include <string>

using namespace std;
using namespace llvm;

#ifndef STRINGUTILS_H_
#define STRINGUTILS_H_

bool simpleStrFunc(string name);
bool getStrLen(CallInst * ci, uint64_t& len);
bool getConstantStringInfo(const Value * V, StringRef &Str, uint64_t Offset, bool TrimAtNul);

#endif
