#ifndef DEBUG_H_
#define DEBUG_H_

#include "Mem.h"

using namespace llvm;
using namespace std;

#define DebugNone 0
#define Abubakar 1
#define Hashim 2
#define Maaz 4
#define All 1023

extern int debugLevel; 
class debug {
    public:
    debug(int level); 
    template<class T>
    debug& operator << (const T &x) {
      if(!ignore)
        errs() << x;
      return *this;
    }

    private:
        bool ignore;
};

void initDebugLevel(); 
void printBB(string before, BasicBlock * BB, string after, int level);
void printInst(Instruction * I, int level); 
void printMem(Memory * mem, uint64_t addr, uint64_t size); 
void printInt(Memory * mem, uint64_t addr, uint64_t size);
void printStr(Memory * mem, uint64_t addr, uint64_t ptrSize); 
void printConstMem(Memory * mem, uint64_t addr, uint64_t size); 
void addToDebugLevel(char * str);

#endif
