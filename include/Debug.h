/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#ifndef DEBUG_H_
#define DEBUG_H_

#include "Mem.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace std;

#define No 0
#define Yes 1



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
