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

using namespace llvm;
using namespace std;

#define debugPrint 1

/* The FileNode structure retains per file specialization data.
 */



struct SplitString;
struct StringAlloca;
struct StringPointer;
struct CallOperand;
struct Indices;


struct Indices{
  int start;
  int end;
};

struct StringAlloca{
  char * data;
  int size;
  bool initialized;
  bool constant;
  bool split; // If string is split
  list<SplitString> splitStrings;
};

struct SplitString{
  Indices indices;
  StringAlloca* splitAlloca;
};

struct StringPointer{
  int position;
  StringAlloca* alloca; // pointer to the alloca for the string
};

struct CallOperand{
  Value * newOperand;
  int index; // index into the CallInst argument
};


struct SpecializedCall{

  CallInst * origCall;
  CallInst * specCall;
  bool used;
};



struct ConstantFolding : public ModulePass {

  static char ID;
   
  // map<Value*, StringAlloca*> stringAllocas;  
  // stringPointers is a map of constant pointers - string pointers with constant index into alloca   
  //map<Value*, StringPointer*> stringPointers;
  map<Instruction*, CallOperand*> replaceOperands;
  map<Function*, SpecializedCall*> specializedCalls;
  map<BasicBlock*, map<Value*, StringAlloca*>> blockContexts; 

  Module * M;  
  const TargetLibraryInfo *TLI;
  DataLayout * DL;
  DominatorTree * DT;
 
  ConstantFolding(): ModulePass(ID){}

  // Adding llvm::MemoryDependenceAnalysis as a required PrePass                                                         
  void getAnalysisUsage(AnalysisUsage &AU) const override { 
    //AU.addRequired<MemoryDependenceAnalysis>();
    AU.addRequired<DominatorTreeWrapperPass>();
    AU.addRequired<TargetLibraryInfoWrapperPass>();
  }

  
  void replaceCallOperands(){
    for (auto & e : replaceOperands){
      CallOperand * callInfo = e.second;
      e.first->setOperand(callInfo->index, callInfo->newOperand);
    }  
    replaceOperands.clear();    
  }
 

  void replaceCallInsts(){
    for (auto & e : specializedCalls){
      SpecializedCall * call = e.second;
      CallInst * from = call->origCall;
      errs()<<"from = "<<*from<<"\n";
      CallInst * to = call->specCall;
      if(call->used){   
        if(debugPrint) errs()<<"Replacing "<<*from<<" with "<<*to<<"\n";
        ReplaceInstWithInst(from, to);  
      }
      else{
        if(debugPrint) errs()<<"Delecting Instruction = "<<*to<<"\n";
        delete to;
      }
    }  
    specializedCalls.clear();    
  }


  bool getConstantStringInfo(const Value *V, StringRef &Str,
			     uint64_t Offset, bool TrimAtNul) {
   
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

  bool hasNoSideEffects(Function * calledFunction){

    string funcName = calledFunction->getName();
    if(funcName == "atoi" || funcName == "strdup")
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
       || funcName == "strspn")
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
  
   
  /* This routine marks a cloned call context as specialized */
  /* TODO-IMP: Mark speciliazed whenever any specialization occurs */
  void markSpecialized(BasicBlock * BB){

    Function * func = BB->getParent();  // Get containing function
    if(specializedCalls.find(func) != specializedCalls.end()){ // If function is a cloned function
      SpecializedCall * call = specializedCalls[func];
      call->used = true;  // Marking the cloned call as specialized - replaces original call
    }  
  }

  // FIXIT: Allow dominated predecessors to not have executed prior to current basic block
  bool predecessorsVisited(BasicBlock * BB, map<BasicBlock*, map<Value*, StringAlloca*>> blockContexts){
   
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
      BasicBlock * predecessor = *it;
      if(blockContexts.find(predecessor) == blockContexts.end()){
        return false;
      }
    }
    return true;
  }


