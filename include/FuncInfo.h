#include "Mem.h"

#ifndef FUNCINFO_H_
#define FUNCINFO_H_

using namespace std;
using namespace llvm;

/*
 * structure keeping track of basic function info 
 * as well as value returned and context at return.
 */

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
