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
typedef set<Value *> ValSet;

class RegOps {
public:
  Register * getRegister(Value * ptr);
  void addRegister(Value * val, Register * reg);
  void addRegister(Value * val, Type * ty, uint64_t toStore);
  void addGlobalRegister(Value * val, Type * ty, uint64_t toStore);
  void cleanUpFuncBBRegisters(Function * f, ValSet valSet);
private:
  ValToRegisterMap Registers;
};
#endif
