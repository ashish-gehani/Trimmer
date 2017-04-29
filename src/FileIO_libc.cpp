
//  Author: Hashim Sharif
//  Email: hsharif3@illinois.edu
//  LLVM_version: 3.8.0

// * FIXIT: Do comprehensive regression testing
// * FIXIT: Assumption for chunk size of 1 with fread calls
// * FIXIT: TEST partially constant file reads - i.e constant offset reads followed by constant offset reads.
// * FIXIT  EOF very platform specific. returns -1 


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

struct FileNode{
  Instruction * fd;   // Pointer to the llvm "CallInst" invoking "open"
  string fileName;    // Name of the specialised file 
  int fileSize;       // Length of file contents
  int filePosition;   // Tracks position of the file pointer
  bool isSpecializable; // Tracks specialization at various program points
  char * fileData; // A char array to hold contents of file 
  GlobalVariable * globalString; // Link to the llvm string holding file contents
};

struct FileIOPass : public ModulePass {

  static char ID;
  bool hasMemCpyRoutine;
  
  FileIOPass() : ModulePass(ID) { }
		
  map<Instruction*, Instruction*> replaceInstructions;
  map<Instruction*, Value*> replaceValues;
  map<Instruction*, Instruction*> addInstructions;
  Module *M;
  LLVMContext * context;

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


  /* This function promotes all read only files to a global constant string.
     Subsequent read calls with "constant" offsets will be replaced with llvm memcpy instrinsics
  */
  void resolveOpenCalls(CallInst * callInst, map<Instruction*, FileNode*> & fileDescriptors){

    Function * f = callInst->getCalledFunction();
    string functionName = f->getName().str();

    if(functionName == "open" || functionName == "fopen"){
      Value * openMode = callInst->getOperand(1);
      if(functionName == "open"){
        if(ConstantInt * mode = dyn_cast<ConstantInt>(&*openMode)){
	  if(mode->getZExtValue() != 0)
	    return;
        }
      }
      else if (functionName == "fopen"){
        StringRef modeStr;
        getConstantStringInfo(openMode, modeStr);
        string mode = modeStr.str(); 
        if(strcmp(mode.c_str(), "r") != 0){
          if(debugPrint) errs()<<"Note: File mode not READ-ONLY \n";
          return;
	}
        else{
          if(debugPrint) errs()<<"File is READ-ONLY \n";
	}
      }

      Value * fileNameOperand = callInst->getOperand(0);
      if(dyn_cast<Constant>(&*fileNameOperand)){     
	StringRef fileNameStr;
	getConstantStringInfo(fileNameOperand, fileNameStr);
	string fileName = fileNameStr.str();
        if(debugPrint) errs()<<"FileName : "<<fileName<<"\n\n";

	int i = 0;
	FILE * fp = fopen(fileName.c_str(), "r");
        struct stat st;
        stat(fileName.c_str(), &st);
        int fileSize = st.st_size;
        char * source = (char*) malloc(fileSize + 1);      
 
	if (fp != NULL){
	  char symbol;
	  while ((symbol = getc(fp)) != EOF)
	  {
	    source[i] = symbol;
	    i++;
	  }
	  source[i] = '\0';
	  fclose(fp);
	}

        if(debugPrint) errs()<<"Value of File Data : \n ----\n "<<source<<"\n --------- \n";
 
        if(source == NULL || fp == NULL){
          errs()<<"source == NULL or file pointer == NULL "; 
          abort();
	}

      	Constant * stringConstant = ConstantDataArray::getString(*context, StringRef(source), true);
	GlobalVariable * globalString = new GlobalVariable(*M, stringConstant->getType(), true, GlobalValue::ExternalLinkage, stringConstant, "");

	// Initializing a FileNode for the file open instance
	FileNode * fileNode = new FileNode();
	fileNode->fd = callInst;
	fileNode->fileName = fileName;
	fileNode->fileSize = strlen(source);
	fileNode->filePosition = 0;
	fileNode->isSpecializable = true; // Initially the file is "specializable"
        fileNode->fileData = source;
	fileNode->globalString = globalString;
	fileDescriptors[callInst] = fileNode;
      }
      else{
	// Call cannot be resolved; File name is not constant
	return;
      }
    }
  }


