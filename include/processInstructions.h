#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
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
#include "Utils.cpp"
#include "funcUtils.cpp"


using namespace llvm;
using namespace std;     

void ConstantFolding::processAllocaInst(AllocaInst * ai) {
  Type * ty = ai->getAllocatedType();
  Registers[ai] = new Register(ty, 1);
  uint64_t addr = memory->allocate(DL->getTypeAllocSize(ty));
  Registers[ai] = new Register(ty, addr);
}

void ConstantFolding::processStoreInst(StoreInst * si) {
  Value* storeOp = si->getOperand(0);
  Value * ptr = si->getOperand(1);

  if(Registers.find(ptr) == Registers.end())
    return;

  Register * reg = Registers[ptr];
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(storeOp->getType());
  if(Registers.find(storeOp) != Registers.end()) // TODO-const
    memory->store(Registers[storeOp]->getValue(), size, addr);
  else if(ConstantInt * constInt = dyn_cast<ConstantInt>(storeOp))
    memory->store(constInt->getZExtValue(), size, addr);    
  else if(isa<ConstantPointerNull>(storeOp))
    memory->store(0, size, addr);        
  else
    memory->setConstant(false, addr, size);
}

void ConstantFolding::processLoadInst(LoadInst * li) {

  Value * ptr = li->getOperand(0);

  if(Registers.find(ptr) == Registers.end())
    return;
  Register * reg = Registers[ptr];
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(reg->getType());
  uint64_t val = memory->load(size, addr);
  Registers[li] = new Register(li->getType(), val); 
}

void ConstantFolding::processGEPInst(GetElementPtrInst * gi) {
  
  Value * ptr = gi->getOperand(0);
  
  if(Registers.find(ptr) == Registers.end())
    return;

  Register * reg = Registers[ptr];  
  unsigned OffsetBits = DL->getPointerTypeSizeInBits(gi->getType());
  APInt offset(OffsetBits, 0);
  bool isConst = gi->accumulateConstantOffset(*DL, offset);
  if(!isConst) {
    //
    return;
  }
  uint64_t val = reg->getValue() + offset.getZExtValue();
  Registers[gi] = new Register(gi->getType(), val);
}

void ConstantFolding::processMemcpyInst(MemCpyInst * memcpyInst) {
  Value * toPtr = memcpyInst->getOperand(0);
  Value * fromPtr = memcpyInst->getOperand(1);
  Value * sizeVal = memcpyInst->getOperand(2);
  if(Registers.find(toPtr) == Registers.end())
    return;
  Register * reg = Registers[toPtr];
  
  if(!isa<ConstantInt>(sizeVal)) {
    //TODO-const :
  }
  unsigned size = dyn_cast<ConstantInt>(sizeVal)->getZExtValue();

  char * fromString;
  StringRef stringRef;

  if(getConstantStringInfo(fromPtr, stringRef, 0, false)) {
    fromString = new char[stringRef.str().size()];
    strcpy(fromString, stringRef.str().c_str());
  } else if(Registers.find(fromPtr) != Registers.end()) {
    Register * reg = Registers[fromPtr];
    fromString = (char *) memory->getActualAddr(reg->getValue());
  } else {
    //TODO-const
    return;     
  }
  char * toString = (char *) memory->getActualAddr(reg->getValue());
  memcpy(toString, fromString, size);
}

void ConstantFolding::processTermInst(TerminatorInst * termInst) {   
  for(unsigned int index = 0; index < termInst->getNumSuccessors(); index++) {
    BasicBlock * succ = termInst->getSuccessor(index);
    if(visited.find(succ) != visited.end())
      return;
    if(!predecessorsVisited(succ))
      return;  
    runOnBB(succ);    
  }
}


void ConstantFolding::processCallInst(CallInst * callInst) {

  Function * calledFunction = callInst->getCalledFunction();  
  // Indirect function calls need special handling
  if(calledFunction == NULL) {
    //TODO
  }
  /* specialize for functions defined in string.h e.g strcmp, strchr */
  if(isStringFunction(calledFunction)) { 
    handleStringFunction(callInst, calledFunction);
  } else if(calledFunction->isDeclaration()) {
    //TODO-const : 
  } else {
    Function * clone = addClonedFunction(callInst, calledFunction);
    unsigned index = 0;
    for(auto arg = calledFunction->arg_begin(); arg != calledFunction->arg_end();
        arg++, index++) {
      Value * pointerArg = callInst->getOperand(index);
      if(Registers.find(pointerArg) == Registers.end())
        continue;
      Register * reg = Registers[pointerArg];
      Value * pointerVal = getArg(clone, index);
      Registers[pointerVal] = new Register(reg->getType(), reg->getValue());
    }
    runOnFunction(clone); 
  }  
}