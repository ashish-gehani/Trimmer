

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
#include "InterConstProp.h"

using namespace llvm;
using namespace std;     

/* This routine marks a cloned call context as specialized */
/* TODO-IMP: Mark speciliazed whenever any specialization occurs */
void ConstantFolding::markSpecialized(BasicBlock * BB){

  Function * func = BB->getParent();  // Get containing function
  if(specializedCalls.find(func) != specializedCalls.end()){ // If function is a cloned function
    SpecializedCall * call = specializedCalls[func];
    call->used = true;  // Marking the cloned call as specialized - replaces original call
  }  
}

void ConstantFolding::processAllocaInst(AllocaInst * allocaInst, ValScalarAllocaMap & ScalarAllocas, 
                       ValSSAPointerMap & SSAPointers, BasicBlockBoolMap & visited,
                       BasicBlock::iterator & inst){

  Instruction * I = &(*inst);
  Type * allocatedType = allocaInst->getAllocatedType();
  // Only considering allocas of char arrays e.g char buffer[100]       
  if(allocatedType->getNumContainedTypes())
    SSAPointers[I] = new SSAPointer(allocatedType);
  else
    errs() << "note: Unsupported alloca type " << *allocatedType << "\n";

  inst++; // Point to next instruction in BB
}

void ConstantFolding::processMallocInst(CallInst * mallocInst, Instruction* I, 
                       ValSSAPointerMap & SSAPointers) {

  assert(isa<PointerType>(I->getType()) && 
    "malloc called for non pointer Instruction");
  
  ConstantInt* sizeVal = dyn_cast<ConstantInt>(mallocInst->getArgOperand(0));
  
  if(!sizeVal)
    return;

  int totalSize = sizeVal->getZExtValue();
  
  Type* baseType = I->getType()->getContainedType(0);
  unsigned typeSize = getSizeOf(baseType);
  unsigned numel = totalSize/typeSize;
  SSAPointer* sptr;
  if(baseType->getNumContainedTypes()) {
    sptr = new SSAPointer(I->getType());
    for(unsigned i = 0; i < numel; i++)
      sptr->basePointer->setOrInsert(i, new AggregateAlloca(baseType));
  } else {
    Type * arType = ArrayType::get(baseType, numel);
    sptr = new SSAPointer(arType); 
    sptr->basePointer->Ntype = scalarPtrType;
  }   
  SSAPointers[I] = sptr;     
}

void ConstantFolding::processBitCastInst(BitCastInst * bitcastInst, 
                        ValScalarAllocaMap & ScalarAllocas, ValSSAPointerMap & SSAPointers, 
                       BasicBlockBoolMap & visited, BasicBlock::iterator & inst) {

  Value* first = bitcastInst->getOperand(0);
  if(Instruction* firstI = dyn_cast<Instruction>(first))
    if(CallInst* ci = dyn_cast<CallInst>(firstI)) 
      if(ci->getCalledFunction()->getName().str() == "malloc") {
        processMallocInst(ci, bitcastInst, SSAPointers);
        inst++;
        return;
      }
}

void ConstantFolding::processMemcpyInst(MemCpyInst * memcpyInst, ValScalarAllocaMap & ScalarAllocas, 
                       ValSSAPointerMap & SSAPointers, BasicBlockBoolMap & visited,
                       BasicBlock::iterator & inst) {

  Value * bufferPtr = memcpyInst->getOperand(0);
  SSAPointer * sptr;
  if(SSAPointers.find(bufferPtr) == SSAPointers.end()){
    inst++;
    return;
  }
  else
    sptr = SSAPointers[bufferPtr];
  AggregateAlloca * basePointer = sptr->basePointer;
  int offset = sptr->position;
  ScalarAlloca * alloca = basePointer->getAlloca();

  char * sourceBuffer = (char*) alloca->data;
  sourceBuffer += offset;
  StringRef stringRef;
          
  if(!getConstantStringInfo(memcpyInst->getOperand(1), stringRef, 0, false)){
    inst++;
    return; 
  }

  char* constantString = new char[stringRef.str().size()];
  strcpy(constantString, stringRef.str().c_str());
  int length = strlen(constantString);   
  memcpy(sourceBuffer, constantString, length);
  alloca->fillInit(offset, length, true);

  //only set the alloca as constant if the memcpy is over the entire length
  if(offset == 0 && length == alloca->getSize())
    alloca->setConstant(true);          
  debug(Hashim)<< "constantString = " << constantString << "\n";

  inst++; // Point to next instruction in BB
}