  /* The addSeekCall function inserts a seek call to set the file descriptor to the correct position
     This is required when a read call encounters a non-constant offset and subsequent read calls
     cannot be specialised
  */
  void addSeekCall(Instruction * inst, FileNode * fileNode){

    std::vector<Value*> functionArgs;	
    IntegerType * int64Ty = IntegerType::get(*context, 64);
    IntegerType * int32Ty = IntegerType::get(*context, 32);	
    ConstantInt * byteOffset = ConstantInt::get(int64Ty, fileNode->filePosition);
    ConstantInt * seekWhence = ConstantInt::get(int32Ty, 0);

    functionArgs.push_back(fileNode->fd);
    functionArgs.push_back(byteOffset);
    functionArgs.push_back(seekWhence);

    Function * lseek = M->getFunction(StringRef("lseek"));
    CallInst::Create((Value*) lseek, ArrayRef<Value*>(functionArgs), Twine(""), inst); 
  }


  void resolveGetcCalls(CallInst *callInst, map<Instruction*, FileNode*> & fileDescriptors){
   
    Function * f = callInst->getCalledFunction();
    string functionName = f->getName().str();

    if(functionName == "fgetc" || functionName == "getc"){
      if(debugPrint) errs()<<"fgetc is being resolved ";   
      Value * fd;
      fd = callInst -> getOperand(0); // Only argument to fgetc is the file descriptor
      Instruction * openInst = dyn_cast<Instruction>(&*fd);
      GlobalVariable * globalString;
      FileNode * fileNode;

      if(debugPrint) errs()<<"open call : "<<*openInst<<"\n"; 
      
      if(fileDescriptors.find(openInst) != fileDescriptors.end()){
	fileNode = fileDescriptors[openInst];
	globalString = fileNode -> globalString;
      }
      else{
	if(debugPrint) errs()<<"!error: open call not found \n"<<*openInst<<"\n";
	return;
      }
        
      char outChar;     
      if(fileNode->filePosition  < fileNode->fileSize)
        outChar = fileNode->fileData[fileNode->filePosition++];
      else
        outChar = EOF; 
     
      IntegerType * intTy32 = IntegerType::get(*context, 32);     
      ConstantInt * returnChar;
      if(outChar != EOF)
        returnChar = ConstantInt::get(intTy32, outChar);
      else
        returnChar = ConstantInt::get(intTy32, -1); 
   
      AllocaInst * allocaOperand = new AllocaInst(intTy32, Twine(""), callInst);
      StoreInst * storeOperand = new StoreInst(returnChar, allocaOperand, callInst);      
      LoadInst * loadInst = new LoadInst(allocaOperand, Twine(""), false, callInst);      
      if(debugPrint) errs() <<"Store Operand :"<<*storeOperand<<"\n";
      replaceInstructions[callInst] = loadInst;
      if(debugPrint) errs()<<"\n*** Fgetc Specialized *** \n";
    }  
  }


