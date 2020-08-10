/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

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
