#include "RegOps.h"

void RegOps::addGlobalRegister(Value * val, Type * ty, uint64_t toStore) {
  Register *reg = new Register(ty, toStore);
  Registers[val] = reg;
  RevRegisters[reg] = val;
}

void RegOps::addRegister(Value * val, Type * ty, uint64_t toStore, bool tracked) {
  Register *reg = new Register(ty, toStore, tracked);
  Registers[val] = reg;
  RevRegisters[reg] = val;
}

void RegOps::addRegister(Value * val, Register * oldReg) {
  Register *reg = new Register(*oldReg);
  Registers[val] = reg;
  RevRegisters[reg] = val;
}

Register * RegOps::getRegister(Value * ptr) {
  if(!ptr)
    return NULL;

  if(Registers.find(ptr) != Registers.end())
    return Registers[ptr];

  return NULL; 
}

void RegOps::cleanUpFuncBBRegisters(Function * f, ValSet valSet) { 
  for(auto val : valSet) {
    //assert(Registers.find(val) != Registers.end() && "unexpected behavior");
    if(Registers.find(val) == Registers.end())
      return;
    Register * reg = Registers[val];
    RevRegisters.erase(reg);
    delete reg;
    Registers.erase(val); 
  }  
}

Value *RegOps::getValue(Register *reg) {
  if(RevRegisters.find(reg) != RevRegisters.end())
    return RevRegisters[reg];
  return NULL;
}
