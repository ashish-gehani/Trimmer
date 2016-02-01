/*


Author: Hashim Sharif
Email: hsharif3@illinois.edu


TODO:
- Add test for the case where a non static index has been used to index the file - DONE
- Must preserve the file handler for some cases - DONE - already done
- Test on a number of examples - Look for Chris smowton has in his paper
- lseek - DONE
- add an lseek call for each read call to keep the file pointer up to date for non static index reads 


TODO V2:
- add an lseek call for each read call to keep the file pointer up to date for non static index reads 	

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


#define debugPrint 1


/* author : Hashim Sharif
 * FIXIT: replace memcpy with llvm memcpy. test if llvm understands intrinsic
 * FIXIT: Add debug printing with macros
 * FIXIT: Add test cases to git
 * FIXIT: Fix environment dependency on opt-3.6. set aliases in a script
 */


struct FileNode{

	string fileName;
	int fileSize;
	int filePosition;
	bool staticIndices;
	GlobalVariable * globalString;
};

struct FileIOPass : public ModulePass {

	static char ID;
	bool hasMemCpyRoutine;
	//Module module;

    FileIOPass() : ModulePass(ID) { }
		
    map<Instruction*, FileNode*> dataMappings;
    map<Instruction*, Instruction*> replaceInstructions;


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
				errs()<<"fileContents "<<strStream.str();

				Constant * stringConstant = ConstantDataArray::getString(M.getContext(), StringRef(fileContents), true);
				GlobalVariable * globalString = new GlobalVariable(M, stringConstant->getType(), true, GlobalValue::ExternalLinkage,
                        stringConstant, "");

				// Initializing a FileNode for the file open instance
				FileNode * fileNode = new FileNode();
				fileNode->fileName = fileName;
				fileNode->fileSize = fileContents.length();
				fileNode->filePosition = 0;
				fileNode->staticIndices = true; // Initially the file is "specializable"
				fileNode->globalString = globalString;

