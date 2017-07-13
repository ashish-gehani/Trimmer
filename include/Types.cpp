#include "Types.h"

using namespace llvm;
using namespace std;

FuncInfo* initializeFuncInfo(Function* F) {
  FuncInfo* fi = new FuncInfo;
  fi->numCallInsts = 0;
  fi->calledInLoop = false;
  fi->AddrTaken = F->hasAddressTaken();
  return fi;
}