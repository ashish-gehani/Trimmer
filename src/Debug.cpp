#include "llvm/IR/Instruction.h"	

#include <string>

#include "VecUtils.h"
#include "Debug.h"

int debugLevel = 0;

using namespace llvm;
using namespace std;

debug::debug(int level) {
  if(debugLevel == All || level == debugLevel || level == All)
    ignore = false;
  else
    ignore = true;
}

void initDebugLevel() {
    char * value = getenv("TRIMMER_DEBUG");
    if(!value)
        return;
    if(!strncmp(value, "Abubakar", 8))
        debugLevel = Abubakar;
    else if(!strncmp(value, "Hashim", 6))
        debugLevel = Hashim;
    else if(!strncmp(value, "All", 3))
        debugLevel = All;
}

void printBB(string before, BasicBlock * BB, string after, int level) {
    debug(level) << before;
    if(debugLevel == All || level == debugLevel || level == All)
        BB->printAsOperand(errs(), false);        
    debug(level) << after;
}

void printInst(Instruction * I, int level) {
  debug(level) << *I << " is the inst "; 
  if(I->getParent()) {
    printBB(" in BB ", I->getParent(), "", level); 
    if(I->getFunction())
      debug(level) << " " << I->getFunction()->getName() << " ";
  }
  debug(level) << "\n";
}

void printMem(Memory * mem, uint64_t addr, uint64_t size) {
    char * cmem = (char *) mem->getActualAddr(addr);
  for(unsigned i = 0; i < size; i++) {
    errs() << cmem[i];
  }
  errs() << "\n";
}

void printInt(Memory * mem, uint64_t addr, uint64_t size) {
    errs() << mem->load(size, addr);
}

void printStr(Memory * mem, uint64_t addr, uint64_t ptrSize) {
    uint64_t strAddr = mem->load(ptrSize, addr);
    char * str = (char *) mem->getActualAddr(strAddr);
    errs() << str; 
}

void printConstMem(Memory * mem, uint64_t addr, uint64_t size) {
  for(unsigned i = addr; i < addr + size; i++) {
    errs() << mem->checkConstant(i, 1);
  }
  errs() << "\n";
}
