/*
  Author: Hashim Sharif
  Email: hsharif3@illinois.edu
  LLVM_version: 3.8.0

TODO:
 1) Consider control flow
 2) Consider pointer aliasing 
 3) Checking for bounds of array accesses is possible with strings?
 4) Need to consider multiple arguments that may access same memory (argument aliasing)

ASSUMPTIONS
 1) catering only i8* arrays

*/

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
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
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
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
 
  StringDepPass(): ModulePass(ID){}

  // Adding llvm::MemoryDependenceAnalysis as a required PrePass                                                         
  void getAnalysisUsage(AnalysisUsage &AU) const override { 
    //AU.addRequired<MemoryDependenceAnalysis>();
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
   


  virtual bool runOnModule(Module & M) {

    // Find all bitcast instructions within stores, calls etc. These must be bitcasting from globals to type*
    for (Module::iterator F = M.begin(), Fend = M.end(); F != Fend; ++F) {  
      Function * func = &*F;
      if (F->isDeclaration()) continue; // FIXIT
      MemCpyInst * lastMemcpy = NULL;
      Value * lastBufferPtr = NULL;
      for(inst_iterator inst = inst_begin(func), e = inst_end(func); inst != e;) {        
        Instruction * I = &(*inst++);
        // Only considering allocas for string specialisation
        if(AllocaInst * allocaInst = dyn_cast<AllocaInst>(&*I)){  
          Type * allocatedType = allocaInst->getAllocatedType();
          // Only considering allocas of char arrays e.g char buffer[100]       
          if(allocatedType->isArrayTy() && allocatedType->getContainedType(0)->isIntegerTy(8)) {

            if(debugPrint) errs()<<"ContainedType = "<<*allocatedType->getContainedType(0)<<"\n";
	    if(debugPrint) errs()<<"Alloca Inst = "<<*allocaInst<<"\n";
            ArrayType * arType = dyn_cast<ArrayType>(&*allocatedType);
            int numElements = arType->getNumElements();
            if(debugPrint) errs()<<"numElements = "<<numElements<<"\n";
            
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
            if(debugPrint) errs()<<"note: unsupported alloca type "<<*allocatedType;  
	}
	else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(&*I)){
 	
          if(debugPrint) errs()<<"Memcpy Inst = "<<*I<<"\n";
          Value * bufferPtr = memcpyInst->getOperand(0);
          StringPointer * basePointer;
          if(stringPointers.find(bufferPtr) == stringPointers.end())
            continue;
          else
            basePointer = stringPointers[bufferPtr];
                   
          int offset = basePointer->position;
          char * sourceBuffer = basePointer->alloca->data + offset;
          StringRef stringRef;
          
          if(!getConstantStringInfo(memcpyInst->getOperand(1), stringRef, 0, false)){
            if(debugPrint) errs()<<"non-constant string operand to memcpy - skipping ...";
            continue; 
	  }

          const char * constantString = stringRef.str().c_str();
          int length = strlen(constantString);   
          memcpy(sourceBuffer, constantString, length + 1);
          basePointer->alloca->initialized = true; // mark string initialized          
          if(debugPrint) errs()<<"constantString = "<<constantString<<"\n";                      
	}	
        else if(StoreInst * storeInst = dyn_cast<StoreInst>(&*I)){

          Value * ptr = storeInst->getOperand(1);
          Type * operandType = storeInst->getOperand(0)->getType();
          if(!operandType->isIntegerTy(8)){
            if(debugPrint) errs()<<"non-char operand - Skipping .."; 	    
            continue;
	  }

          StringPointer * basePointer;
          // Search for the pointer in map of constant pointers - pointers with constant offsets
          if(stringPointers.find(ptr) == stringPointers.end())
            continue;
          else
            basePointer = stringPointers[ptr];

          if(!basePointer->alloca->constant){
            if(debugPrint) errs()<<".. Skipping non constant alloca string ... \n";
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
          errs()<<"called function = "<<*calledFunction<<"\n"; 
          // Skip indirect function calls
          if(calledFunction == NULL)
            continue;

          ///--- if(debugPrint) errs()<<"\nFunction called = "<<calledFunction->getName() <<"\n";
          int index = 0;
          for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd; arg++){
            errs()<<"!!!! arg"<<*arg<<"\n";
            if(!arg->getType()->isPointerTy() || !arg->getType()->getPointerElementType()->isIntegerTy(8)){
              errs()<<"note: Type not supported \n";
              continue;
	    }
   
            // Check for constant pointers
            // All arguments in a 'readonly' function are assumed readonly
            if(!arg->onlyReadsMemory() && !calledFunction->onlyReadsMemory()){
              errs()<<"note: Argument type not readonly \n";
              //continue;
	    }                           
  
            Value * pointerArg = callInst->getOperand(index);
            StringPointer * basePointer;
            if(stringPointers.find(pointerArg) == stringPointers.end())
	    { 
              if(debugPrint) errs()<<"!pointer not found = "<<*pointerArg <<"\n"; 
              continue;
	    } 
            else
              basePointer = stringPointers[pointerArg];

            char * baseStringData = basePointer->alloca->data;
            int strLen = strlen(baseStringData);
            int offset = basePointer->position;
            errs()<<"******* offset = "<<offset<<"\n";
            int numElements = strLen - offset + 1;
            /*char * newStr = (char*) malloc(numElements);
            memcpy(newStr, baseStringData + offset, numElements);     
            errs()<<"**newStr = "<<baseStringData + offset<<"\n";
            */
         
            char * newStr = baseStringData + offset;
            IntegerType * intTy = IntegerType::get(M.getContext(), 64);
            ConstantInt * index1 = ConstantInt::get(intTy, 0);
            vector<Value *> indxList;
            indxList.push_back(index1); 
            indxList.push_back(index1);

            Constant * stringConstant = ConstantDataArray::getString(M.getContext(), StringRef(newStr), true);
 	    GlobalVariable * globalReadString = new GlobalVariable(M, stringConstant->getType(), true,
                                                                   GlobalValue::ExternalLinkage, stringConstant, "");

            if(debugPrint) errs()<<"globalReadString = "<<*globalReadString<<"\n";
            GetElementPtrInst * stringPtr = GetElementPtrInst::Create(NULL, globalReadString, 
                                                                      indxList, Twine(""), callInst);
            
            // The GEP will replace the original argument
            CallOperand * callOperand = new CallOperand;
            callOperand->index = index;
            callOperand->newOperand = stringPtr; 
            replaceOperands[callInst] = callOperand;
            index++;             
	  }
	}
        else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(&*I)){

          Value * ptr = GEPInst->getOperand(0);
          Type * ptrType = ptr->getType();
          StringPointer * basePointer;
          if(stringPointers.find(ptr) == stringPointers.end())
            continue;
          else
            basePointer = stringPointers[ptr];
              
	  // TODO: more comprehensive test for '0' indices into string      
          if(!basePointer->alloca->constant){
            if(debugPrint) errs()<<"..... Skipping non-constant string ... "<<*GEPInst<<"\n";
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
            if(debugPrint) errs() <<"Non-constant indices - Skipping ...";
            continue;
	  }

          if(debugPrint) errs()<<"last Index = "<<lastIndex<<"\n";

          StringPointer * stringPointer = new StringPointer;
          stringPointer->position = basePointer->position + lastIndex;
          stringPointer->alloca = basePointer->alloca;
          stringPointers[I] = stringPointer;
          if(debugPrint) errs()<<"index = "<<stringPointers[I]->position 
                               << " , data = "<<stringPointers[I]->alloca->data<<"\n";

           
	/*if(debugPrint) errs()<<"creating new global string \n";
          char * newStr = stringPointers[I]->alloca->data + stringPointer->position;             
          Constant * stringConstant = ConstantDataArray::getString(M.getContext(), StringRef(newStr), true);
 	  GlobalVariable * globalReadString = new GlobalVariable(M, stringConstant->getType(), true,
                                                                 GlobalValue::ExternalLinkage, stringConstant, "");
          errs()<<"globalReadString = "<<*globalReadString<<"\n";          
          */
	}
      }
    }

    replaceCallOperands();
    return true;
  }   
  
};


