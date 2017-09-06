#include "llvm/Pass.h"
#include "llvm/Analysis/ConstantFolding.h"
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
#include "InterConstProp.h"

using namespace llvm;
using namespace std;     

/* This routine marks a cloned call context as specialized */
/* TODO-IMP: Mark specialized whenever any specialization occurs */
void ConstantFolding::markSpecialized(BasicBlock * BB) {
  Function * func = BB->getParent();  // Get containing function
  if(specializedCalls.find(func) != specializedCalls.end()){ // If function is a cloned function
    SpecializedCall * call = specializedCalls[func];
    call->used = true;  // Marking the cloned call as specialized - replaces original call
  }  
}

void ConstantFolding::processAllocaInst(AllocaInst * allocaInst) {
  Instruction * I = allocaInst;
  Type * allocatedType = allocaInst->getAllocatedType();
  allocate(allocatedType, I);
}

void ConstantFolding::processMallocInst(unsigned totalSize, Instruction* I) {
  assert(isa<PointerType>(I->getType()) && 
    "malloc called for non pointer Instruction");
  Type* baseType = I->getType()->getContainedType(0);
  unsigned typeSize = DL->getTypeAllocSize(baseType);
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
  allocate(sptr, I);  
  sptr->basePointer->setBase(true);
}

void ConstantFolding::processBitCastInst(BitCastInst * bitcastInst) {

  Value* from = bitcastInst->getOperand(0);
  ContextInfo * ci = BasicBlockContexts[currBB];
  SSAPointer * sptr = getSSAPointer(from, ci);
  if(!sptr)
    return;
  Type * fromType = from->getType();
  if(isa<PointerType>(fromType) && fromType->getContainedType(0)->isIntegerTy(8)) {
    unsigned totalSize = sptr->basePointer->getAlloca()->getSize() - 
      sptr->position;
    processMallocInst(totalSize, bitcastInst);
  } else {
    sptr->basePointer->setConstant(false);
    InsertUnique(ci->modifiedAllocas, sptr->basePointer->getId());    
  }
}

void ConstantFolding::processMemcpyInst(MemCpyInst * memcpyInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value * bufferPtr = memcpyInst->getOperand(0);
  SSAPointer * sptr = getSSAPointer(bufferPtr, ci);
  if(!sptr) 
    return;
  AggregateAlloca * basePointer = sptr->basePointer;
  int offset = sptr->position;
  ScalarAlloca * alloca = basePointer->getAlloca();
  char * sourceBuffer = (char*) alloca->data;
  sourceBuffer += offset;
  StringRef stringRef;
  if(!getConstantStringInfo(memcpyInst->getOperand(1), stringRef, 0, false)) {
    basePointer->setConstant(false);
    if(basePointer->base())
    InsertUnique(ci->modifiedAllocas, basePointer->getId());    
    return; 
  }
  char* constantString = new char[stringRef.str().size()];
  strcpy(constantString, stringRef.str().c_str());
  int length = strlen(constantString);   
  memcpy(sourceBuffer, constantString, length);
  alloca->fillInit(offset, length, true);
  alloca->setModified(offset, length);
  InsertUnique(ci->modifiedAllocas, basePointer->getId());
}


void ConstantFolding::processStoreInst(StoreInst * storeInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value* storeOp = storeInst->getOperand(0);
  Value * ptr = storeInst->getOperand(1);
  debug(Abubakar) << *storeInst << "\n";
  SSAPointer * sptr = getSSAPointer(ptr, ci);
  if(!sptr) {
    debug(Abubakar) << "storeInst : not found in map\n";
    return;
  }
  AggregateAlloca * basePointer = sptr->basePointer;
  if(basePointer->isNodeTypeOf(ptrType)) {
    SSAPointer * nsptr = getSSAPointer(storeOp, ci);
    if(!nsptr)
      basePointer->setConstant(false);
    else {
      basePointer->setOrInsert(0, nsptr->basePointer); 
      nsptr->basePointer->setBase(false);     
      InsertUnique(ci->modifiedAllocas, nsptr->basePointer->getId());
    }
  } else if(basePointer->isNodeTypeOf(scalarType) ||
   basePointer->isNodeTypeOf(scalarPtrType)) {
    ScalarAlloca * alloca = basePointer->getAlloca();
    int allocaSize = alloca->getSize();    
    if(allocaSize > 1 && !basePointer->isConstant()) {
      debug(Abubakar) << ".. Skipping non constant basePointer string ... \n";
      return;
    }        
    Value * storeOperand = storeInst->getOperand(0);
    int constantValue;
    if(ConstantInt * constOp = dyn_cast<ConstantInt>(storeOperand))
      constantValue = constOp->getZExtValue();
    else {
      debug(Abubakar) << "--- Marking basePointer as non-const \n";
      basePointer->setConstant(false);
      InsertUnique(ci->modifiedAllocas, basePointer->getId());
      return;
    }
    int offset = sptr->position;
    alloca->storeConstVal(constantValue, offset);
    alloca->setInit(offset, true);
    alloca->setModified(offset, 1);
    if(alloca->getSize() == 1)
      basePointer->setConstant(true);
  }
  InsertUnique(ci->modifiedAllocas, basePointer->getId());
}

