/*
  Author: Hashim Sharif
  Email: hsharif3@illinois.edu
  LLVM_version: 3.8.0

TODO:
 1) Consider pointer aliasing - currenly extra conservative 
 2) Need to consider multiple arguments that may access same memory (argument aliasing)
 3) Add specialization for more libc routines e.g strdup
 4) Test on more examples - currently tested with mini_httpd
 5) FIXIT: Make this a function pass 

ASSUMPTIONS
 1) catering only i8* arrays

*/

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Transforms/Utils/SimplifyLibCalls.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include <llvm/Analysis/LoopInfo.h>
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
#include "../include/processInstructions.h"

using namespace llvm;
using namespace std;

// Adding llvm::MemoryDependenceAnalysis as a required PrePass                                                         
void ConstantFolding::getAnalysisUsage(AnalysisUsage &AU) const { 
  //AU.addRequired<MemoryDependenceAnalysis>();
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.addRequired<TargetLibraryInfoWrapperPass>();
  AU.addRequired<CallGraphWrapperPass>();
  AU.addRequired<LoopInfoWrapperPass>();
}

  
void ConstantFolding::replaceCallOperands(){

  for (auto & e : replaceOperands){
    debug(Hashim) << "NOTE: ***** callInst = " << *e.first << "\n";
    vector<CallOperand*> operands = e.second;
    for(unsigned int i = 0; i < operands.size(); i++){
      CallOperand * callInfo = operands[i];
      debug(Hashim) << "* new Operand = " << *callInfo->newOperand << "\n";
      e.first->setOperand(callInfo->index, callInfo->newOperand);
    }
  }  
  replaceOperands.clear();    
}
 

// TODO: Make sure cloned functions calling other specialized routines are correctly retained
void ConstantFolding::replaceCallInsts(){
  for (auto & e : specializedCalls){
    SpecializedCall * call = e.second;
    CallInst * from = call->origCall;
    debug(Hashim) << "from = " << *from << "\n";
    CallInst * to = call->specCall;
    if(call->used){   
      debug(Hashim) << "Replacing " << *from << " with " << *to << "\n";
      ReplaceInstWithInst(from, to);  
    }
    else{
      debug(Hashim) << "Delecting Instruction = " << *to << "\n";
      delete to;
    }
  }  
  specializedCalls.clear();    
} 

/*task1*/
bool ConstantFolding::satisfyConds(Function* F) {
  if(FuncInfoMap.find(F) == FuncInfoMap.end())
    return false; // conservative
  FuncInfo* fi = FuncInfoMap[F];
  return !(fi->calledInLoop || fi->AddrTaken || (fi->numCallInsts != 1)); 
}

/*task1*/
// iterate over all functions and gather info for functions
// called in loop {loop info wrapper pass}
// AddressTaken {use LLVM built in function}
// numCallInsts 

void ConstantFolding::gatherFuncInfo(Module& M) {
  for (Module::iterator mit = M.getFunctionList().begin(); mit != M.getFunctionList().end(); ++mit) {
    for (Function::iterator f_it = mit->begin(), f_ite = mit->end(); f_it != f_ite; ++f_it) {
      LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*mit).getLoopInfo();
      for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); b_it != b_ite; ++b_it) {
        Instruction* I = &*b_it;
        if(CallInst* ci = dyn_cast<CallInst>(I)) {
          Function* F = ci->getCalledFunction();
          if(!F)
            continue;
          if(!FuncInfoMap[F])
            FuncInfoMap[F] = initializeFuncInfo(F);
          if(LI.getLoopFor(&*f_it))
            FuncInfoMap[F]->calledInLoop = true;
          FuncInfoMap[F]->numCallInsts++;
        }
      }
    }
  }
}


/* IMP: New policy - visited passed by reference; no basic block visited twice - important to avoid wrongly 
   duplicating contexts e.g function cloning */ 
void ConstantFolding::runOnBB(BasicBlock * BB, ValScalarAllocaMap scalarAllocas, 
	     ValSSAPointerMap SSAPointers, BasicBlockBoolMap & visited){
   
  BasicBlock& b = *BB;
  for (BasicBlock::iterator inst = b.begin(), ie = b.end(); inst != ie; ) {

    Instruction * I = &(*inst);
    // errs() << *I << "\n";
    // Only considering allocas for string specialisation
    if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(&*I)){
      processAllocaInst(allocaInst, scalarAllocas, SSAPointers, visited, inst);  
    }
    else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(&*I)){
      processMemcpyInst(memcpyInst, scalarAllocas, SSAPointers, visited, inst);
    }	
    else if(StoreInst * storeInst = dyn_cast<StoreInst>(&*I)){
      processStoreInst(storeInst, scalarAllocas, SSAPointers, visited, inst);
    }
    else if(LoadInst * loadInst = dyn_cast<LoadInst>(&*I)){
      processLoadInst(loadInst, scalarAllocas, SSAPointers, visited, inst);
    }    
    else if(CallInst * callInst = dyn_cast<CallInst>(&*I)){
      processCallInst(callInst, scalarAllocas, SSAPointers, visited, inst);
    }
    else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(&*I)){
      processGEPInst(GEPInst, scalarAllocas, SSAPointers, visited, inst);
    }
    else if(BranchInst * branchInst = dyn_cast<BranchInst>(&*I)){
      processBranchInst(branchInst, scalarAllocas, SSAPointers, visited, inst);
    } else if(BitCastInst * bitcastInst = dyn_cast<BitCastInst>(I)) {
       processBitCastInst(bitcastInst, scalarAllocas, SSAPointers, visited, inst);
    } else {           
      // Any other instruction - currently skip 
      inst++; 
    }
  }
} 

bool ConstantFolding::runOnModule(Module & module) {

  debug(Hashim) << "\n\n*******---- InterConstProp -----*********\n\n";
  gatherFuncInfo(module);
    
  ValScalarAllocaMap scalarAllocas;  
  // stringPointers is a map of constant pointers - string pointers with constant index into alloca   
  ValSSAPointerMap SSAPointers;
  BasicBlockBoolMap visited; 

  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  DL = new DataLayout(&module);   
  CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();

  M = &module;
  Function * func = M->getFunction(StringRef("main"));
  BasicBlock * entry = &(func->getEntryBlock());
  runOnBB(entry, scalarAllocas, SSAPointers, visited); 
    	   
  replaceCallOperands();
  replaceCallInsts();
  return true;
}   
  

char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);


