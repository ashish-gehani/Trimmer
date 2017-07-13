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
#include "Types.cpp"

using namespace llvm;
using namespace std;
#define debugPrint 0

bool getConstantStringInfo(const Value *V, StringRef &Str, uint64_t Offset, bool TrimAtNul) {
   
  assert(V);
  // Look through bitcast instructions and geps.
  V = V->stripPointerCasts();

  // If the value is a GEP instruction or constant expression, treat it as an
  // offset.
  if (const GEPOperator *GEP = dyn_cast<GEPOperator>(V)) {
    // Make sure the GEP has exactly three arguments.
    if (GEP->getNumOperands() != 3)
      return false;

    // Make sure the index-ee is a pointer to array of i8.
    PointerType *PT = cast<PointerType>(GEP->getOperand(0)->getType());
    ArrayType *AT = dyn_cast<ArrayType>(PT->getElementType());
    if (!AT || !AT->getElementType()->isIntegerTy(8))
      return false;

    // Check to make sure that the first operand of the GEP is an integer and
    // has value 0 so that we are sure we're indexing into the initializer.
    const ConstantInt *FirstIdx = dyn_cast<ConstantInt>(GEP->getOperand(1));
    if (!FirstIdx || !FirstIdx->isZero())
      return false;

    // If the second index isn't a ConstantInt, then this is a variable index
    // into the array.  If this occurs, we can't say anything meaningful about
    // the string.
    uint64_t StartIdx = 0;
    if (const ConstantInt *CI = dyn_cast<ConstantInt>(GEP->getOperand(2)))
      StartIdx = CI->getZExtValue();
    else
      return false;
    return getConstantStringInfo(GEP->getOperand(0), Str, StartIdx + Offset,
				 TrimAtNul);
  }

  // The GEP instruction, constant or instruction, must reference a global
  // variable that is a constant and is initialized. The referenced constant
  // initializer is the array that we'll use for optimization.
  const GlobalVariable *GV = dyn_cast<GlobalVariable>(V);
  if (!GV || !GV->isConstant() || !GV->hasDefinitiveInitializer())
    return false;

  // Handle the all-zeros case
  if (GV->getInitializer()->isNullValue()) {
    // This is a degenerate case. The initializer is constant zero so the
    // length of the string must be zero.
    Str = "";
    return true;
  }

  // Must be a Constant Array
  const ConstantDataArray *Array =
    dyn_cast<ConstantDataArray>(GV->getInitializer());
  if (!Array || !Array->isString())
    return false;

  // Get the number of elements in the array
  uint64_t NumElts = Array->getType()->getArrayNumElements();

  // Start out with the entire array in the StringRef.
  Str = Array->getAsString();

  if (Offset > NumElts)
    return false;

  // Skip over 'offset' bytes.
  Str = Str.substr(Offset);

  if (TrimAtNul) {
    // Trim off the \0 and anything after it.  If the array is not nul
    // terminated, we just return the whole end of string.  The client may know
    // some other way that the string is length-bound.
    Str = Str.substr(0, Str.find('\0'));
  }
  return true;
}


/* This function specializes calls to library functions that take constant arguments */
bool isSpecializable(Function * calledFunction){
    
  string funcName = calledFunction->getName();
  if(funcName == "atoi")
    return true;
  else
    return false;
}   

// FIXIT: Check if function is readnone or readonly and has no sideeffects
bool hasNoSideEffects(CallInst * callInst){
  
  Function * calledFunction = callInst->getCalledFunction();
  if(callInst->onlyReadsMemory() || calledFunction->onlyReadsMemory()){
    if(debugPrint) errs()<<"NOTE: *CallInst only reads memory "<<*callInst<<" **\n";
    return true;    
  }

  // FIXIT: Extend this list to include all read-only functions from libc if required 
  string funcName = calledFunction->getName();
  if(funcName == "atoi" || funcName == "strdup" || funcName == "printf")
    return true;
  else
    return false;
}

bool isStringFunction(Function * calledFunction){

  if(calledFunction == NULL){
    // Indirect function call skipped
    return false;
  }

  string funcName = calledFunction->getName();
  if(funcName == "strcmp" || funcName == "strcasecmp" || funcName == "strcspn" 
     || funcName == "strspn" || funcName == "strchr")
    return true;
  else
    return false;
}