void ConstantFolding::processLoadInst(LoadInst * loadInst) {

  ContextInfo * ci = BasicBlockContexts[currBB];
  Value * ptr = loadInst->getOperand(0);
  // Search for the pointer in map of constant pointers - pointers with constant offsets
  SSAPointer * sptr = getSSAPointer(ptr, ci);
  if(!sptr) {
    debug(Abubakar) << "loadInst : not found in map\n";
    return;
  }     
  AggregateAlloca * basePointer = sptr->basePointer;
  if(!basePointer->isConstant()) {
    debug(Abubakar) << ".. Skipping non constant alloca string ... \n";
    return;
  }
  if(basePointer->isNodeTypeOf(scalarPtrType) && isa<PointerType>(loadInst->getType()))
      ci->SSAPointers[loadInst] = new SSAPointer(basePointer);
  else if(basePointer->isNodeTypeOf(ptrType)) {
    if(basePointer->isNodeTypeOf(ptrType) && basePointer->isNullPointer()) {
      assert(isa<PointerType>(loadInst->getType()) && 
        "loadInst : NodeType ptrType and load inst not pointerType");
      PointerType * loadedType = dyn_cast<PointerType>(loadInst->getType());
      ConstantPointerNull * nptr = ConstantPointerNull::get(loadedType);
      loadInst->replaceAllUsesWith(nptr);
    } else
      ci->SSAPointers[loadInst] = new SSAPointer(basePointer->getContained(0));
  } else if(basePointer->isNodeTypeOf(scalarType) || 
      basePointer->isNodeTypeOf(scalarPtrType)) {
    ScalarAlloca * alloca = basePointer->getAlloca();     
    int offset = sptr->position; 
    if(!alloca->getInit(offset)) {
      debug(Abubakar) << ".. LoadInst : value not initialized ... \n";
      return;    
    }
    loadInst->replaceAllUsesWith(alloca->createConstVal(offset));
  }
}

void ConstantFolding::processGEPInst(GetElementPtrInst * GEPInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value * ptr = GEPInst->getOperand(0);
  SSAPointer * sptr = getSSAPointer(ptr, ci);
  if(!sptr)
    return;
  AggregateAlloca * basePointer = sptr->basePointer;
  Value * indexValue;
  vector<unsigned> indices;
  for(auto index = GEPInst->idx_begin(), end = GEPInst->idx_end(); index != end; index++){
    indexValue = *index;            
    if(ConstantInt *Idx = dyn_cast<ConstantInt>(indexValue)){
      indices.push_back(Idx->getZExtValue());
    }
    else {
      basePointer->setConstant(false);
      InsertUnique(ci->modifiedAllocas, basePointer->getId());
      return;
    }
  } 

  if(basePointer->isNodeTypeOf(scalarType) || basePointer->isNodeTypeOf(scalarPtrType))
    handleBaseDataTypeGEP(indices, sptr, GEPInst, ci->SSAPointers);
  else {
    if(!basePointer->isConstant())
      return;

    if(indices.size() == 1)
      basePointer = basePointer->getContained(indices[0]);
    
    if(indices.size() >= 2 && basePointer->isNodeTypeOf(ptrType))
      basePointer = basePointer->getContained(indices[0]);
    
    for(unsigned i = 1; i < indices.size(); i++) {
      if(basePointer->isNodeTypeOf(scalarType) || 
        basePointer->isNodeTypeOf(scalarPtrType)) {
        std::vector<unsigned> split(indices.begin() + i, indices.end());  
        handleBaseDataTypeGEP(split, basePointer, GEPInst, ci->SSAPointers);
        return;
      }
      basePointer = basePointer->getContained(indices[i]);
    }
    ci->SSAPointers[GEPInst] = new SSAPointer(basePointer);
  }
}

