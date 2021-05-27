// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//This file contains methods regarding debugging such as initailzaing debugging Level, printing memory, instructions and basic blocks.

#include "llvm/IR/Instruction.h"	

#include <string>

#include "VecUtils.h"
#include "Debug.h"
#include "Utils.h"

int debugLevel = No;

using namespace llvm;
using namespace std;

debug::debug(int level) {
  if(debugLevel & level)
    ignore = false;
  else
    ignore = true;
}

void initDebugLevel() {
  char * value = getenv("TRIMMER_DEBUG");
  if(!value) return;
  vector<string> names;
  split(value, names, '+');
  for(unsigned i = 0; i < names.size(); i++) addToDebugLevel(&names[i][0u]);
}

void addToDebugLevel(char * str) {
  if(!strncmp(str, "Yes", 3))
      debugLevel |= Yes;
  else if(!strncmp(str, "No", 2))
    debugLevel |= No;
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

void printStr(Memory * mem, uint64_t addr, uint64_t ptrSize) {
  uint64_t strAddr = mem->load(ptrSize, addr);
  char * str = (char *) mem->getActualAddr(strAddr);
  errs() << str; 
}

void printInt(Memory * mem, uint64_t addr, uint64_t size) {
  errs() << mem->load(size, addr);
}

void printConstMem(Memory * mem, uint64_t addr, uint64_t size) {
  for(unsigned i = addr; i < addr + size; i++) {
    errs() << mem->checkConstant(i, 1);
  }
  errs() << "\n";
}
