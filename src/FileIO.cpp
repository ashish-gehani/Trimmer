/*


Author: Hashim Sharif
Email: hsharif3@illinois.edu

*/

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"

#include<map>
#include<set>

#include<iostream>
#include<vector>
#include<map>
#include<fstream>
#include<string.h>
#include<sstream>

using namespace llvm;
using namespace std;


struct FileIOPass : public ModulePass {

	static char ID;
	//Module module;

    FileIOPass() : ModulePass(ID) { }
		
    map<Instruction*, GlobalVariable*> dataMappings;


    bool getConstantStringInfo(const Value *V, StringRef &Str) {

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

		  // Get the number of elements in the array
		  uint64_t NumElts = Array->getType()->getArrayNumElements();

		  // Start out with the entire array in the StringRef.
		  Str = Array->getAsString();
		  return true;
    }


    void resolveOpenCalls(CallInst * callInst, Module & M){

		Function * f = callInst->getCalledFunction();
		string functionName = f->getName().str();

		if(functionName == "open"){

			Value * openMode = callInst->getOperand(1);
			if(ConstantInt * mode = dyn_cast<ConstantInt>(&*openMode))
			{
				if(mode->getZExtValue() != 0)
					return;
			}

			Value * fileNameOperand = callInst->getOperand(0);
			if(Constant * constString = dyn_cast<Constant>(&*fileNameOperand)){

				StringRef fileNameStr;
				getConstantStringInfo(fileNameOperand, fileNameStr);

				string fileName = fileNameStr.str();
				ifstream inFile;
				inFile.open(fileName);//open the input file

				stringstream strStream;
				strStream << inFile.rdbuf();//read the file
				string fileContents = strStream.str();//str holds the content of the file

				Constant * stringConstant = ConstantDataArray::getString(M.getContext(), StringRef(fileContents), true);
				GlobalVariable * globalString = new GlobalVariable(M, stringConstant->getType(), true, GlobalValue::ExternalLinkage,
                        stringConstant, "");

				errs()<<"global String "<<*globalString<<"\n";
				dataMappings[callInst] = globalString;

			}
			else{
				// Call cannot be resolved; File name is not constant
				return;
			}

		}
    }



    void resolveReadCalls(CallInst * callInst){

		Function * f = callInst->getCalledFunction();
		string functionName = f->getName().str();

		if(functionName == "read"){

			Value * fd = callInst->getOperand(0);
			errs()<<"fd "<<*fd <<"\n";
			Instruction * openInst = dyn_cast<Instruction>(&*fd);

			if(dataMappings.find(openInst) != dataMappings.end()){

				GlobalVariable * gv = dataMappings[openInst];
				errs()<<*gv<<"\n";
			}
			else{
				cout<<"open call not found \n";
			}

			/*Value * fileNameOperands = callInst->getOperand(0);
			if(ConstantDataArray * constArray = dyn_cast<ConstantDataArray>(&*fileNameOperand)){
				cout<<"the file name is a constant \n";
			}*/
		}

    }


	virtual bool runOnModule(Module & M) {


		// Find all bitcast instructions within stores, calls etc. These must be bitcasting from globals to type*
		for (Module::iterator F = M.begin(), Fend = M.end(); F != Fend; ++F) {

			 	   	for(inst_iterator inst = inst_begin(F), e = inst_end(F); inst != e; ++inst) {

			 	   		if(CallInst * callInst = dyn_cast<CallInst>(&*inst)){

			 	   			resolveOpenCalls(callInst, M);
			 	   			resolveReadCalls(callInst);
			 	   		}

			 	   	}
		}

		return true;

    }


};


char FileIOPass::ID = 0;
static RegisterPass<FileIOPass> X("file", "Specialising FILE System operations", false, false);




/*
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
   */