				errs()<<"global String "<<*globalString<<"\n";
				dataMappings[callInst] = fileNode;

			}
			else{
				// Call cannot be resolved; File name is not constant
				return;
			}

		}
    }



    void resolveReadCalls(CallInst * callInst, Module & M){

		Function * f = callInst->getCalledFunction();
		string functionName = f->getName().str();

		if(functionName == "read"){

			Value * fd = callInst->getOperand(0);
			errs()<<"fd "<<*fd <<"\n";
			Instruction * openInst = dyn_cast<Instruction>(&*fd);

			GlobalVariable * globalString;
			FileNode * fileNode;

			if(dataMappings.find(openInst) != dataMappings.end()){

				fileNode = dataMappings[openInst];
				globalString = fileNode -> globalString;
				errs()<< *globalString <<"\n";
			}
			else{
				errs()<<"open call not found \n";
				return;
			}


			/* If a non constant index has been used to read from the file the reads are no longer "specializable"  */
			if(fileNode->staticIndices == false){
				return;
			}

			Value * destBuffer = callInst->getOperand(1);
			Value * byteCount = callInst->getOperand(2);
			errs()<<*destBuffer->getType()<<"\n";
			int intByteCount = 0;	

			if(ConstantInt * constInst = dyn_cast<ConstantInt>(&*byteCount)){
				errs()<<"constant Int "<< constInst->getZExtValue() <<"\n";
				intByteCount = constInst->getZExtValue();
			}
			else{     /* A non constant index returns the reads not "specializable"  */

				/*FIXIT: Add a lseek call to set the file position pointer of the file descriptor to its correct value */			
				fileNode->staticIndices = false;
				return;
			}

			vector<Type*> argumentTypes;
			argumentTypes.push_back(Type::getInt8PtrTy(M.getContext()));
			argumentTypes.push_back(Type::getInt8PtrTy(M.getContext()));
			argumentTypes.push_back(Type::getInt64Ty(M.getContext()));

			FunctionType *FT = FunctionType::get(Type::getVoidTy(M.getContext()), argumentTypes, false);
			// FIXIT: need to use llvm memcpy intrinsic

			/* FIXIT: Variable not required. getFunction and a check on NULL should have sufficed */
			Function * llvmMemcpy;
			if(!hasMemCpyRoutine){
				llvmMemcpy = Function::Create(FT, GlobalValue::ExternalLinkage, "memcpy", &M);
				hasMemCpyRoutine = true;
			}
			else{
				llvmMemcpy = M.getFunction(StringRef("memcpy"));
			}

			IntegerType * intTy = IntegerType::get(M.getContext(), 64);
			ConstantInt * index1 = ConstantInt::get(intTy, 0);
			ConstantInt * index2 = ConstantInt::get(intTy, fileNode->filePosition);

			fileNode->filePosition += intByteCount;


			vector<Value *> indxList;
			indxList.push_back(index1);
			indxList.push_back(index2);

			GetElementPtrInst * stringPtr = GetElementPtrInst::Create(globalString, indxList, Twine(""), callInst);

			std::vector<Value*> functionArgs;
			functionArgs.push_back(destBuffer);
			functionArgs.push_back(stringPtr);
			functionArgs.push_back(byteCount);

			CallInst * retVal = CallInst::Create((Value*) llvmMemcpy, ArrayRef<Value*>(functionArgs), Twine(""), callInst);
			errs()<<" CALL INST "<<*retVal<<"\n";

			AllocaInst * allocaOperand = new AllocaInst(intTy, Twine(""), callInst);
			//ConstantInt * returnCount = ConstantInt::get(intTy, byteCount);
			StoreInst * storeOperand = new StoreInst(byteCount, allocaOperand, callInst);
			errs()<<""<<*allocaOperand <<"\n";
			errs()<<""<<*storeOperand <<"\n";

			LoadInst * loadInst = new LoadInst(allocaOperand, Twine(""), false, callInst);

			errs()<<""<< *loadInst<<"\n";
			errs()<<"type"<<*loadInst->getType()<<"\n";
			errs()<<"type"<<*callInst<<"\n";

			replaceInstructions[callInst] = loadInst;
		  
		}

    }



	void resolveSeekCalls(CallInst * callInst, Module & M){


		Function * f = callInst->getCalledFunction();
		string functionName = f->getName().str();

		if(functionName == "lseek"){

			Value * fd = callInst->getOperand(0);
			errs()<<"fd (seek call) "<<*fd <<"\n";
			Instruction * openInst = dyn_cast<Instruction>(&*fd);

			FileNode * fileNode;
			if(dataMappings.find(openInst) != dataMappings.end()){

				fileNode = dataMappings[openInst];
			}
			else{

				errs()<<"open call not corresponding to descriptor used in seek call \n";
				return;
			}

			Value * offset = callInst->getOperand(1);
			Value * whence = callInst->getOperand(2);
			int intByteOffset = 0;	

			if(ConstantInt * constInst = dyn_cast<ConstantInt>(&*offset)){

				errs()<<"constant OFFSET "<< constInst->getZExtValue() <<"\n";
				intByteOffset = constInst->getZExtValue();
				errs()<<"******* OFFSET ******* "<<intByteOffset;
			}
			else{     /* A non constant index returns the reads not "specializable"  */

				/*FIXIT: Add a lseek call to set the file position pointer of the file descriptor to its correct value */
				fileNode->staticIndices = false;
				return;
			}


			int intWhence;
			if(ConstantInt * constInst = dyn_cast<ConstantInt>(&*whence)){

				errs()<<"******** WHENCE ***********"<< constInst->getZExtValue() <<"\n";
				intWhence = constInst->getZExtValue();
			}
			else{     /* A non constant index returns the reads not "specializable"  */

				errs()<<"UNSUPPORTED Value for whence \n";
				abort();
				return;
			}


			switch(intWhence){
			
				case SEEK_SET: fileNode->filePosition = intByteOffset; fileNode->staticIndices = true; break;

				case SEEK_CUR: fileNode->filePosition += intByteOffset; break;

				case SEEK_END: fileNode->filePosition = fileNode->fileSize + intByteOffset; break; 
			}


		  
		}

    }




    void replaceReadCalls(){

    	for (auto & e : replaceInstructions){
    		ReplaceInstWithInst(e.first, e.second);
    	}

    }


    /* Initialization routine */
    void initialization(){
    	hasMemCpyRoutine = false;

    }




	virtual bool runOnModule(Module & M) {

		initialization();

		// Find all bitcast instructions within stores, calls etc. These must be bitcasting from globals to type*
		for (Module::iterator F = M.begin(), Fend = M.end(); F != Fend; ++F) {

			 	   	for(inst_iterator inst = inst_begin(F), e = inst_end(F); inst != e;) {

			 	   		Instruction * I = &(*inst++);
			 	   		if(debugPrint == 1){
			 	   			errs()<<*I<<"\n";
			 	   		}

			 	   		if(CallInst * callInst = dyn_cast<CallInst>(&*I)){

			 	   			errs()<<"call casted \n";
			 	   			resolveOpenCalls(callInst, M);
			 	   			resolveReadCalls(callInst, M);
			 	   			resolveSeekCalls(callInst, M);
			 	   			errs()<<"call Resolution \n";
			 	   		}

			 	   	}
		}

		replaceReadCalls();
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




 //	ReplaceInstWithInst(dyn_cast<Instruction>(&*callInst), loadInst);
		   //	errs()<<*loadInst;

			//prunedInstructions.push_back(callInst);
			//callInst->removeFromParent();

			/*Function * llvmMemcpy = M.getFunction(StringRef("open"));
			if(llvmMemcpy != NULL){
				errs()<<"we have llvm memcpy \n";
			}*/

			//FIXIT: Use getModule for Function, Inst etc
			//Function* realFunction = Function::Create(ft, GlobalValue::ExternalLinkage, "memcpy" , &M);

			/*std::vector<Value*> functionArgs;

			for (Function::arg_iterator arg = F->arg_begin(), endArg = F->arg_end(); arg != endArg; ++arg) {
				 functionArgs.push_back(arg);-
			}

			CallInst * retVal = CallInst::Create((Value*) realFunction, ArrayRef<Value*>(functionArgs), Twine(""), entryBlock);
	*/

			/*Value * fileNameOperands = callInst->getOperand(0);
			if(ConstantDataArray * constArray = dyn_cast<ConstantDataArray>(&*fileNameOperand)){
				cout<<"the file name is a constant \n";
			}*/