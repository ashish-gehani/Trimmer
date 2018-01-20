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
#include "loopUtils.cpp"
#include "stringUtils.cpp"


using namespace llvm;
using namespace std;     

void ConstantFolding::processAllocaInst(AllocaInst * ai) {
  if(!trackAllocas()) {
    debug(Abubakar) << "skipping untracked alloca\n";
    return;
  }  
  Type * ty = ai->getAllocatedType();
  unsigned size = DL->getTypeAllocSize(ty);
  uint64_t addr = allocateStack(size);
  addRegister(ai, ty, addr);
  debug(Abubakar) << "allocaInst : size " << size << " at address " << addr << "\n";
}

void ConstantFolding::processMallocInst(CallInst * mi) {   
  if(!trackAllocas()) {
    debug(Abubakar) << "skipping untracked malloc\n";
    return;
  }
  Value * sizeVal = mi->getOperand(0);
  uint64_t size;
  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "mallocInst : size not constant\n";
    return;
  }
  uint64_t addr = allocateHeap(size);  
  addRegister(mi, mi->getType(), addr);
  debug(Abubakar) << "mallocInst : size " << size << " at address " << addr << "\n";  
}

void ConstantFolding::processCallocInst(CallInst * ci) {   
  if(!trackAllocas()) {
    debug(Abubakar) << "skipping untracked calloc\n";
    return;
  }
  Value * numVal = ci->getOperand(0);
  Value * sizeVal = ci->getOperand(1);
  uint64_t num, bsize;

  if(!getSingleVal(numVal, num)) {
    debug(Abubakar) << "callocInst : num not constant\n";
    return;
  }
  if(!getSingleVal(sizeVal, bsize)) {
    debug(Abubakar) << "callocInst : size not constant\n";
    return;
  }
  unsigned size = num * bsize;
  uint64_t addr = allocateHeap(size);  
  addRegister(ci, ci->getType(), addr);
  debug(Abubakar) << "callocInst : size " << size << " at address " << addr << "\n";  
  memset((char *) getActualAddr(addr), '\0', size);
}

void ConstantFolding::processBitCastInst(BitCastInst * bi) {
  Value * ptr = bi->getOperand(0);
  Register * reg = getRegister(ptr);
  if(!reg) {
    debug(Abubakar) << "BitCastInst : Not found in Map\n";
    return;
  }
  addRegister(bi, bi->getType(), reg->getValue());
}

void ConstantFolding::processStoreInst(StoreInst * si) {
  Value* storeOp = si->getOperand(0);
  Value * ptr = si->getOperand(1);
  Register * reg = getRegister(ptr);
  if(!reg) {
    debug(Abubakar) << "StoreInst : not found in map\n";
    return;
  }
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(storeOp->getType());
  uint64_t val;
  if(!getSingleVal(storeOp, val)) {
    debug(Abubakar) << "StoreInst : from cannot be determined\n";
    setConstMem(false, addr, size);
    return;
  }
  storeToMem(val, size, addr);   
}

void ConstantFolding::processLoadInst(LoadInst * li) {
  
  if(bbOps.partOfLoop(li))
    return;
  
  Value * ptr = li->getOperand(0);
  Register * reg = getRegister(ptr);
  if(!reg) {
    debug(Abubakar) << "LoadInst : Not found in Map\n";
    return;
  }
  uint64_t addr = reg->getValue();
  uint64_t size = DL->getTypeAllocSize(li->getType());
  if(!checkConstMem(addr, size)) {
    debug(Abubakar) << "LoadInst : skipping non constant\n";
    return;
  }
  uint64_t val = loadMem(size, addr);
  handleInt(li, val);
}

void ConstantFolding::processGEPInst(GetElementPtrInst * gi) {
  
  Value * ptr = gi->getOperand(0);

  Register * reg = getRegister(ptr);    
  if(!reg) {
    debug(Abubakar) << "GepInst : Not found in map\n";
    return;
  }
  
  unsigned OffsetBits = DL->getPointerTypeSizeInBits(gi->getType());
  APInt offset(OffsetBits, 0); 
  bool isConst = gi->accumulateConstantOffset(*DL, offset);
  if(!isConst) {
    debug(Abubakar) << "GepInst : offset not constant\n";
    setConstContigous(false, reg->getValue());    
    return;
  }
  uint64_t val = reg->getValue() + offset.getZExtValue();
  addRegister(gi, gi->getType(), val);
}

void ConstantFolding::processMemcpyInst(MemCpyInst * memcpyInst) {

  Value * toPtr = memcpyInst->getOperand(0);
  Value * fromPtr = memcpyInst->getOperand(1);
  char * fromString;
  Value * sizeVal = memcpyInst->getOperand(2);
  uint64_t size;
  Register * reg = getRegister(toPtr);  

  if(!reg) {
    debug(Abubakar) << "processMemcpyInst : Not found in Map\n";
    return;
  }
  
  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "processMemcpyInst : size not constant\n";
    setConstContigous(false, reg->getValue()); 
    return;   
  } 

  if(!getStr(fromPtr, fromString, size)) {
    setConstContigous(false, reg->getValue()); 
    return;
  }
  char * toString = (char *) getActualAddr(reg->getValue());
  debug(Abubakar) << "memcpy : from " << fromString << "\n";
  memcpy(toString, fromString, size);
  setConstMem(true, reg->getValue(), size);
}