  //TODO: Check context properly including comparing the alloca CONTENTS
  //TODO: Fill the stringPointers and stringAllocas correctly - be sound even if imprecise 
  //TODO: Insert call to merge context and test with examples
  bool mergeContext(BasicBlock * BB, map<BasicBlock*, map<Value*, StringAlloca*>> blockContexts,
                    map<Value*, StringAlloca*> & stringAllocas, 
                    map<Value*, StringPointer*> & stringPointers){

    std::vector<map<Value*, StringAlloca*>> predecessorContexts;    
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++){
      BasicBlock * predecessor = *it;
      if(blockContexts.find(predecessor) == blockContexts.end()){
        return false;
      } 

      predecessorContexts.push_back(blockContexts[predecessor]);
    }

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
   

  void runOnBB(BasicBlock * BB, map<Value*, StringAlloca*> stringAllocas, map<Value*, 
               StringPointer*> stringPointers, map<BasicBlock*, bool> visited){
   
    BasicBlock& b = *BB;
    for (BasicBlock::iterator inst = b.begin(), ie = b.end(); inst != ie; ) {

        Instruction * I = &(*inst);
        // Only considering allocas for string specialisation
        if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(&*I)){  
          Type * allocatedType = allocaInst->getAllocatedType();
          // Only considering allocas of char arrays e.g char buffer[100]       
          if(allocatedType->isArrayTy() && allocatedType->getContainedType(0)->isIntegerTy(8)) {

            ArrayType * arType = dyn_cast<ArrayType>(&*allocatedType);
            int numElements = arType->getNumElements();            
            StringAlloca * stringAlloca = new StringAlloca;     
            stringAlloca->size = numElements;
            stringAlloca->data = new char[numElements];
            stringAlloca->constant = true;  // string is initialized as constant
            stringAlloca->initialized = false; // string not yet initialized
            stringAllocas[I] = stringAlloca;

            StringPointer * stringPointer = new StringPointer;
            stringPointer->position = 0; // Pointing to the very start of the allocated buffer
            stringPointer->alloca = stringAlloca;
            stringPointers[I] = stringPointer;
	  }
          else
            if(debugPrint) errs()<<"note: Unsupported alloca type "<<*allocatedType<<"\n";  
	}
	else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(&*I)){

          if(debugPrint) errs()<<"MemCpy Inst "<<*memcpyInst<<"\n"; 	
          Value * bufferPtr = memcpyInst->getOperand(0);
          StringPointer * basePointer;
          if(stringPointers.find(bufferPtr) == stringPointers.end()){
            inst++;
            continue;
	  }
          else
            basePointer = stringPointers[bufferPtr];
                   
          int offset = basePointer->position;
          char * sourceBuffer = basePointer->alloca->data + offset;
          StringRef stringRef;
          
          if(!getConstantStringInfo(memcpyInst->getOperand(1), stringRef, 0, false)){
            //-- if(debugPrint) errs()<<"non-constant string operand to memcpy - skipping ...";
            inst++;
            continue; 
	  }

          const char * constantString = stringRef.str().c_str();
          int length = strlen(constantString);   
          memcpy(sourceBuffer, constantString, length + 1);
          basePointer->alloca->initialized = true; // mark string initialized
          basePointer->alloca->constant = true; // String is now constant          
          if(debugPrint) errs()<<"constantString = "<<constantString<<"\n";                      
	}	
        else if(StoreInst * storeInst = dyn_cast<StoreInst>(&*I)){

          Value * ptr = storeInst->getOperand(1);
          Type * operandType = storeInst->getOperand(0)->getType();
          if(!operandType->isIntegerTy(8)){
            inst++;	    
            continue;
	  }

          StringPointer * basePointer;
          // Search for the pointer in map of constant pointers - pointers with constant offsets
          if(stringPointers.find(ptr) == stringPointers.end()){
            inst++;
            continue;
	  }
          else
            basePointer = stringPointers[ptr];

          if(!basePointer->alloca->constant){
            if(debugPrint) errs()<<".. Skipping non constant alloca string ... \n";
            inst++;
            continue;
	  }        
       
          Value * storeOperand = storeInst->getOperand(0);
          int constantValue;
          if(ConstantInt * constOp = dyn_cast<ConstantInt>(storeOperand)){
            constantValue = constOp->getZExtValue();
	  }
          else{
            if(debugPrint) errs()<<"--- Marking alloca as non-const \n";
            basePointer->alloca->constant = false;
            inst++;
            continue;
	  }
          
          char storeChar = (char) constantValue;
          if(storeChar == '\0'){
            if(debugPrint) errs()<<"NULL CHARACTER \n";
	  }
  
          char * stringData = basePointer->alloca->data;
          int offset = basePointer->position;
          // Storing constant character at constant offset
          stringData[offset] = storeChar;
          if(debugPrint) errs()<<"*** stringData = "<<stringData<<" offset = "<<offset<<"\n";                   
	}
        else if(CallInst * callInst = dyn_cast<CallInst>(&*I)){

          if(debugPrint) errs()<<"CHECK = "<<*callInst<<"\n\n";
          Function * calledFunction = callInst->getCalledFunction();          
	  // Indirect function calls need special handling
          if(calledFunction == NULL){

            for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
              Value * pointerArg = callInst->getArgOperand(index);
	      StringPointer * basePointer;
	      if(stringPointers.find(pointerArg) == stringPointers.end()){ 
		  //-- if(debugPrint) errs()<<"!pointer not found = "<<*pointerArg <<"\n"; 
		  continue;
	      } 
	      else
		basePointer = stringPointers[pointerArg];               
              // "conservatively" mark each argument as modified 
	      basePointer->alloca->constant = false;
	    }
            inst++;
            continue;
	  }         

