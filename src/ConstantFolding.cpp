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


struct StringDepPass : public ModulePass {

  static char ID;
   
  map<Value*, StringAlloca*> stringAllocas;  
  // stringPointers is a map of constant pointers - string pointers with constant index into alloca   
  map<Value*, StringPointer*> stringPointers;
  map<Instruction*, CallOperand*> replaceOperands;
  Module * M;  
  const TargetLibraryInfo *TLI;
  DataLayout * DL;
  DominatorTree * DT;
 
  StringDepPass(): ModulePass(ID){}

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
      //--- if(debugPrint) errs()<<"indirect function call skipped \n";
      return false;
    }

    string funcName = calledFunction->getName();
    if(funcName == "strcmp" || funcName == "strcasecmp" || funcName == "strcspn" || funcName == "strspn" 
       || funcName == "atoi" || funcName == "strdup")
      return true;
    else
      return false;
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
            if(debugPrint) errs()<<"note: unsupported alloca type "<<*allocatedType<<"\n";  
	}
	else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(&*I)){
 	
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

	      Constant * stringConstant = ConstantDataArray::getString(M->getContext(), StringRef(newStr), true);
	      GlobalVariable * globalReadString = new GlobalVariable(*M, stringConstant->getType(), true,
								     GlobalValue::ExternalLinkage, stringConstant, "");

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
                if(With == NULL) errs()<<"NULL VALUE \n\n\n\n";
                errs()<<"value to replace = "<<*With<<"\n";
		if(!callInst->use_empty())
                  callInst->replaceAllUsesWith(With);
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
		  }
		}            
	      }
                         
	    } 
	  }

          if(hasNoSideEffects(calledFunction)){
            inst++;
            continue;
	  }

          /* for functions other than string functions look for memory side effects */ 
          if(!isStringFunction(calledFunction)){
                             
            int index = 0;
	    for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd; arg++){	
              if(!arg->getType()->isPointerTy() || !arg->getType()->getPointerElementType()->isIntegerTy(8)){
		// errs()<<"note: Type not supported \n";                
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

              /* Mark the string as non-constant */
              StringAlloca * stringAlloca = basePointer->alloca;
              stringAlloca->constant = false;
	      index++;             
	    }
          }

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
        
          for(unsigned int index = 0; index < branchInst->getNumSuccessors(); index++){
            BasicBlock * successor = branchInst->getSuccessor(index);
            //BasicBlockEdge * edge = new BasicBlockEdge(BB, successor);
            if(visited.find(successor) != visited.end()){
              continue; // Skip visited basic block 
	    }
           
	    // Forward context to successor block if the successor has only a single predecessor & isNotVisited
            if(successor->getUniquePredecessor() ) {
              visited[successor] = true; 
              errs()<<"Successor has single predecessor \n";
              runOnBB(successor, stringAllocas, stringPointers, visited);
	    }    
            else{
              errs()<<"block has multiple predecessor \n";
              // Passing empty context
              map<Value*, StringAlloca*> stringAllocas2; 
              map<Value*, StringPointer*> stringPointers2;
              runOnBB(successor, stringAllocas2, stringPointers2, visited);
	    }             
	  }         
	}

	inst++; 
    }

  } 



  virtual bool runOnModule(Module & module) override {

    TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
    DL = new DataLayout(&module);    
    M = &module;
	   
    // Find all bitcast instructions within stores, calls etc. These must be bitcasting from globals to type*
    for (Module::iterator F = module.begin(), Fend = module.end(); F != Fend; ++F) { 
 
      Function * func = &*F;       
      if (F->isDeclaration()) continue; // FIXIT

      map<Value*, StringAlloca*> stringAllocas;  
      // stringPointers is a map of constant pointers - string pointers with constant index into alloca   
      map<Value*, StringPointer*> stringPointers;
      map<BasicBlock*, bool> visited; 

      DT = &getAnalysis<DominatorTreeWrapperPass>(*func).getDomTree();
      BasicBlock * entry = &(func->getEntryBlock());
      runOnBB(entry, stringAllocas, stringPointers, visited);       
    }

    replaceCallOperands();
    return true;
  }   
  
};


char StringDepPass::ID = 0;
static RegisterPass<StringDepPass> X("stringdep", "specialising string functions using alias analysis", false, false);