  /* resolveReadCalls attempts at replacing the read calls with constant offsets.
     Read calls with constant offsets are replaced with "llvm.memcpy" instructions
     to copy the string contents from the file string to the user specified destination
     buffer. It is important to note that once a non constant offset is seen, the 
     file is marked as non-specializable. 
  */
  void resolveReadCalls(CallInst * callInst, map<Instruction*, FileNode*> & fileDescriptors){

    Function * f = callInst->getCalledFunction();
    string functionName = f->getName().str();

    if (functionName == "read" || functionName == "fread" ||  
        functionName == "fgets" || functionName == "fread_unlocked"){

      Value * destBuffer;
      Value * byteCount;
      Value * fd;

      if (functionName == "read"){
        fd = callInst -> getOperand(0);     
        destBuffer = callInst -> getOperand(1);
        byteCount = callInst -> getOperand(2);  
      }
      if (functionName == "fread" || functionName == "fread_unlocked"){
	// FIXIT: Assuming chunk size of 1 byte. 
        fd = callInst -> getOperand(3); 
        destBuffer = callInst -> getOperand(0);
        byteCount = callInst -> getOperand(2); 
      }
      if (functionName == "fgets"){
        fd = callInst -> getOperand(2); 
        destBuffer = callInst -> getOperand(0);
        byteCount = callInst -> getOperand(1); 
      }
    
      Instruction * openInst = dyn_cast<Instruction>(&*fd);
      GlobalVariable * globalString;
      FileNode * fileNode;   
      if (fileDescriptors.find(openInst) != fileDescriptors.end()){
	fileNode = fileDescriptors[openInst];
	globalString = fileNode -> globalString;
      }
      else{
	errs()<<"open call not found "<<*callInst<<"  \n";
	return;
      }

      /* If a non constant index has been used to read from the file the reads are no longer "specializable"  */
      if (fileNode->isSpecializable == false){
	return;
      }
 
      
      int intByteCount;	
      // FIXIT: These type definitions are redundant
      IntegerType * intTy = IntegerType::get(*context, 64);
      IntegerType * intTy32 = IntegerType::get(*context, 32);
      IntegerType * intTy1 = IntegerType::get(*context, 1);
      PointerType * charPtrType = Type::getInt8PtrTy(*context);
      ConstantPointerNull * nullPtr = ConstantPointerNull::get(charPtrType);
         
      if (ConstantInt * constInst = dyn_cast<ConstantInt>(&*byteCount)){

	if (debugPrint) errs()<<"Bytes read by call : "<< constInst->getZExtValue() <<"\n";
	intByteCount = constInst->getZExtValue();
        if (functionName == "fgets"){

          string dataStr = string(fileNode->fileData); // FIXIT: reusing full string - inefficient
          int pos = dataStr.find('\n', fileNode->filePosition);
          int lineBytes;
          if(pos != -1)
            lineBytes = pos - fileNode->filePosition;
          else
            lineBytes = fileNode->fileSize - fileNode->filePosition;
          if (lineBytes < intByteCount) {
            intByteCount = lineBytes + 1;  // +1 is added to include the '\n'
          }
        }        
      }
      else{     
        /* A non constant index returns the reads not "specializable"  */
        /* Partially constant file reads are supported */
	addSeekCall(callInst, fileNode);
	/*FIXIT: Add a lseek call to set the file position pointer of the file descriptor to its correct value */  		  fileNode->isSpecializable = false;
	return;
      }
  
      errs()<<"open Inst corresponding to fread being specialized : \n\n"<<*openInst<<"\n";       
      vector<Type*> argumentTypes;
      argumentTypes.push_back(Type::getInt8PtrTy(*context));
      argumentTypes.push_back(Type::getInt8PtrTy(*context));
      argumentTypes.push_back(Type::getInt64Ty(*context));
      argumentTypes.push_back(Type::getInt32Ty(*context));
      argumentTypes.push_back(Type::getInt1Ty(*context));
      
      FunctionType *FT = FunctionType::get(Type::getVoidTy(*context), argumentTypes, false);      
      /* FIXIT: Variable not required. getFunction and a check on NULL should have sufficed */
      Function * llvmMemcpy;
      llvmMemcpy = M->getFunction(StringRef("llvm.memcpy.p0i8.p0i8.i64"));

      if(llvmMemcpy == NULL){
	llvmMemcpy = Function::Create(FT, GlobalValue::ExternalLinkage, "llvm.memcpy.p0i8.p0i8.i64", M);
	//hasMemCpyRoutine = true;
      }
	       
      ConstantInt * index1 = ConstantInt::get(intTy, 0);
      // Alignment should be 0 or 1 (no alignment) if arguments are not allowed to a boundary 
      ConstantInt * align = ConstantInt::get(intTy32, 0);
      ConstantInt * isvolatile = ConstantInt::get(intTy1, 0);
      Value * numBytes = NULL;
      bool callMemcpy = true;
      int originalFilePtr = fileNode->filePosition;

      if(fileNode->filePosition + intByteCount <= fileNode->fileSize){
        fileNode->filePosition += intByteCount;
        numBytes = byteCount;
        if (functionName == "fgets"){
          numBytes = ConstantInt::get(intTy, intByteCount); // Exclude '\n' character copy  
        }
      }
      else{
        int truncatedBytes = fileNode->fileSize - fileNode->filePosition;
        fileNode->filePosition = fileNode->fileSize;     
        numBytes = ConstantInt::get(intTy, truncatedBytes);
        if(truncatedBytes == 0) callMemcpy = false;
      }

      vector<Value *> indxList;
      indxList.push_back(index1);
      // -- Each read is replaced by a constant global string - indices are {0,0}
      indxList.push_back(index1);

      if(callMemcpy){ 
        char readStr[65536];
        memcpy(readStr, &fileNode->fileData[originalFilePtr], intByteCount);
        readStr[intByteCount] = '\0';
        if(debugPrint) errs()<<"readStr = "<<readStr<<"\n";

        Constant * stringConstant = ConstantDataArray::getString(*context, StringRef(readStr), true);
	GlobalVariable * globalReadString = new GlobalVariable(*M, stringConstant->getType(), true, 
                                                               GlobalValue::ExternalLinkage, stringConstant, "");
        GetElementPtrInst * stringPtr = GetElementPtrInst::Create(NULL, globalReadString, indxList, Twine(""), callInst);
        ConstantInt * copyBytes = ConstantInt::get(intTy, intByteCount + 1);
        std::vector<Value*> functionArgs;
        functionArgs.push_back(destBuffer);
	functionArgs.push_back(stringPtr);
	functionArgs.push_back(copyBytes);
	functionArgs.push_back(align);
	functionArgs.push_back(isvolatile);
	CallInst::Create((Value*) llvmMemcpy, ArrayRef<Value*>(functionArgs), Twine(""), callInst); 
      }

      if (functionName == "fgets"){
        if (callMemcpy)
	  replaceValues[callInst] = destBuffer;
	else
          replaceValues[callInst] = nullPtr;   
      }
      else{
        AllocaInst * allocaOperand = new AllocaInst(intTy, Twine(""), callInst);
        StoreInst * storeOperand = new StoreInst(numBytes, allocaOperand, callInst);      
        LoadInst * loadInst = new LoadInst(allocaOperand, Twine(""), false, callInst); 
        if(debugPrint) errs() <<"Store Operand :"<<*storeOperand<<"\n";
        replaceInstructions[callInst] = loadInst;
      }
      errs()<<"\n**** read call Specialized ****\n";	  
    }
  }

  
  /* The seek calls need to be properly handled.
     Specifically the file position pointer in the "FileNode"
     object for the corresponding file needs to be updated 
  */
  void resolveSeekCalls(CallInst * callInst, map<Instruction*, FileNode*> & fileDescriptors){

    Function * f = callInst->getCalledFunction();
    string functionName = f->getName().str();

    if(functionName == "lseek"){
      Value * fd = callInst->getOperand(0);
      if(debugPrint) errs()<<"Seek call : "<<*fd <<"\n";
      Instruction * openInst = dyn_cast<Instruction>(&*fd);
      FileNode * fileNode;
      if(fileDescriptors.find(openInst) != fileDescriptors.end()){
	fileNode = fileDescriptors[openInst];
      }
      else{
	if(debugPrint) errs()<<"!error: No open call corresponding to descriptor used in seek call \n";
	return;
      }

      Value * offset = callInst->getOperand(1);
      Value * whence = callInst->getOperand(2);
      int intByteOffset = 0;	

      if(ConstantInt * constInst = dyn_cast<ConstantInt>(&*offset)){
	if(debugPrint) errs()<<"Constant offset : "<< constInst->getZExtValue() <<"\n";
	intByteOffset = constInst->getZExtValue();
      }
      else{     /* A non constant index returns the reads not "specializable"  */
	addSeekCall(callInst, fileNode);
	/*FIXIT: Add a lseek call to set the file position pointer of the file descriptor to its correct value */
	fileNode->isSpecializable = false;
	return;
      }

      int intWhence;
      if(ConstantInt * constInst = dyn_cast<ConstantInt>(&*whence)){
	intWhence = constInst->getZExtValue();
      }
      else{     /* A non constant index returns the reads not "specializable"  */
	errs()<<"!error: Unsupported Value for whence \n";
	abort();
	return;
      }

      switch(intWhence){			
        case SEEK_SET: fileNode->filePosition = intByteOffset; fileNode->isSpecializable = true; break;
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


  void replaceUses(){
    for (auto & e : replaceValues){
      e.first -> replaceAllUsesWith(e.second);
      e.first->dropAllReferences();
      e.first->removeFromParent();
    }  
  }


  /* FIXIT : Cleaup intialization */
  /* Initialization routine */
  void initialization(Module & module){

    M = &module;    	
    context = &M->getContext();
    hasMemCpyRoutine = false;
    // If the lseek function doesnt exist, create a prototype
    if(M->getFunction(StringRef("lseek")) == NULL){

      vector<Type*> argumentTypes;
      argumentTypes.push_back(Type::getInt64Ty(*context));
      argumentTypes.push_back(Type::getInt64Ty(*context));
      argumentTypes.push_back(Type::getInt64Ty(*context));

      FunctionType *FT = FunctionType::get(Type::getInt64Ty(*context), argumentTypes, false);
      Function * lseek;
      lseek = Function::Create(FT, GlobalValue::ExternalLinkage, "lseek", M);
    }
  }


  void runOnBB(BasicBlock * BB, map<Instruction*, FileNode*> fileDescriptors, map<BasicBlock*, bool> visited){
   
    BasicBlock& b = *BB;
    for (BasicBlock::iterator inst = b.begin(), ie = b.end(); inst != ie; ) {

      Instruction * I = &(*inst++);
      if(CallInst * callInst = dyn_cast<CallInst>(&*I)){	 
	if(callInst != NULL && callInst->getCalledFunction() != NULL 
	   && !callInst->getCalledFunction()->isIntrinsic()) {

	  resolveOpenCalls(callInst, fileDescriptors);
	  resolveReadCalls(callInst, fileDescriptors);
	  resolveGetcCalls(callInst, fileDescriptors);
	  resolveSeekCalls(callInst, fileDescriptors);
	}
      }

      else if(BranchInst * branchInst = dyn_cast<BranchInst>(&*I)){
        
	for(unsigned int index = 0; index < branchInst->getNumSuccessors(); index++){
	  BasicBlock * successor = branchInst->getSuccessor(index);
          if(visited.find(successor) != visited.end()){
            continue; // Skip visited basic block
	  }

	  // Forward context to successor block if the successor has only a single predecessor & isNotVisited
	  if(successor->getUniquePredecessor() ) {
	    visited[successor] = true; 
	    errs()<<"Successor has single predecessor \n";
	    runOnBB(successor, fileDescriptors, visited);
	  }    
	  else{
	    errs()<<"block has multiple predecessors - creating new context \n";
	    // Passing empty context
	    map<Instruction*, FileNode*> fileDescriptors_new;
	    runOnBB(successor, fileDescriptors_new, visited);
	  }             
	}         	
      }


    }
  } 
  


  virtual bool runOnModule(Module & module) {

    if(debugPrint) errs()<<"\n\n ----------- File IO Spec --------- \n\n";
    initialization(module);

    // Find all bitcast instructions within stores, calls etc. These must be bitcasting from globals to type*
    for (Module::iterator F = M->begin(), Fend = M->end(); F != Fend; ++F) {

      Function * func = &*F;
      if (F->isDeclaration()) continue; // Skip function declarations

      map<Instruction*, FileNode*> fileDescriptors;
      map<BasicBlock*, bool> visited; 

      BasicBlock * entry = &(func->getEntryBlock());
      runOnBB(entry, fileDescriptors, visited);           
    }

    replaceReadCalls();
    replaceUses();

    if(debugPrint) errs()<<"\n----- End of File IO pass ---- \n";
    return true;
  }

};


char FileIOPass::ID = 0;
static RegisterPass<FileIOPass> X("fileIO", "Specialising FILE System operations", false, false);
