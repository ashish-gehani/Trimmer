using namespace llvm;
using namespace std;

#ifndef DEGUB_H_
#define DEGUB_H_
#include "Mem.h"

#define None 0
#define Abubakar 1
#define Hashim 2
#define Maaz 4
#define All 1023

int debugLevel = None; 
class debug {
    public:
    debug(int level) {
        if(debugLevel & level)
            ignore = false;
        else
            ignore = true;
    }
    template<class T>
    debug & operator << (const T &x) {
        if(!ignore)
            errs() << x;
        return *this;
    }

    private:
        bool ignore;
};

void split(string str, vector<string>& tokens, char delim);

void addToDebugLevel(char * str) {
  if(!strncmp(str, "Abubakar", 8))
      debugLevel |= Abubakar;
  else if(!strncmp(str, "Hashim", 6))
      debugLevel |= Hashim;
  else if(!strncmp(str, "Maaz", 4))
    debugLevel |= Maaz;
  else if(!strncmp(str, "All", 3))
      debugLevel |= All;  
}

void initDebugLevel() {
  char * value = getenv("TRIMMER_DEBUG");
  if(!value) return;
  vector<string> names;
  split(value, names, '+');
  for(unsigned i = 0; i < names.size(); i++) addToDebugLevel(&names[i][0u]);
}

void printBB(string before, BasicBlock * BB, string after, int level) {
  debug(level) << before;
  if(debugLevel & level) BB->printAsOperand(errs(), false);        
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

#endif