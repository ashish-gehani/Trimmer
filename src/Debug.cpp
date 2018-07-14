#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Transforms/Utils/SimplifyLibCalls.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include <unistd.h>
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include <fcntl.h>


#include <string>

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

template<class T>
raw_ostream& debug::operator << (raw_ostream& err, const T &x) {
  if(!ignore)
    err() << x;
  return err;
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
