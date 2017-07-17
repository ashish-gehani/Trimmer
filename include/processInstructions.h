

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




void ConstantFolding::processAllocaInst(AllocaInst * allocaInst, ValMemAllocaMap & MemAllocas, 
                       ValMemPointerMap & MemPointers, BBboolMap & visited,
                       BasicBlock::iterator & inst){

  Instruction * I = &(*inst);
  Type * allocatedType = allocaInst->getAllocatedType();
  // Only considering allocas of char arrays e.g char buffer[100]       
  if(allocatedType->isArrayTy() || isa<StructType>(allocatedType)) {
    MemPointer* mnode = createMemPointer(allocatedType);
    MemPointers[I] = mnode;
  } else
    if(debugPrint) errs()<<"note: Unsupported alloca type "<<*allocatedType<<"\n";

  inst++; // Point to next instruction in BB
}



void ConstantFolding::processMemcpyInst(MemCpyInst * memcpyInst, ValMemAllocaMap & MemAllocas, 
                       ValMemPointerMap & MemPointers, BBboolMap & visited,
                       BasicBlock::iterator & inst){

  if(debugPrint) errs()<<"MemCpy Inst "<<*memcpyInst<<"\n"; 	
  Value * bufferPtr = memcpyInst->getOperand(0);
  MemPointer * basePointer;
  if(MemPointers.find(bufferPtr) == MemPointers.end()){
    inst++;
    return;
  }
  else
    basePointer = MemPointers[bufferPtr];
  int offset = basePointer->position;
  char * sourceBuffer = (char*) basePointer->alloca->data;
  sourceBuffer += offset;
  StringRef stringRef;
          
  if(!getConstantStringInfo(memcpyInst->getOperand(1), stringRef, 0, false)){
    //-- if(debugPrint) errs()<<"non-constant string operand to memcpy - skipping ...";
    inst++;
    return; 
  }
  const char * constantString = stringRef.str().c_str();
  int length = strlen(constantString);   
  memcpy(sourceBuffer, constantString, length + 1);
  fill(basePointer->alloca->initialized + offset, basePointer->alloca->initialized + length, true);
  basePointer->alloca->constant = true; // String is now constant          
  if(debugPrint) errs()<<"constantString = "<<constantString<<"\n";

  inst++; // Point to next instruction in BB
}


void ConstantFolding::processStoreInst(StoreInst * storeInst, ValMemAllocaMap & MemAllocas, 
                       ValMemPointerMap & MemPointers, BBboolMap & visited,
                       BasicBlock::iterator & inst) {


  Value * ptr = storeInst->getOperand(1);
  Type * operandType = storeInst->getOperand(0)->getType();
  if(operandType->getNumContainedTypes()) {
    inst++;	    
    return;
  }
  MemPointer * basePointer;
  // Search for the pointer in map of constant pointers - pointers with constant offsets
  if(MemPointers.find(ptr) == MemPointers.end()) {
    inst++;
    return;
  }
  else
    basePointer = MemPointers[ptr];
  if(!basePointer->alloca->constant){
    if(debugPrint) errs()<<".. Skipping non constant alloca string ... \n";
    inst++;
    return;
  }        
  Value * storeOperand = storeInst->getOperand(0);
  int constantValue;
  if(ConstantInt * constOp = dyn_cast<ConstantInt>(storeOperand)){
    constantValue = constOp->getZExtValue();
  } else {
    if(debugPrint) errs()<<"--- Marking alloca as non-const \n";
    basePointer->alloca->constant = false;
    inst++;
    return;
  }

  unsigned storeVal = (unsigned) constantValue;
  if(storeVal == '\0'){
    if(debugPrint) errs()<<"NULL CHARACTER \n";
  }
  unsigned * data = (unsigned*) basePointer->alloca->data;
  int offset = basePointer->position;
  // Storing constant character at constant offset
  data[offset] = storeVal;
  basePointer->alloca->initialized[offset] = true;
  if(debugPrint) errs()<<"*** data = "<<data[offset]<<" offset = "<<offset<<"\n";

  inst++; // Point to next instruction in BB 
}

void ConstantFolding::processLoadInst(LoadInst * loadInst, ValMemAllocaMap & MemAllocas, 
              ValMemPointerMap & MemPointers, BBboolMap & visited, 
              BasicBlock::iterator & inst) {

  Value * ptr = loadInst->getOperand(0);
  Type * operandType = loadInst->getType();
  if(operandType->getNumContainedTypes()) {
    inst++;     
    return;
  }
  MemPointer * basePointer;
  // Search for the pointer in map of constant pointers - pointers with constant offsets
  if(MemPointers.find(ptr) == MemPointers.end()) {
    inst++;
    return;
  }
  else
    basePointer = MemPointers[ptr];


  if(!basePointer->alloca->constant){
    if(debugPrint) errs()<<".. Skipping non constant alloca string ... \n";
    inst++;
    return;
  }        
  int offset = basePointer->position; 
  if(!basePointer->alloca->initialized[offset]) {
    if(debugPrint) errs()<<".. LoadInst : value not initialized ... \n";
    inst++;
    return;    
  }
  loadInst->replaceAllUsesWith(CreateConstVal(basePointer, offset));

  inst++; // Point to next instruction in BB 
}

