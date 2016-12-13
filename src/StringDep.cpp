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


struct StringData{
  char * data;
  int size;
  bool initialized;
};

struct PointerData{
  int position;
  StringData* stringData;
};


struct StringDepPass : public ModulePass {

  static char ID;
  map<Value*, StringData*> memcpyStrings;     
  map<Value*, PointerData*> stringPointers;

  StringDepPass(): ModulePass(ID){}

  // Adding llvm::MemoryDependenceAnalysis as a required PrePass                                                         
  void getAnalysisUsage(AnalysisUsage &AU) const override { 
    //AU.addRequired<MemoryDependenceAnalysis>();
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
            
            StringData * stringData = new StringData;     
            stringData->size = numElements;
            stringData->data = new char[numElements];
            memcpyStrings[I] = stringData;

            PointerData * pointerData = new PointerData;
            pointerData->position = 0; // Pointing to the very start of the allocated buffer
            pointerData->stringData = stringData;
            stringPointers[I] = pointerData;
	  }
          else
            if(debugPrint) errs()<<"note: unsupported alloca type "<<*allocatedType;  
	}
	else if(MemCpyInst * memcpyInst = dyn_cast<MemCpyInst>(&*I)){
 	
          if(debugPrint) errs()<<"Memcpy Inst = "<<*I<<"\n";
          Value * bufferPtr = memcpyInst->getOperand(0);
          PointerData * basePointer;
          if(stringPointers.find(bufferPtr) == stringPointers.end())
            continue;
          else
            basePointer = stringPointers[bufferPtr];
                   
          int offset = basePointer->position;
          char * sourceBuffer = basePointer->stringData->data + offset;
          StringRef stringRef;
          getConstantStringInfo(memcpyInst->getOperand(1), stringRef, 0, false);
          const char * constantString = stringRef.str().c_str();
          int length = strlen(constantString);   
          memcpy(sourceBuffer, constantString, length + 1); 
         
          if(debugPrint) errs()<<"length = "<<length<<"\n";
          if(debugPrint) errs()<<"constantString = "<<constantString<<"\n";                      
	}	
        else if(StoreInst * storeInst = dyn_cast<StoreInst>(&*I)){
          if(debugPrint) errs()<<"Store Operand = "<<*storeInst->getOperand(1)<<"\n";
	}
        else if(CallInst * callInst = dyn_cast<CallInst>(&*I)){
          Function * calledFunction = callInst->getCalledFunction();
          // Skip indirect function calls
          if(calledFunction == NULL)
            continue;

          if(debugPrint) errs()<<"\nFunction called = "<<calledFunction->getName() <<"\n";
          for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd; arg++){
            if(!arg->getType()->isPointerTy())
              continue;
            if(debugPrint) errs()<<"function arg = "<<*arg->getType()->getPointerElementType()<<" \n";
            if(debugPrint) errs()<<"readonly = "<<arg->onlyReadsMemory()<<"\n";             
	  }
          if(debugPrint) errs()<<"---- end function call --- \n";
	}
        else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(&*I)){

          Value * ptr = GEPInst->getOperand(0);
          Type * ptrType = ptr->getType();

          // FIXIT: Need check for type ?
          /*if(ptrType->isArrayTy() && ptrType->getContainedType(0)->isIntegerTy(8)){
            if(debugPrint) errs()<<"Note: i8* Type \n";  
            continue;
	  }
          else
            if(debugPrint) errs()<<"Skipped "<<*ptrType->getContainedType(0) <<"\n";
	  */
          PointerData * basePointer;
          if(stringPointers.find(ptr) == stringPointers.end())
            continue;
          else
            basePointer = stringPointers[ptr];
           
          errs()<<"ptr = "<<*ptr<<"\n";
	  const ConstantInt *FirstIdx = dyn_cast<ConstantInt>(GEPInst->getOperand(1));
          if (!FirstIdx || !FirstIdx->isZero())
	    continue;          
          uint64_t startIdx = 0;
          if (const ConstantInt *CI = dyn_cast<ConstantInt>(GEPInst->getOperand(2)))
	    startIdx = CI->getZExtValue();
         
          PointerData * pointerData = new PointerData;
          pointerData->position = basePointer->position + startIdx;
          pointerData->stringData = basePointer->stringData;
          stringPointers[I] = pointerData;
          errs()<<"index = "<<stringPointers[I]->position << " , data = "<<stringPointers[I]->stringData->data<<"\n"; 
	}

      }
    }

    return true;
  }   
  
};


char StringDepPass::ID = 0;
static RegisterPass<StringDepPass> X("stringdep", "specialising string functions using alias analysis", false, false);
