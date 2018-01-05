using namespace llvm;
using namespace std;
#include "mem.h"

#ifndef DEGUB_H_
#define DEGUB_H_
#define None 0
#define Hashim 1
#define Abubakar 2
#define All 3

Instruction* debugInst;
int debugLevel = None; 
class debug {
    public:
    debug(int level) {
        if(debugLevel == All || level == debugLevel || level == All)
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

void printMem(Memory * mem, uint64_t addr, uint64_t size) {
    char * cmem = (char *) mem->getActualAddr(addr);
  for(unsigned i = 0; i < size; i++) {
    errs() << cmem[i];
  }
  errs() << "\n";
}

void printConstMem(Memory * mem, uint64_t addr, uint64_t size) {
  for(unsigned i = addr; i < addr + size; i++) {
    errs() << mem->checkConstant(i, 1);
  }
  errs() << "\n";
}

#endif
