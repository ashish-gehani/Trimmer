/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This file is the main header file for RegOps. It contain methods for registers operations such as adding or retrieving registers. A register consists 
of type of the pointer value and a uint64_t variable, which is he location of the memory (See Mem.h) where the value pointed to is stored. 
All the methods of this class are defined in src/RegOps.cpp.*/

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