          /* specialize for functions defined in string.h e.g strcmp, strchr */
 	  if(isStringFunction(calledFunction)){
  
            if(callInst->use_empty()){
	      inst++;
	      continue; // Skip simplifying functions with unused results
	    }

            bool skip = false;
            if(debugPrint) errs()<<"\n**** Specializing String function =  "<<calledFunction->getName()<<"\n";
	    for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++){
              Value * pointerArg = callInst->getArgOperand(index);
	      StringPointer * basePointer;
	      if(stringPointers.find(pointerArg) == stringPointers.end()){ 
	        //-- if(debugPrint) errs()<<"!pointer not found = "<<*pointerArg <<"\n"; 
                continue;
	      } 
	      else
		basePointer = stringPointers[pointerArg];

              if(basePointer->alloca->constant == false){
                errs()<<"non-constant string context \n";
	        continue;
	      }

	      char * baseStringData = basePointer->alloca->data;
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

	      if(debugPrint) errs()<<"globalReadString = "<<*globalReadString<<"\n";
	      GetElementPtrInst * stringPtr = GetElementPtrInst::Create(NULL, globalReadString, 
									indxList, Twine(""), callInst);
            
	      // The GEP will replace the original argument
	      CallOperand * callOperand = new CallOperand; 
	      callOperand->index = index;
	      callOperand->newOperand = stringPtr; 
	      replaceOperands[callInst] = callOperand;

              replaceCallOperands();
 
              auto InstCombineRAUW = [this](Instruction *From, Value *With) {
		From->replaceAllUsesWith(With);
	      };

	      LibCallSimplifier Simplifier(*DL, TLI, InstCombineRAUW);
	      if (Value *With = Simplifier.optimizeCall(callInst)) {
                if(With == NULL) errs()<<"NULL VALUE \n\n";
                if(debugPrint) errs()<<"Value to replace = "<<*With<<"\n";
		if(!callInst->use_empty()){             
                  callInst->replaceAllUsesWith(With);              
                  inst = BasicBlock::iterator(stringPtr);
                  if(debugPrint) errs()<<"Replaced uses of = "<<*callInst<<"\n";
                  skip = true;
                  markSpecialized(BB);  // Mark the function as specialized - replaces original function
                  continue;                  
		}
              }


	      /* optimize functions that are not in string.h */
	      if(isSpecializable(calledFunction)){
		string functionName = calledFunction->getName();
		/* optimizing atoi calls with constant strings with corresponding constant int */
		if(functionName == "atoi"){             
		  StringRef stringRef;
		  if(getConstantStringInfo(callInst->getOperand(0), stringRef, 0, false)){
		    const char * constantString = stringRef.str().c_str();
		    if(debugPrint) errs()<<"constant string = "<<constantString<<"\n";
		    int val = atoi(constantString);
		    IntegerType * int32Ty = IntegerType::get(M->getContext(), 32);
		    ConstantInt * constVal = ConstantInt::get(int32Ty, val);
		    callInst->replaceAllUsesWith(constVal);
                    callInst->eraseFromParent();
                    markSpecialized(BB);  // Mark the function as specialized - replaces original function
		  }
		}            
	      }                         
	    }

