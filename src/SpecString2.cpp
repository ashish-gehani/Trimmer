/*
  Author: Hashim Sharif
  Email: hsharif3@illinois.edu
  LLVM_version: 3.8.0

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
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Dominators.h"
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

struct SpecString : public FunctionPass {
 
  static char ID;
  map<Instruction*, Value*> replaceValues;

  SpecString() : FunctionPass(ID) { }       

  /* This routine extracts the filename of the file input to the open call
     This function has been borrowed from the LLPE toolchain by Smowton.
   */ 
  bool getConstantStringInfo(const Value *V, StringRef &Str) {

    // Look through bitcast instructions and geps.
    V = V->stripPointerCasts();
    // If the value is a GEP instruction or constant expression, treat it as an offset.
    if (const GEPOperator *GEP = dyn_cast<GEPOperator>(V)) {
      // Make sure the GEP has exactly three arguments.
      if (GEP->getNumOperands() != 3)
	return false;

      // Make sure the index-ee is a pointer to array of i8.
      PointerType *PT = cast<PointerType>(GEP->getOperand(0)->getType());
      ArrayType *AT = dyn_cast<ArrayType>(PT->getElementType());
      if (AT == 0 || !AT->getElementType()->isIntegerTy(8))
	return false;

      // Check to make sure that the first operand of the GEP is an integer and
      // has value 0 so that we are sure we're indexing into the initializer.
      const ConstantInt *FirstIdx = dyn_cast<ConstantInt>(GEP->getOperand(1));
      if (FirstIdx == 0 || !FirstIdx->isZero())
	return false;

      // If the second index isn't a ConstantInt, then this is a variable index
      // into the array.  If this occurs, we can't say anything meaningful about
      // the string.
      uint64_t StartIdx = 0;
      if (const ConstantInt *CI = dyn_cast<ConstantInt>(GEP->getOperand(2)))
	StartIdx = CI->getZExtValue();
      else
	return false;

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

    if (Array == 0 || !Array->isString())
      return false;

    // Start out with the entire array in the StringRef.
    Str = Array->getAsString();
    return true;
  }
  

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<DominatorTreeWrapperPass>();
  }


 void replaceUses(){
    for (auto & e : replaceValues){
      e.first->replaceAllUsesWith(e.second);
      e.first->dropAllReferences();
      e.first->removeFromParent();
    }  
   
    replaceValues.clear();
  }


  char* substring(const char * source, int start, int end){
    source = source + start;
    int nbytes = end - start;
    char * newString = (char*) malloc((nbytes + 1) * sizeof(char));
    memcpy(newString, source, nbytes);
    newString[nbytes] = '\0';
    return newString;     
  }


  virtual bool runOnFunction(Function & F) {
 
    Module * M = F.getParent();  
    Function * func = &F; 
    string dataStr;
    Value * globalStringPtr;

    for(Function::iterator i = func->begin(), e = func->end(); i != e; ++i){ 

      BasicBlock * BB = &*i;
      for(auto & I : *BB){
        Instruction * inst = &I;
         if(CallInst * callInst = dyn_cast<CallInst>(&*inst)){
	  string name = callInst->getCalledFunction()->getName().str();
	  if(name == "substring"){

            if(debugPrint) errs()<<"substring = "<<*callInst<<"\n";
	    Value * startIndex = callInst->getOperand(1);
	    Value * endIndex = callInst->getOperand(2);
	    int startIdx;
	    int endIdx;

	    if(ConstantInt * constValue = dyn_cast<ConstantInt>(&*startIndex)){
	      if(debugPrint) errs()<<"constant1 = "<< constValue->getZExtValue() <<"\n";
	      startIdx = constValue->getZExtValue();
	    }
	    else{
              continue;
	    }

	    if(ConstantInt * constValue = dyn_cast<ConstantInt>(&*endIndex)){
	      if(debugPrint) errs()<<"constant2 = "<< constValue->getZExtValue() <<"\n";
	      endIdx = constValue->getZExtValue();
	    }
	    else{
              continue;
	    }
       
            globalStringPtr = callInst->getOperand(0); // get pointer to constant string
	    StringRef dataString;
	    if(!getConstantStringInfo(globalStringPtr, dataString)) // if argument not a constant string
              continue;

	    dataStr = dataString.str();     
	    char * sourceString = substring(dataStr.c_str(), startIdx, endIdx);
            if(debugPrint) errs()<<"sourceString = "<<sourceString<<"\n";

	    Constant * stringConstant = ConstantDataArray::getString(M->getContext(), StringRef(sourceString), true);
	    GlobalVariable * globalString = new GlobalVariable(*M, stringConstant->getType(), true, 
							       GlobalValue::ExternalLinkage, stringConstant, "");

            if(debugPrint) errs()<<"globalString = "<<*globalString<<"\n";
	    IntegerType * intTy = IntegerType::get(M->getContext(), 64);
	    ConstantInt * index1 = ConstantInt::get(intTy, 0);
	    vector<Value *> indxList;
	    indxList.push_back(index1);
	    indxList.push_back(index1);

	    GetElementPtrInst * stringPtr = GetElementPtrInst::Create(NULL, globalString, 
								      indxList, Twine(""), callInst);
	    replaceValues[callInst] = stringPtr; 	    
	  }
	}
      }
    }

    replaceUses(); 
    return true;

  }

};


char SpecString::ID = 0;
static RegisterPass<SpecString> X("spec-string2", "specialising string functions", false, false);