void ConstantFolding::processStoreInst(StoreInst * storeInst, ValScalarAllocaMap & ScalarAllocas, 
                       ValSSAPointerMap & SSAPointers, BasicBlockBoolMap & visited,
                       BasicBlock::iterator & inst) {
  Value* storeOp = storeInst->getOperand(0);
  Value * ptr = storeInst->getOperand(1);
  SSAPointer * sptr;
  // Search for the pointer in map of constant pointers - pointers with constant offsets
  if(SSAPointers.find(ptr) == SSAPointers.end()) {
    debug(Abubakar) << "storeInst : not found in map\n";
    inst++;
    return;
  }
  else
    sptr = SSAPointers[ptr];
  AggregateAlloca * basePointer = sptr->basePointer;
  if(basePointer->isNodeTypeOf(ptrType)) {
    if(SSAPointers.find(ptr) != SSAPointers.end()) {
      *basePointer = *SSAPointers[storeOp]->basePointer;
    }
  } else if(basePointer->isNodeTypeOf(scalarType) || basePointer->isNodeTypeOf(scalarPtrType)) {
    ScalarAlloca * alloca = basePointer->getAlloca();
    if(!alloca->isConstant()) {
      debug(Abubakar) << ".. Skipping non constant alloca string ... \n";
      inst++;
      return;
    }        
    Value * storeOperand = storeInst->getOperand(0);
    int constantValue;
    if(ConstantInt * constOp = dyn_cast<ConstantInt>(storeOperand)){
      constantValue = constOp->getZExtValue();
    } else {
      debug(Abubakar) << "--- Marking alloca as non-const \n";
      alloca->setConstant(false);
      inst++;
      return;
    }
    int offset = sptr->position;
    alloca->storeConstVal(constantValue, offset);
    alloca->setInit(offset, true);
  }
  inst++; // Point to next instruction in BB 
}

void ConstantFolding::processLoadInst(LoadInst * loadInst, ValScalarAllocaMap & ScalarAllocas, 
              ValSSAPointerMap & SSAPointers, BasicBlockBoolMap & visited, 
              BasicBlock::iterator & inst) {
  Value * ptr = loadInst->getOperand(0);
  SSAPointer * sptr;
  // Search for the pointer in map of constant pointers - pointers with constant offsets
  if(SSAPointers.find(ptr) == SSAPointers.end()) {
    debug(Abubakar) << "loadInst : not found in map\n";
    inst++;
    return;
  }
  else
    sptr = SSAPointers[ptr];
  AggregateAlloca * basePointer = sptr->basePointer;
  if(basePointer->isNodeTypeOf(scalarPtrType) && isa<PointerType>(loadInst->getType()))
      SSAPointers[loadInst] = new SSAPointer(basePointer);
  else if(basePointer->isNodeTypeOf(ptrType)) {
    if(basePointer->isNodeTypeOf(ptrType) && basePointer->isNullPointer()) {
      assert(isa<PointerType>(loadInst->getType()) && 
        "loadInst : NodeType ptrType and loadinst not pointerType");
      PointerType * loadedType = dyn_cast<PointerType>(loadInst->getType());
      ConstantPointerNull * nptr = ConstantPointerNull::get(loadedType);
      loadInst->replaceAllUsesWith(nptr);
      debug(Abubakar) << "null pointer\n";
    } else
      SSAPointers[loadInst] = new SSAPointer(basePointer->getContained(0));
  } else if(basePointer->isNodeTypeOf(scalarType) || basePointer->isNodeTypeOf(scalarPtrType)) {
    ScalarAlloca * alloca = basePointer->getAlloca();
    if(!alloca->isConstant()){
      debug(Abubakar) << ".. Skipping non constant alloca string ... \n";
      inst++;
      return;
    }        
    int offset = sptr->position; 
    if(!alloca->getInit(offset)) {
      debug(Abubakar) << ".. LoadInst : value not initialized ... \n";
      inst++;
      return;    
    }
    loadInst->replaceAllUsesWith(alloca->createConstVal(offset));
  }
  inst++; // Point to next instruction in BB 
}