void ConstantFolding::processMemSetInst(MemSetInst * memsetInst) {
  Value * ptr = memsetInst->getOperand(0);
  Value * chrctr = memsetInst->getOperand(1);
  Value * sizeVal = memsetInst->getOperand(2);

  Register * ptrReg = getRegister(ptr);  
  if(!ptrReg) {
    debug(Abubakar) << "processMemSetInst : Not found in Map\n";
    return;
  }

  uint64_t c;
  if(!getSingleVal(chrctr, c)) {
    debug(Abubakar) << "processMemSetInst : character not found in Map\n";
    return;    
  }

  uint64_t size;
  if(!getSingleVal(sizeVal, size)) {
    debug(Abubakar) << "processMemSetInst : size not found in Map\n";
    return;      
  }
  char * ptrString = (char *) getActualAddr(ptrReg->getValue());
  memset(ptrString, c, size);
}

void ConstantFolding::processPHINode(PHINode * phiNode) {
  if(bbOps.partOfLoop(phiNode))
    return;
  Value * val = bbOps.foldPhiNode(phiNode, BasicBlockContexts);
  if(val && replaceOrCloneRegister(phiNode, val)) {
    debug(Abubakar) << "folded phiNode\n";
  } else
    debug(Abubakar) << "failed to fold phiNode\n";
}

void ConstantFolding::tryfolding(Instruction * I) {
  if(bbOps.partOfLoop(I))
    return;
  if(Instruction * sI = simplifyInst(I))
    tryfolding(sI);
  else {
    Constant * constVal = ConstantFoldInstruction(I, *DL, TLI);
    if(constVal)
      replaceAndLog(I, constVal);    
  }
}

void ConstantFolding::processTermInst(TerminatorInst * termInst) {  
  unsigned numS = termInst->getNumSuccessors(); 
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*currfn).getLoopInfo();
  bbOps.foldToSingleSucc(termInst, LI);
  for(unsigned int index = 0; index < numS; index++) {

    BasicBlock * succ = termInst->getSuccessor(index);
    
    if(!bbOps.visitBB(succ, LI))
      continue;

    if(bbOps.needToduplicate(succ, currBB, BasicBlockContexts)) {
      debug(Abubakar) << "duplicating\n";
      duplicateContext(succ);
      bbOps.mergeContext(succ, currBB, BasicBlockContexts);
    } else {
      debug(Abubakar) << "cloning\n";
      cloneContext(succ);
    }    

    if(index + 1 == numS)
      bbOps.freeBB(currBB, BasicBlockContexts);

    checkTermCond(succ);
    
    if(testTerminated()) // test terminated in the  term condition above
      return;

    if(simplifyLoop(succ)) {
      assert(termInst->getNumSuccessors() == 1); // has to be a preheader
      processTermInst(currBB->getTerminator());
      terminateBB = true;
      return;
    }
    runOnBB(succ);   

    if(testTerminated()) // test terminated in runOnBB bove
      return;
  }
}

void ConstantFolding::processReturnInst(ReturnInst * retInst) {   
  if(currfn->getName().str() == "main")
    return;
  FuncInfo * fi = fimap[currfn];
  Value * ptr = retInst->getReturnValue();
  fi->context = duplicateMem();  
  if(!ptr)
    return;
  if(cloneRegister(retInst, ptr))
    fi->retReg = new Register(*getRegister(retInst)); 
}

void ConstantFolding::processCallInst(CallInst * callInst) {
  if(bbOps.partOfLoop(callInst))
    return;

  Function * calledFunction = callInst->getCalledFunction();  
  if(!calledFunction) {
    markArgsAsNonConst(callInst);
    return;
  }
  /* specialize for functions defined in string.h e.g strcmp, strchr */
  if(isStringFunction(calledFunction)) { 
    handleStringFunction(callInst, calledFunction);
  } else if(calledFunction->getName().str() == "malloc") {
    processMallocInst(callInst);
  } else if(calledFunction->getName().str() == "calloc") {
    processCallocInst(callInst);
  } else if(calledFunction->isDeclaration()) {
    markArgsAsNonConst(callInst);
    return;
  } else {
    initializeFuncInfo(calledFunction);
    // if(!satisfyConds(calledFunction)) {
    //   markArgsAsNonConst(callInst);
    //   return;
    // }
    Function * clone = addClonedFunction(callInst, calledFunction);
    BasicBlock * entry = &clone->getEntryBlock();
    duplicateContext(entry);    
    runOnFunction(callInst, clone); 
  }  
}