Value * getArg(Function * func, int index){
  int i = 0;
  for(auto arg = func->arg_begin(), argEnd = func->arg_end(); arg != argEnd; arg++){
    if(i == index) 
      return &*arg;
    i++;
  }
  return NULL;	
}

// FIXIT: Allow dominated predecessors to not have executed prior to current basic block
bool predecessorsVisited(BasicBlock * BB, map<BasicBlock*, map<Value*, StringAlloca*>> blockContexts){
   
  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
    BasicBlock * predecessor = *it;
    if(blockContexts.find(predecessor) == blockContexts.end()){
      if(debugPrint) errs()<<"NOTE: predecessor not visited \n";
      return false;
    }
  }

  if(debugPrint) errs()<<"NOTE: predecessors visited \n";
  return true;
}


//TODO: Check context properly including comparing the alloca CONTENTS
//TODO: Fill the stringPointers and stringAllocas correctly - be sound even if imprecise 
//TODO: Insert call to merge context and test with examples
bool mergeContext(BasicBlock * BB, map<BasicBlock*, map<Value*, StringAlloca*>> blockContexts,
		  map<Value*, StringAlloca*> & stringAllocas, 
		  map<Value*, StringPointer*> & stringPointers){

  //-- if(debugPrint) errs()<<"Merging context for BB = "<<*BB<<"\n";
  std::vector<map<Value*, StringAlloca*>> predecessorContexts;    

  for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
    BasicBlock * predecessor = *it;
    if(blockContexts.find(predecessor) == blockContexts.end()){
      return false;
    } 
    predecessorContexts.push_back(blockContexts[predecessor]);
  }

  if(debugPrint) errs()<<"\n Comparing predecessor contexts = "<<predecessorContexts.size()<<"\n";
  unsigned int i;
  map<Value*, StringAlloca*> predContext = predecessorContexts[0];
   
  for(auto it = predContext.begin(); 
      it != predContext.end(); ++it){

    Value * inst = it->first;
    StringAlloca * alloca = it->second;
    bool equal = true;
    for(i = 1; i < predecessorContexts.size(); i++){
      map<Value*, StringAlloca*> predContext2 = predecessorContexts[i];
      if(predContext2.find(inst) == predContext2.end()){
	equal = false;
	break;
      } 
      else{
	StringAlloca* alloca1 = predContext[inst];
	StringAlloca* alloca2 = predContext2[inst];
	char* data1 = alloca1->data;
	char* data2 = alloca2->data;          
	if(strcmp(data1, data2) != 0) 
	  equal = false;  
      }      
    }
 
    // FIXIT: Manage String Pointers as well 
    if(equal){
      stringAllocas[inst] = alloca;
    } else{
      alloca->constant = false; //FIXIT: A little over-conservative. Imagine reverse post order scenarios
    }               
  }  

  return true;
}

void markArgsAsNonConst(CallInst* callInst, map<Value*, StringPointer*> stringPointers) {
  int index = 0;
  Function* calledFunction = callInst->getCalledFunction();
  for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd; 
    arg++, index++) {
    // Check for constant pointers
    // All arguments in a 'readonly' function are assumed readonly     
    if(arg->onlyReadsMemory()) {
      if(debugPrint) errs()<<"!note: Argument/Function is readonly - no side effects \n";
      continue;
    }
    
    // Searching for the pointer
    Value * pointerArg = callInst->getOperand(index);
    StringPointer * basePointer;
    if(stringPointers.find(pointerArg) == stringPointers.end()){ 
      continue;
    } 
    else
      basePointer = stringPointers[pointerArg];

    if(debugPrint) errs()<<"Note: Marking allocation as NON-CONSTANT \n";
    // If the argument does alias a tracked allocation mark it as non-constant
    basePointer->alloca->constant = false;  // mark allocation as non-constant    
  }
}

void handleIndirectCall(CallInst * callInst, map<Value*, StringPointer*> & stringPointers){

  // For any argument to the indirect call that aliases any of the allocated memory 
  // mark the side effects i.e mark allocation as non-constant
  for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
    Value * pointerArg = callInst->getArgOperand(index);
    StringPointer * basePointer;
    if(stringPointers.find(pointerArg) == stringPointers.end()){ 
      continue;
    } 
    else
      basePointer = stringPointers[pointerArg];               
    // "conservatively" mark each argument as modified 
    basePointer->alloca->constant = false;
  }
}