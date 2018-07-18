#include <string>

#ifndef STRINGUTILS_H_
#define STRINGUTILS_H_

bool simpleStrFunc(string name);
bool getStrLen(CallInst * ci, uint64_t& len);
bool getConstantStringInfo(const Value * V, StringRef &Str, uint64_t Offset, bool TrimAtNul);

#endif
