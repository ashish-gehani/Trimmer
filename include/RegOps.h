/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "llvm/IR/Value.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Constants.h"

#include <string>
#include <map>
#include <set>

#include "Mem.h"

#ifndef REGOPS_H_
#define REGOPS_H_

using namespace std;
using namespace llvm;

typedef map<Value *, Register *> ValToRegisterMap;
typedef map<Register *, Value *> RegToValMap;
typedef set<Value *> ValSet;

class RegOps {
public:
  Register * getRegister(Value * ptr);
  void addRegister(Value * val, Register * reg);
  void addRegister(Value * val, Type * ty, uint64_t toStore, bool tracked = false);
  void addGlobalRegister(Value * val, Type * ty, uint64_t toStore);
  void cleanUpFuncBBRegisters(Function * f, ValSet valSet);
  Value *getValue(Register *);
private:
  ValToRegisterMap Registers;
  RegToValMap RevRegisters;
};
#endif