void ConstantFolding::processGEPInst(GetElementPtrInst * GEPInst, ValScalarAllocaMap & ScalarAllocas, 
		    ValSSAPointerMap & SSAPointers, BasicBlockBoolMap & visited,
		    BasicBlock::iterator & inst){

   Instruction * I = &(*inst);
  Value * ptr = GEPInst->getOperand(0);
  SSAPointer * sptr;
  if(SSAPointers.find(ptr) == SSAPointers.end()) {
    debug(Abubakar) << "gepInst : not found in map\n";
    inst++; 
    return;
  }
  else
    sptr = SSAPointers[ptr];
  AggregateAlloca * basePointer = sptr->basePointer;
  ScalarAlloca * alloca = basePointer->getAlloca();
  /*string-struct-change*/
  // TODO: more comprehensive test for '0' indices into string      
  if(alloca && !alloca->isConstant()) {
    inst++;
    return;              
  }
  Value * indexValue;
  vector<unsigned> indices;
  for(auto index = GEPInst->idx_begin(), end = GEPInst->idx_end(); index != end; index++){
            
    indexValue = *index;            
    if(ConstantInt *Idx = dyn_cast<ConstantInt>(indexValue)){
      indices.push_back(Idx->getZExtValue());
    }
    else {
      if(alloca)
        alloca->setConstant(false);
      inst++;
      return;
    }
  } 
  if(basePointer->isNodeTypeOf(scalarType) || basePointer->isNodeTypeOf(scalarPtrType))
    handleBaseDataTypeGEP(indices, sptr, I, SSAPointers);
  else {
      if(basePointer->isNodeTypeOf(ptrType) && indices.size() == 2)
        basePointer = basePointer->getContained(indices[0]);
      SSAPointers[I] = new SSAPointer(basePointer->getContained(indices[indices.size() - 1]));      
  }
  inst++; // Point to next instruction in BB
}


