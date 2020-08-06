
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/CommandLine.h"
#include <string> 
#include <unistd.h> 
#include "parse_args.h"
#include "processInstructions.h"
#include <fstream>

using namespace llvm;
using namespace std;

#define debugPrint 0

static cl::opt<string> func_name("func_name",
			    cl::desc("Name of function to be removed"));


namespace {

  struct RemFuncBody : public ModulePass {

    static char ID;
    RemFuncBody() : ModulePass(ID) {}

    void emptyFunc(Function *target_func){

      if(debugPrint) errs()<<*target_func<<"\n";
      target_func->dropAllReferences();
      target_func->setLinkage(GlobalValue::InternalLinkage);

      // Adding a dummy return to the emptied function - to avoid it from becoming a declaration
      BasicBlock *bb = BasicBlock::Create(target_func->getContext(), "", target_func);      
      Type *returnType = target_func->getReturnType();
      if(debugPrint) errs()<<"returnType = "<<*returnType<<"\n";

      if(returnType->isVoidTy()){
	if(debugPrint) errs()<<"***Void Type \n";
	ReturnInst *retInst = ReturnInst::Create(target_func->getContext(), bb);
      }
      else if(returnType->isIntegerTy()){
	if(debugPrint) errs()<<"***Integer Type \n";
	Constant *constInt = ConstantInt::get(returnType, 0, false);
	ReturnInst *retInst = ReturnInst::Create(target_func->getContext(), constInt, bb);
      }
      else if(returnType->isFloatTy()){
	if(debugPrint) errs()<<"*** Float Type \n";
	Constant *constFP = ConstantFP::get(returnType, 0);
	ReturnInst *retInst = ReturnInst::Create(target_func->getContext(), constFP, bb);
      }
      else if(returnType->isPointerTy()){
	if(debugPrint) errs()<<"*** Pointer Type \n";
	PointerType *pType = dyn_cast<PointerType>(returnType);
	ConstantPointerNull *constPtr = ConstantPointerNull::get(pType);
	ReturnInst *retInst = ReturnInst::Create(target_func->getContext(), constPtr, bb);
      }
      else{
	if(debugPrint) errs()<<"Unsupported Type = "<<*returnType<<"\n";
      }
     
      if(debugPrint) errs()<<"target_func = "<<*target_func<<"\n";
    }


    bool runOnModule(Module& M) {
     
      if(func_name != ""){
        std::string func_name_str = func_name.c_str();
	if(debugPrint) errs()<<"func_name_str = "<<func_name_str<<"\n";
	Function *target_func = M.getFunction(StringRef(func_name_str));
	if(target_func != NULL){
	  emptyFunc(target_func);
	}
	else 
	  printf("no function with name : target");
      }

      return true;
    } // end of runOnModule


  };
}
char RemFuncBody::ID = 0;
static RegisterPass<RemFuncBody> W("rem-func-body", "Clear function body");