            if(skip) continue; // NEW: If iteration must not be incremented
 
	  }

          if(hasNoSideEffects(calledFunction)){
            inst++;
            continue;
	  }

          /* NEW: Propagating constants interprocedurally */ 
          if(!isStringFunction(calledFunction) && !calledFunction->isDeclaration()){
                      
            if(debugPrint) errs()<<"----------- Traversing function arguments ---- \n\n";       
            int index = 0;
            BasicBlock * successor = NULL;
            bool clonedFlag = false;
            Function * clonedFunc = NULL;    

	    for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd; arg++){	
              if(!arg->getType()->isPointerTy() || !arg->getType()->getPointerElementType()->isIntegerTy(8)){
		// errs()<<"note: Type not supported \n";
                errs()<<"!note: not supported "<<*arg<<"\n";                
		continue;
	      }

	      // Check for constant pointers
	      // All arguments in a 'readonly' function are assumed readonly
              // FIXIT: Do I need to check for aliasing?
	      if(arg->onlyReadsMemory() || calledFunction->onlyReadsMemory()){
		//--- if(debugPrint) errs()<<"note: Argument/Function is readonly - no side effects \n";
		continue;
	      }                           
  
	      Value * pointerArg = callInst->getOperand(index);
	      StringPointer * basePointer;
	      if(stringPointers.find(pointerArg) == stringPointers.end()){ 
		//--- if(debugPrint) errs()<<"!pointer not found = "<<*pointerArg <<"\n"; 
             	continue;
	      } 
	      else
		basePointer = stringPointers[pointerArg];
           
              // Cloning routines before attempting constant propagation
              if(!clonedFlag){ //IMP: prevent cloning function once per argument
		ClonedCodeInfo info;
		ValueToValueMapTy vmap;
		if(debugPrint) errs()<<"---- cloning function = "<<*calledFunction<<"\n";
		clonedFunc = llvm::CloneFunction(calledFunction, vmap, true, &info);
		clonedFunc->setName(StringRef("random"));
		calledFunction->getParent()->getFunctionList().push_back(clonedFunc);
              
		std::vector<Value*> args(callInst->arg_begin(), callInst->arg_end());
		CallInst * specCallInst = CallInst::Create(clonedFunc, args);
		errs()<<"newCallSite = "<<*specCallInst<<"\n";
		SpecializedCall * call = new SpecializedCall;
		call->origCall = callInst;
		call->specCall = specCallInst;
		call->used = false;
		specializedCalls[clonedFunc] = call;
		successor = &(clonedFunc->getEntryBlock());     
                clonedFlag = true; //IMP: prevent cloning function once per argument      
	      }

              StringPointer * stringPointer = new StringPointer;
              stringPointer->position = basePointer->position;
              stringPointer->alloca = basePointer->alloca;
              Value * pointerVal = getArg(clonedFunc, index);
              stringPointers[pointerVal] = stringPointer;        
              if(debugPrint) errs()<<" POINTER VAL = "<<*pointerVal<<"\n";                
              
              // NEW: CANNOT prevent a function from being traversed twice
              // TODO-NEW: Need to restrict RECURSIVE functions - including mutually recursive
             
              /*
              if(visited.find(successor) != visited.end()){
                continue; // Skip visited basic block 
	      }
	                               
	      visited[successor] = true; // Mark basic block as being visited
	      */
 
              index++;             
	    }
    
            if(clonedFlag)
              runOnBB(successor, stringAllocas, stringPointers, visited);
          }

          if(!isStringFunction(calledFunction) && calledFunction->isDeclaration()){

            if(debugPrint) errs()<<"--- Declaration: "<<*calledFunction<<"\n";
	    // TODO-NEW: Check for side effects and mark struct unspecializable
	  }

	  // End of CallInst
	}
        else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(&*I)){

          Value * ptr = GEPInst->getOperand(0);
          //-- Type * ptrType = ptr->getType();
          StringPointer * basePointer;
          if(stringPointers.find(ptr) == stringPointers.end())
	  {
	    inst++; 
            continue;
	  }
          else
            basePointer = stringPointers[ptr];
              
	  // TODO: more comprehensive test for '0' indices into string      
          if(!basePointer->alloca->constant){
            //-- if(debugPrint) errs()<<"..... Skipping non-constant string ... "<<*GEPInst<<"\n";
            inst++;
            continue;              
	  }

          Value * indexValue;
          bool nonConstantIndices = false;
          int lastIndex;
          for(auto index = GEPInst->idx_begin(), end = GEPInst->idx_end(); index != end; index++){
            
            indexValue = *index;            
            if(ConstantInt *Idx = dyn_cast<ConstantInt>(indexValue)){
              lastIndex = Idx->getZExtValue();     
	    }
	    else{
              nonConstantIndices = true;
              break;
	    }
	  } 

          if(nonConstantIndices){

            basePointer->alloca->constant = false;
            inst++;
            continue;
	  }

          StringPointer * stringPointer = new StringPointer;
          stringPointer->position = basePointer->position + lastIndex;
          stringPointer->alloca = basePointer->alloca;
          stringPointers[I] = stringPointer;           
	}
        else if(BranchInst * branchInst = dyn_cast<BranchInst>(&*I)){

          blockContexts[BB] = stringAllocas;           
          for(unsigned int index = 0; index < branchInst->getNumSuccessors(); index++){
            BasicBlock * successor = branchInst->getSuccessor(index);
            //BasicBlockEdge * edge = new BasicBlockEdge(BB, successor);
            if(visited.find(successor) != visited.end()){
              continue; // Skip visited basic block 
	    }
            
            // Traverse in reverse post-order
            if(!predecessorsVisited(successor, blockContexts)){
              continue;
	    }          

            //TODO: Add merging contexts            
            map<Value*, StringAlloca*> stringAllocas2; 
            runOnBB(successor, stringAllocas2, stringPointers, visited);
               
      
	    // Forward context to successor block if the successor has only a single predecessor & isNotVisited
            /* if(successor->getUniquePredecessor() ) {
              visited[successor] = true; 
              errs()<<"Successor has a single predecessor \n";
              runOnBB(successor, stringAllocas, stringPointers, visited);
	    }    
            else{
              errs()<<"Block has multiple predecessors \n";
              // Passing empty context
              map<Value*, StringAlloca*> stringAllocas2; 
              map<Value*, StringPointer*> stringPointers2;
              runOnBB(successor, stringAllocas2, stringPointers2, visited);
	      }*/
 
	  }         
	}

	inst++; 
    }
  } 



  virtual bool runOnModule(Module & module) override {

    errs()<<"\n\n*******---- InterConstProp -----*********\n\n";
    map<Value*, StringAlloca*> stringAllocas;  
    // stringPointers is a map of constant pointers - string pointers with constant index into alloca   
    map<Value*, StringPointer*> stringPointers;
    map<BasicBlock*, bool> visited; 

    TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
    DL = new DataLayout(&module);    
    M = &module;
    Function * func = M->getFunction(StringRef("main"));
   
    BasicBlock * entry = &(func->getEntryBlock());
    runOnBB(entry, stringAllocas, stringPointers, visited); 
    	   
    replaceCallOperands();
    replaceCallInsts();
    return true;
  }   
  
};


char ConstantFolding::ID = 0;
static RegisterPass<ConstantFolding> X("inter-constprop", "Constant Folding for strings", false, false);