void ConstantFolding::processGEPInst(GetElementPtrInst * GEPInst, ValMemAllocaMap & MemAllocas, 
		    ValMemPointerMap & MemPointers, BBboolMap & visited,
		    BasicBlock::iterator & inst){

  Instruction * I = &(*inst);
  Value * ptr = GEPInst->getOperand(0);
  MemPointer * basePointer;
  if(MemPointers.find(ptr) == MemPointers.end()){
    inst++; 
    return;
  }
  else
    basePointer = MemPointers[ptr];
  /*string-struct-change*/
  // TODO: more comprehensive test for '0' indices into string      

  if(basePointer->alloca && !basePointer->alloca->constant) {
    //-- if(debugPrint) errs()<<"..... Skipping non-constant string ... "<<*GEPInst<<"\n";
    inst++;
    return;              
  }
  Value * indexValue;
  bool nonConstantIndices = false;

  vector<unsigned> indices;
  for(auto index = GEPInst->idx_begin(), end = GEPInst->idx_end(); index != end; index++){
            
    indexValue = *index;            
    if(ConstantInt *Idx = dyn_cast<ConstantInt>(indexValue)){
      indices.push_back(Idx->getZExtValue());     
    }
    else {
      nonConstantIndices = true;
      break;
    }
  } 
  if(nonConstantIndices){
    if(!basePointer->alloca)
      errs() << "case not handled --- non constant indices and NULL alloca\n";
    basePointer->alloca->constant = false;
    inst++;
    return;
  }

  if(basePointer->ntype == baseDataType)
    handleBaseDataTypeGEP(indices, basePointer, I, MemPointers);
  else if(basePointer->ntype == structType) {
      MemPointer* mnode = basePointer;
      for(unsigned i = 1; i < indices.size(); i++) {
        mnode = mnode->contained[indices[i]];        
        if(mnode->ntype == baseDataType) { // ArrayType
          vector<unsigned> bdVec(indices.begin() + i + 1, indices.end());
          handleBaseDataTypeGEP(bdVec, mnode, I, MemPointers);          
          inst++;
          return; 
        }
      }
      MemPointers[I] = deepCopy(mnode);
    }
  inst++; // Point to next instruction in BB
}