void ConstantFolding::processCallInst(CallInst * callInst, ValScalarAllocaMap & ScalarAllocas, 
		     ValSSAPointerMap & SSAPointers, BasicBlockBoolMap & visited,
		     BasicBlock::iterator & inst) {
  Instruction * I = &(*inst); 
  Function * calledFunction = callInst->getCalledFunction();  
  // Indirect function calls need special handling
  if(calledFunction == NULL){
    handleIndirectCall(callInst, SSAPointers);
    inst++;
    return;
  }   
  /* specialize for functions defined in string.h e.g strcmp, strchr */
  else if(isStringFunction(calledFunction)) {

    if(callInst->use_empty()){
      inst++;
      return; // Skip simplifying functions with unused results
    }
   
    debug(Hashim) << "\n **** Specializing String function =  " << calledFunction->getName() << "\n";
    // IMP: This pointer has special significance
    // The next instruction must point to the first GEP replaced inst 
    // necessary to ensure that GEPs are processed for specialization 
    GetElementPtrInst * firstGEPPtr; 
    int specIndex = 0;

    // FIXIT: Specializing the call per argument - INCORRECT/BUG
    for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
      Value * pointerArg = callInst->getArgOperand(index);
      SSAPointer * sptr;

      if(SSAPointers.find(pointerArg) == SSAPointers.end()){ 
        continue;
      } 
      else
	      sptr = SSAPointers[pointerArg];
      AggregateAlloca * basePointer = sptr->basePointer;
      ScalarAlloca * alloca = basePointer->getAlloca();
      if(!alloca->isConstant()){
      	continue;
      }
      char * baseStringData = (char*) alloca->data;
      int offset = sptr->position;
	      
      char * newStr = baseStringData + offset;
      IntegerType * intTy = IntegerType::get(M->getContext(), 64);
      ConstantInt * index1 = ConstantInt::get(intTy, 0);
      vector<Value *> indxList;
      indxList.push_back(index1); 
      indxList.push_back(index1);
      Constant * stringConstant = ConstantDataArray::getString(M->getContext(), 
							       StringRef(newStr), true);
      GlobalVariable * globalReadString = new GlobalVariable(*M, stringConstant->getType(), true,
							     GlobalValue::ExternalLinkage, 
							     stringConstant, "");

      GetElementPtrInst * stringPtr = GetElementPtrInst::Create(NULL, globalReadString, 
								indxList, Twine(""), callInst);
            
      if(specIndex == 0){
        vector<CallOperand*> operands;
        replaceOperands[callInst] = operands;       
      }

      vector<CallOperand*> * operands = &replaceOperands[callInst];
      // The GEP will replace the original argument
      CallOperand * callOperand = new CallOperand; 
      callOperand->index = index;
      callOperand->newOperand = stringPtr; 
      operands->push_back(callOperand);

      if(specIndex == 0){
        firstGEPPtr = stringPtr;
        specIndex++;
      }  
    }
    replaceCallOperands();
 
    auto InstCombineRAUW = [this](Instruction *From, Value *With) {
      From->replaceAllUsesWith(With);
    };

    LibCallSimplifier Simplifier(*DL, TLI, InstCombineRAUW);
    if (Value *With = Simplifier.optimizeCall(callInst)) {
      if(With == NULL) debug(Hashim) << "NULL VALUE \n\n";
      debug(Hashim) << "Value to replace = " << *With << "\n";
      if(!callInst->use_empty()) {             
      	callInst->replaceAllUsesWith(With);              
      	inst = BasicBlock::iterator(firstGEPPtr);
      	debug(Hashim) << "Replaced uses of = " << *callInst << "\n";
      	BasicBlock * BB = I->getParent();
      	markSpecialized(BB);  // Mark the function as specialized - replaces original function
        return; // already set "inst" to the next instruction
      }
    }

    /* optimize functions that are not in string.h */
    if(isSpecializable(calledFunction)){
      string functionName = calledFunction->getName();
      /* optimizing atoi calls with constant strings with corresponding constant int */
      if(functionName == "atoi") {             
      	StringRef stringRef;
      	if(getConstantStringInfo(callInst->getOperand(0), stringRef, 0, false)) {
      	  const char * constantString = stringRef.str().c_str();
      	  debug(Hashim) << "constant string = " << constantString << "\n";
      	  int val = atoi(constantString);
      	  IntegerType * int32Ty = IntegerType::get(M->getContext(), 32);
      	  ConstantInt * constVal = ConstantInt::get(int32Ty, val);
      	  callInst->replaceAllUsesWith(constVal);
      	  callInst->eraseFromParent();
      	  BasicBlock* BB = I->getParent();
      	  markSpecialized(BB);  // Mark the function as specialized - replaces original function
      	}
      }            
    }                         

    inst++;
    return;  
  } else if(calledFunction->getName().str() == "malloc") {
    processMallocInst(callInst, callInst, SSAPointers);
  }  
  /* NEW: Propagating constants interprocedurally */ 
  else if(!calledFunction->isDeclaration()) {

    /*task1*/
    // If the function does not satisfy any of the three conditions, mark all arguments
    // which were previously bieng tracked as non constant
    // It is the same code which was used for isDeclaration                     
    if(!satisfyConds(calledFunction)) {
      markArgsAsNonConst(callInst, SSAPointers);
      inst++;
      return;
    }

    debug(Hashim) << "---- Traversing function arguments ---- \n\n";       
    int index = 0;
    BasicBlock * successor = NULL;
    bool clonedFlag = false;
    Function * clonedFunc = NULL;    
    for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd;
        arg++, index++) {

      //FIXIT: make type checks more general	
      if(!arg->getType()->isPointerTy() && !isa<StructType>(arg->getType())){
        errs() << "!note: not supported " << *arg << "\n";                
      	continue;
      }
  
      Value * pointerArg = callInst->getOperand(index);
      SSAPointer * sptr;
      if(SSAPointers.find(pointerArg) == SSAPointers.end())
	      continue;
      else
	      sptr = SSAPointers[pointerArg];
      // TODO-FIXIT: Only clone if function is called only ONCE 
      // Cloning routines before attempting constant propagation
      if(!clonedFlag) { //IMP: prevent cloning function once per argument
      	ClonedCodeInfo info;
      	ValueToValueMapTy vmap;
        string name = calledFunction->getName().str();
      	debug(Hashim) << "---- cloning function = " << name <<"\n";
      	clonedFunc = llvm::CloneFunction(calledFunction, vmap, true, &info);
        clonedFunc->setName(StringRef(name + "_clone")); // FIXIT: Name appropriately
      	calledFunction->getParent()->getFunctionList().push_back(clonedFunc);
                    
      	std::vector<Value*> args(callInst->arg_begin(), callInst->arg_end());
      	CallInst * specCallInst = CallInst::Create(clonedFunc, args);
      	debug(Hashim) << "newCallSite = " << *specCallInst << "\n";
      	SpecializedCall * call = new SpecializedCall;
      	call->origCall = callInst;
      	call->specCall = specCallInst;
      	call->used = false;
      	specializedCalls[clonedFunc] = call; // FIXIT: Re-consider current indexing on cloned function
      	successor = &(clonedFunc->getEntryBlock());     
      	clonedFlag = true; //IMP: prevent cloning function once per argument      
      }
      /*string-struct-change*/
      SSAPointer * nsptr = new SSAPointer(sptr);
      Value * pointerVal = getArg(clonedFunc, index);
      SSAPointers[pointerVal] = nsptr;        
      debug(Hashim) << " POINTER VAL = " << *pointerVal << "\n";
          //FIXIT: Reconsider the below choices

          // NEW: CANNOT prevent a function from being traversed twice
          // TODO-NEW: Need to restrict RECURSIVE functions - including mutually recursive                                       
    }
    
    if(clonedFlag)
      runOnBB(successor, ScalarAllocas, SSAPointers, visited);
  }
  //IMP: The following 'default' cause finds and marks any sideeffects of external calls
  else {

    // FIXIT: The call should have a clear purpose
    if(hasNoSideEffects(callInst)){
      inst++;
      return;
    }
    /*task1*/
    // Code moved to function defined in utils.cpp
    if(calledFunction->isDeclaration()) {
      debug(Hashim) << "--- Declaration: " << *calledFunction << "\n";
      markArgsAsNonConst(callInst, SSAPointers);
    }
  }

  inst++; // Point to next instruction
  // End of CallInst
}



