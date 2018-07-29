#include "RegOps.h"

void RegOps::addGlobalRegister(Value * val, Type * ty, uint64_t toStore) {
  Registers[val] = new Register(ty, toStore);
}

void RegOps::addRegister(Value * val, Type * ty, uint64_t toStore) {
  Registers[val] = new Register(ty, toStore);
}

void RegOps::addRegister(Value * val, Register * reg) {
  Registers[val] = new Register(*reg);
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
    assert(Registers.find(val) != Registers.end() && "unexpected behavior");
    Register * reg = Registers[val];
    delete reg;
    Registers.erase(val);    
  }  
}