void ConstantFolding::processCallInst(CallInst * callInst) {

  ContextInfo * ci = BasicBlockContexts[currBB];
  Instruction * I = callInst; 
  Function * calledFunction = callInst->getCalledFunction();  
  // Indirect function calls need special handling
  if(calledFunction == NULL) {
    handleIndirectCall(callInst, ci);
    ci->inst++;
    return;
  }   
  /* specialize for functions defined in string.h e.g strcmp, strchr */
  else if(isStringFunction(calledFunction)) {

    if(callInst->use_empty()){
      ci->inst++;
      return; // Skip simplifying functions with unused results
    }
   
    GetElementPtrInst * firstGEPPtr; 
    int specIndex = 0;

    for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
      Value * pointerArg = callInst->getArgOperand(index);
      SSAPointer * sptr = getSSAPointer(pointerArg, ci);
      if(!sptr)
        continue;
      AggregateAlloca * basePointer = sptr->basePointer;
      if(!basePointer->isConstant())
        continue;
      ScalarAlloca * alloca = basePointer->getAlloca();

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
            
      if(specIndex == 0) {
        vector<CallOperand*> operands;
        replaceOperands[callInst] = operands;       
      }

      vector<CallOperand*> * operands = &replaceOperands[callInst];
      // The GEP will replace the original argument
      CallOperand * callOperand = new CallOperand; 
      callOperand->index = index;
      callOperand->newOperand = stringPtr; 
      operands->push_back(callOperand);

      if(specIndex == 0) {
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
      	ci->inst = BasicBlock::iterator(firstGEPPtr);
      	debug(Hashim) << "Replaced uses of = " << *callInst << "\n";
      	BasicBlock * BB = I->getParent();
      	markSpecialized(BB);  // Mark the function as specialized - replaces original function
        return; // already set "inst" to the next instruction
      }
    }

    /* optimize functions that are not in string.h */
    if(isSpecializable(calledFunction)) {
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

    ci->inst++;
    return;  
  } else if(calledFunction->getName().str() == "malloc") {
    ConstantInt* sizeVal = dyn_cast<ConstantInt>(callInst->getArgOperand(0));
    if(!sizeVal) {
      ci->inst++;
      return;       
    }
    int totalSize = sizeVal->getZExtValue();
    processMallocInst(totalSize, callInst);
  }  
  else if(!calledFunction->isDeclaration()) {

    if(!satisfyConds(calledFunction)) {
      markArgsAsNonConst(callInst, ci);
      ci->inst++;
      return;
    }

    AggregateAlloca * returnVal = NULL;
    Function * toRun = NULL; 
    ContextInfo * nci = new ContextInfo(true);
    if(FuncInfoMap[calledFunction]->usesGlobals) { 
      toRun = addClonedFunction(callInst, calledFunction);
      copyGlobals(ci, nci);
    } else if(AnnotationList.find(calledFunction) != AnnotationList.end()) {
      toRun = addClonedFunction(callInst, calledFunction);
    } else if(!calledFunction->arg_size() && 
      !calledFunction->getReturnType()->isVoidTy()) {
      if(FuncInfoMap[calledFunction]->visited) 
        returnVal = FuncInfoMap[calledFunction]->returnVal;
      else
        toRun = calledFunction; 
    } 

    map<AggregateAlloca *, bool> tracked;
    vector<pair<unsigned, Constant *> > constArgs;
    unsigned index = 0;
    for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd;
        arg++, index++) {
      Value * pointerArg = callInst->getOperand(index);

      if(isa<ConstantInt>(pointerArg) || isa<ConstantPointerNull>(pointerArg) ||
        isa<ConstantFP>(pointerArg))        
        constArgs.push_back(make_pair(index, dyn_cast<Constant>(pointerArg)));

      SSAPointer * sptr = getSSAPointer(pointerArg, ci);
      if(!sptr)
        continue;
      if(!toRun)
        toRun = addClonedFunction(callInst, calledFunction);
      Value * pointerVal = getArg(toRun, index);
      SSAPointer * nsptr = new SSAPointer(sptr);
      nci->SSAPointers[pointerVal] = nsptr; 
      nci->InstOrder.push_back(pointerVal);
      InsertUnique(nci->AggregateAllocas, nsptr->basePointer);
      updateMap(nci->idmap, nsptr->basePointer);

      tracked[nsptr->basePointer] = nsptr->basePointer->base();
      nsptr->basePointer->setBase(true);
    }
    if(toRun) {
      replaceConstArgs(toRun, constArgs);
      returnVal = runOnFunction(toRun, calledFunction, nci, tracked);
    } else
      delete nci;
    if(returnVal) {
      AggregateAlloca * aa = returnVal->createClone();
      allocate(aa, callInst);       
    }    
  }
  //IMP: The following 'default' cause finds and marks any side effects of external calls
  else {
    // FIXIT: The call should have a clear purpose
    if(hasNoSideEffects(callInst)) { 
      ci->inst++;
      return;
    }
    /*task 1*/
    // Code moved to function defined in utils.cpp
    if(calledFunction->isDeclaration())
      markArgsAsNonConst(callInst, ci);
  }
  ci->inst++;
}

void ConstantFolding::tryFolding(Instruction * I) {
  Constant * constVal = ConstantFoldInstruction(I, *DL, TLI);
  if(constVal)
    I->replaceAllUsesWith(constVal);
}

void ConstantFolding::processTermInst(TerminatorInst * termInst) {
  if(BasicBlock * single = foldToSingleSucc(termInst)) {
    markSuccessorsAsVisited(termInst, single);
    visitBB(single);
    return;
  }
  for(unsigned int index = 0; index < termInst->getNumSuccessors(); index++) {
    BasicBlock * successor = termInst->getSuccessor(index);
    visitBB(successor);
  } 
}

void ConstantFolding::processReturnInst(ReturnInst * returnInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value * ptr = returnInst->getReturnValue();
  if(!ptr)
    return;    
  SSAPointer * sptr = getSSAPointer(ptr, ci);
  if(!sptr)
    return;
  if(FuncInfoMap[currBB->getParent()]->returnVal)
    FuncInfoMap[currBB->getParent()]->returnVal->
        checkConsistencyWith(sptr->basePointer);
  else 
    FuncInfoMap[currBB->getParent()]->returnVal = sptr->basePointer->createClone();
}