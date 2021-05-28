/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This file consists of a structure FuncInfo keeping track of basic function information as well as value returned and context at return.*/


#include "Mem.h"

#ifndef FUNCINFO_H_
#define FUNCINFO_H_

using namespace std;
using namespace llvm;


struct FuncInfo {
  Memory * context;
  Register * retReg;
  bool calledInLoop,
       addrTaken;
  unsigned directCallInsts;
  FuncInfo(Function * F) {
    context = NULL;
    retReg = NULL;
    addrTaken = (F->hasAddressTaken() > 0);
    calledInLoop = false;
    directCallInsts = 0;
  }
};

#endif
