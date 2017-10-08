/* This Pass identifies and annotates program configuration structures */

#include "llvm/Transforms/Scalar.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BlockFrequencyInfoImpl.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/Loads.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/ValueHandle.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionAliasAnalysis.h"
#include "llvm/Analysis/ScalarEvolutionExpander.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include <map>
#include <vector>
#include <fstream>

using namespace llvm;
using namespace std;

#define debugPrint 1


struct Alloca{
  Instruction *allocaInst;  
  Function *parentFunction;
  bool isArgv;
};


struct Annotate : public ModulePass {

  static char ID; 
  
  Annotate(): ModulePass(ID){}

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<AssumptionCacheTracker>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetLibraryInfoWrapperPass>();
  }


  void runOnFunction(Function *F, map<Function*, bool> & visited,
		     map<Value*, Alloca*> pointers, map<Value*, Alloca*> &memoryObjects){

    if(visited.find(F) != visited.end()){
      return; // Visited each function once
    }

    bool loadsArgv = false;
    visited[F] = true;
    for(auto it = F->begin(), end = F->end(); it != end; it++){
      BasicBlock *BB = &*it;

      for (BasicBlock::iterator inst = BB->begin(), ie = BB->end(); inst != ie; ) {
	Instruction * I = &(*inst);
	if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(&*I)){
        
          Alloca *alloca = new Alloca;
          memoryObjects[allocaInst] = alloca;
          pointers[allocaInst] = alloca;
     	}

	if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(&*I)){

	  Value * ptr = GEPInst->getOperand(0);
	  Alloca *baseAlloca;
	  if(pointers.find(ptr) == pointers.end()){
	    inst++; 
	    continue;
	  }
	  else
	    baseAlloca = pointers[ptr];

	  pointers[I] = baseAlloca;       
	}

	else if(LoadInst * loadInst = dyn_cast<LoadInst>(&*I)){

	  Value * ptr = loadInst->getOperand(0);
	  Alloca *baseAlloca;
	  // Search for the pointer in map of constant pointers - pointers with constant offsets
	  if(pointers.find(ptr) == pointers.end()){
	    inst++;
	    continue;
	  }
	  else
	    baseAlloca = pointers[ptr]; 

          // NOTE: Handling pointer loads
          if(ptr->getType()->isPointerTy()){
            pointers[I] = baseAlloca;
	  }	         

          if(baseAlloca->isArgv){
            loadsArgv = true;
            if(debugPrint) errs()<<"LoadInst = "<<*loadInst<<"\n";
	  }
	}

	else if(StoreInst * storeInst = dyn_cast<StoreInst>(&*I)){

	  Value *arg1 = storeInst->getOperand(0);
	  Value *arg2 = storeInst->getOperand(1);     
	  if(pointers.find(arg1) != pointers.end()){
	    Alloca *baseAlloca = pointers[arg1];
	    if(loadsArgv) //NOTE: If there is a load to argv in the same function  
              if(debugPrint) errs()<< baseAlloca->allocaInst<<"\n";  

            // Handling pointer assignments e.g store %ptr, %ptr2
            if(arg1->getType()->isPointerTy()){
              pointers[arg2] = baseAlloca; 
	    }      
	  }
	}

	else if(CallInst * callInst = dyn_cast<CallInst>(&*I)){

	  Function * calledFunction = callInst->getCalledFunction();
	  if(calledFunction->isDeclaration()){
	    inst++;
	    continue;
	  }

          for(int i = 0; i < callInst->getNumArgOperands(); i++){
            Value *argOperand = callInst->getArgOperand(i);
            Alloca *baseAlloca;
	    if(pointers.find(argOperand) != pointers.end()){
	      baseAlloca = pointers[argOperand];
              Value *funcArg = getFunctionArgument(calledFunction, i);
              pointers[funcArg] = baseAlloca;     
	    }  
	  }

          runOnFunction(calledFunction, visited, pointers, memoryObjects);
	}    
      
	else if(BitCastInst * bitcastInst = dyn_cast<BitCastInst>(&*I)){

	  Value * ptr = bitcastInst->getOperand(0);
	  Alloca * baseAlloca;
	  if(pointers.find(ptr) == pointers.end()){
	    inst++;
	    continue;
	  }
	  else
	    baseAlloca = pointers[ptr];

	  pointers[I] = baseAlloca; 
	}

	inst++;
      }
    }
  }


  Value *getFunctionArgument(Function *F, int argIndex){
      
    int index = 0;
    for(auto arg = F->arg_begin(); arg != F->arg_end(); arg++, index++){
      if(index == argIndex)
        return &*arg; 
    }
  }
  
  bool runOnModule(Module & M) override {
    
    map<Value*, Alloca*> memoryObjects;
    map<Value*, Alloca*> pointers;
    map<Function*, bool> visited;

    Function *programEntry = M.getFunction(StringRef("main"));
    Value *argv = getFunctionArgument(programEntry, 1);

    // Constructing an allocation for *argv*
    Alloca *alloca = new Alloca;
    alloca->allocaInst = NULL;
    alloca->parentFunction = programEntry;
    alloca->isArgv = true;
    pointers[argv] = alloca;
    memoryObjects[argv] = alloca;    

    runOnFunction(programEntry, visited, pointers, memoryObjects);
    
    return true;
  } 
};


char Annotate::ID = 0;
static RegisterPass<Annotate> X("annotate", "Annotating configuration structures",
                                         false, false);