void ConstantFolding::processCallInst(CallInst * callInst, ValMemAllocaMap & MemAllocas, 
		     ValMemPointerMap & MemPointers, BBboolMap & visited,
		     BasicBlock::iterator & inst){
  Instruction * I = &(*inst); 
  Function * calledFunction = callInst->getCalledFunction();  
  // Indirect function calls need special handling
  if(calledFunction == NULL){
    handleIndirectCall(callInst, MemPointers);
    inst++;
    return;
  }         

  /* specialize for functions defined in string.h e.g strcmp, strchr */
  else if(isStringFunction(calledFunction)) {

    if(callInst->use_empty()){
      inst++;
      return; // Skip simplifying functions with unused results
    }
   
    if(debugPrint) errs()<<"\n **** Specializing String function =  "<<calledFunction->getName()<<"\n";
    // IMP: This pointer has special significance
    // The next instruction must point to the first GEP replaced inst 
    // necessary to ensure that GEPs are processed for specialization 
    GetElementPtrInst * firstGEPPtr; 
    int specIndex = 0;

    // FIXIT: Specializing the call per argument - INCORRECT/BUG
    for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
      Value * pointerArg = callInst->getArgOperand(index);
      MemPointer * basePointer;

      if(MemPointers.find(pointerArg) == MemPointers.end()){ 
      	//-- if(debugPrint) errs()<<"!pointer not found = "<<*pointerArg <<"\n"; 
        continue;
      } 
      else
	      basePointer = MemPointers[pointerArg];

      if(basePointer->alloca->constant == false){
      	continue;
      }
      char * baseStringData = (char*) basePointer->alloca->data;
      int offset = basePointer->position;
	      
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
      if(With == NULL && debugPrint) errs()<<"NULL VALUE \n\n";
      if(debugPrint) errs()<<"Value to replace = "<<*With<<"\n";
      /**/
      // if(allocatedType->isArrayTy() && allocatedType->getContainedType(0)->isIntegerTy(8)) {

      // }      
      /**/
      if(!callInst->use_empty()) {             
      	callInst->replaceAllUsesWith(With);              
      	inst = BasicBlock::iterator(firstGEPPtr);
      	if(debugPrint) errs()<<"Replaced uses of = "<<*callInst<<"\n";
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
      	  if(debugPrint) errs()<<"constant string = "<<constantString<<"\n";
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
  }  
  /* NEW: Propagating constants interprocedurally */ 
  else if(!isStringFunction(calledFunction) && !calledFunction->isDeclaration()) {

    /*task1*/
    // If the function does not satisfy any of the three conditions, mark all arguments
    // which were previously bieng tracked as non constant
    // It is the same code which was used for isDeclaration                     
    if(!satisfyConds(calledFunction)) {
      markArgsAsNonConst(callInst, MemPointers);
      inst++;
      return;
    }

    if(debugPrint) errs()<<"---- Traversing function arguments ---- \n\n";       
    int index = 0;
    BasicBlock * successor = NULL;
    bool clonedFlag = false;
    Function * clonedFunc = NULL;    
    for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd;
        arg++, index++) {

      //FIXIT: make type checks more general	
      if(!arg->getType()->isPointerTy() && !isa<StructType>(arg->getType())){
        // if(debugPrint) 
        errs()<<"!note: not supported "<<*arg<<"\n";                
      	continue;
      }
  
      Value * pointerArg = callInst->getOperand(index);
      MemPointer * basePointer;
      if(MemPointers.find(pointerArg) == MemPointers.end()){ 
	      continue;
      } 
      else
	      basePointer = MemPointers[pointerArg];
                 
      // TODO-FIXIT: Only clone if function is called only ONCE 
      // Cloning routines before attempting constant propagation
      if(!clonedFlag) { //IMP: prevent cloning function once per argument
      	ClonedCodeInfo info;
      	ValueToValueMapTy vmap;
        string name = calledFunction->getName().str();
      	if(debugPrint) errs()<<"---- cloning function = "<< name <<"\n";
      	clonedFunc = llvm::CloneFunction(calledFunction, vmap, true, &info);
        clonedFunc->setName(StringRef(name + "_clone")); // FIXIT: Name appropriately
      	calledFunction->getParent()->getFunctionList().push_back(clonedFunc);
                    
      	std::vector<Value*> args(callInst->arg_begin(), callInst->arg_end());
      	CallInst * specCallInst = CallInst::Create(clonedFunc, args);
      	if(debugPrint) errs()<<"newCallSite = "<<*specCallInst<<"\n";
      	SpecializedCall * call = new SpecializedCall;
      	call->origCall = callInst;
      	call->specCall = specCallInst;
      	call->used = false;
      	specializedCalls[clonedFunc] = call; // FIXIT: Re-consider current indexing on cloned function
      	successor = &(clonedFunc->getEntryBlock());     
      	clonedFlag = true; //IMP: prevent cloning function once per argument      
      }
      /*string-struct-change*/
      MemPointer * mnode = deepCopy(basePointer);
      Value * pointerVal = getArg(clonedFunc, index);
      MemPointers[pointerVal] = mnode;        
      if(debugPrint) errs()<<" POINTER VAL = "<<*pointerVal<<"\n";
          //FIXIT: Reconsider the below choices

          // NEW: CANNOT prevent a function from being traversed twice
          // TODO-NEW: Need to restrict RECURSIVE functions - including mutually recursive             
          /*
    	if(visited.find(successor) != visited.end()){
    	continue; // Skip visited basic block 
    	}	                               
    	visited[successor] = true; // Mark basic block as being visited
          */                           
    }
    
    if(clonedFlag)
      runOnBB(successor, MemAllocas, MemPointers, visited);
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
      if(debugPrint) errs()<<"--- Declaration: "<<*calledFunction<<"\n";
      markArgsAsNonConst(callInst, MemPointers);
    }
  }

  inst++; // Point to next instruction
  // End of CallInst
}



void ConstantFolding::processBranchInst(BranchInst * branchInst, ValMemAllocaMap & MemAllocas, 
		     ValMemPointerMap & MemPointers, BBboolMap & visited,
		     BasicBlock::iterator & inst) {

  BasicBlock* BB = branchInst->getParent();
  blockContexts[BB] = MemAllocas;
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
      if(debugPrint) errs()<<"Successor has a single predecessor \n";
      runOnBB(successor, MemAllocas, MemPointers, visited);
    }    
    else {
      if(debugPrint) errs()<<"Block has multiple predecessors \n";
      // Merging contexts
      // TODO: more testing required            
      ValMemAllocaMap MemAllocas2;
      mergeContext(successor, blockContexts, MemAllocas2, MemPointers);
      visited[successor] = true;  //FIXIT: Clear your head on visiting BBs 
      runOnBB(successor, MemAllocas2, MemPointers, visited);            
    } 
  }         

  inst++;
}