void ConstantFolding::processBranchInst(BranchInst * branchInst, ValScalarAllocaMap & ScalarAllocas, 
		     ValSSAPointerMap & SSAPointers, BasicBlockBoolMap & visited,
		     BasicBlock::iterator & inst) {

  BasicBlock* BB = branchInst->getParent();
  blockContexts[BB] = ScalarAllocas;
  for(unsigned int index = 0; index < branchInst->getNumSuccessors(); index++){

    BasicBlock * successor = branchInst->getSuccessor(index);
    //FIXIT: The check below needs to be strongly reconsidered
    //FIXIT: In case we don't clone every routine, this check breaks the algorithm
    if(visited.find(successor) != visited.end()){
      continue; // Skip visited basic block 
    }
            
    // Traverse in reverse post-order
    if(!predecessorsVisited(successor, blockContexts)){
      continue;
    }          

    // Forward context to successor block if the successor has only a single predecessor & isNotVisited
    if(successor->getUniquePredecessor()) {
      visited[successor] = true; 
      debug(Hashim) << "Successor has a single predecessor \n";
      runOnBB(successor, ScalarAllocas, SSAPointers, visited);
    }    
    else {
      debug(Hashim) << "Block has multiple predecessors \n";
      // Merging contexts
      // TODO: more testing required            
      ValScalarAllocaMap ScalarAllocas2;
      mergeContext(successor, blockContexts, ScalarAllocas2, SSAPointers);
      visited[successor] = true;  //FIXIT: Clear your head on visiting BBs 
      runOnBB(successor, ScalarAllocas2, SSAPointers, visited);            
    } 
  }         
  inst++;
}