char StringDepPass::ID = 0;
static RegisterPass<StringDepPass> X("stringdep", "specialising string functions using alias analysis", false, false);



// Unused code


          // FIXIT: Need check for type ?
          /*if(ptrType->isArrayTy() && ptrType->getContainedType(0)->isIntegerTy(8)){
            if(debugPrint) errs()<<"Note: i8* Type \n";  
            continue;
	  }
          else
            if(debugPrint) errs()<<"Skipped "<<*ptrType->getContainedType(0) <<"\n";
	  */


	  /* const ConstantInt *FirstIdx = dyn_cast<ConstantInt>(GEPInst->getOperand(1));
          if (!FirstIdx || !FirstIdx->isZero()){
	    basePointer->alloca->constant = false; // mark string as non-constant 
            if(debugPrint) errs()<<"marked non-constant = "<<*GEPInst<<"\n";   
            continue;          
	  }

          uint64_t startIdx = 0;
          if (const ConstantInt *CI = dyn_cast<ConstantInt>(GEPInst->getOperand(2)))
	    startIdx = CI->getZExtValue();
	  else{
            basePointer->alloca->constant = false; // mark string as non-constant
            if(debugPrint) errs()<<"marked non-constant = "<<*GEPInst<<"\n";  
	    continue;
	  }
          */
