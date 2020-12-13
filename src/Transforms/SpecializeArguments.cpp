// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//This pass creates a global variable for each command-line argument provided in the manifest file. It creates a new global variable argv_new (a character double pointer) and sets it to global variables made for each command-line argument by adding instructions at the start of the main function.

#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
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
#include "ParseArgs.h"
#include "Debug.h"

using namespace llvm;
using namespace std;


static cl::opt<string> args("args",
			    cl::desc("' ' space seperated argument list"));
GlobalVariable*
materializeStringLiteral(llvm::Module& m, const char* data) {
  Constant * ary = ConstantDataArray::getString(m.getContext(), StringRef(data), false);
  GlobalVariable * gv = new GlobalVariable(m, ary->getType(), true, GlobalValue::PrivateLinkage, ary);
  return gv;
}
 
void replaceUsesOutsideBlock(Value* Old, Value *New, BasicBlock *BB) {

  Value::use_iterator UI = Old->use_begin(), E = Old->use_end();
  for (; UI != E;) {
    Use &U = *UI;
    ++UI;
    Instruction* Usr = dyn_cast<Instruction>(U.getUser());
    if (Usr && Usr->getParent() == BB)
      continue;
    U.set(New);
  }
  return; 
}
namespace {
  struct addArguments : public ModulePass {
    static char ID;
    addArguments() : ModulePass(ID) {}
    bool runOnModule(Module& M) {
      vector<string> arguments = parse_args(args);
      initDebugLevel();
      int index_count = arguments.size();
      for(unsigned i = 0; i < arguments.size(); i++)
        debug(Yes) << arguments[i] << "\n";
      IntegerType* int64Ty = IntegerType::get(M.getContext(), 64);
      IntegerType* int32Ty = IntegerType::get(M.getContext(), 32);
      IntegerType* int8Ty = IntegerType::get(M.getContext(), 8);
      IntegerType * int1Ty = IntegerType::get(M.getContext(), 1);

      //Setting argc... 
      Function* _main = M.getFunction(StringRef("main"));
      ConstantInt* argcConst = ConstantInt::get(int32Ty, index_count);
      Function::arg_iterator ai = _main->arg_begin();
      Value* argc = (Value*) &(*ai); 
      /*
      for(auto use: argc->users()) {
        if(auto I = dyn_cast<Instruction>(use)) {
          debug(Yes) << *I << "\n";
          LLVMContext &C = I->getContext();
          MDNode *N = MDNode::get(C, MDString::get(C, "1"));
          I->setMetadata("track_argc", N);
        }
      }*/
      argc->replaceAllUsesWith(argcConst);   
      

      // Setting argv 
      ai++;
      Value* argv = (Value*) &(*ai);
      BasicBlock* origbb = &*(_main->begin());
      BasicBlock* bb = BasicBlock::Create(M.getContext());
      _main->getBasicBlockList().push_front(bb);
      IRBuilder<> ir(bb);

      Function * mallocFunc = M.getFunction(StringRef("malloc")); 
      vector<Type *> mallocArgs;
      mallocArgs.push_back(Type::getInt64Ty(M.getContext()));
      FunctionType * mallocFT = FunctionType::get(Type::getInt8PtrTy(M.getContext()), mallocArgs, false);      
      
      if(!mallocFunc)
      	mallocFunc= Function::Create(mallocFT, GlobalValue::ExternalLinkage, "malloc", &M);
	
      Function * llvmMemCpyFunc = M.getFunction(StringRef("llvm.memcpy.p0i8.p0i8.i64"));  

      vector<Type*> llvmMemCpyArgs;
      llvmMemCpyArgs.push_back(Type::getInt8PtrTy(M.getContext()));
      llvmMemCpyArgs.push_back(Type::getInt8PtrTy(M.getContext()));
      llvmMemCpyArgs.push_back(Type::getInt64Ty(M.getContext()));
      //llvmMemCpyArgs.push_back(Type::getInt32Ty(M.getContext())); [LLVM-7 shifts alignment to parameter attribute instead of function argument]
      llvmMemCpyArgs.push_back(Type::getInt1Ty(M.getContext()));

      FunctionType * llvmMemCpyFT = FunctionType::get(Type::getVoidTy(M.getContext()), llvmMemCpyArgs, false);      
      if(!llvmMemCpyFunc){
        debug(Yes)<<"llvmMemCpyFT not found in module\n";
      	llvmMemCpyFunc = Function::Create(llvmMemCpyFT, GlobalValue::ExternalLinkage, "llvm.memcpy.p0i8.p0i8.i64", &M);
      }

      ConstantInt * align = ConstantInt::get(int32Ty, 0);
      ConstantInt * isvolatile = ConstantInt::get(int1Ty, 0);
      ConstantInt * strTerm = ConstantInt::get(int8Ty, 0);

      ConstantPointerNull* nptr1 = ConstantPointerNull::get(dyn_cast<PointerType>(argv->getType()));
      ConstantPointerNull* nptr2 = ConstantPointerNull::get(PointerType::get(int8Ty, 0));

      vector<Value*> globals; 
      for(unsigned i = 0; i < arguments.size(); i++) {
        debug(Yes) << "creating global for " << arguments[i] << "\n";
        GlobalVariable* gv = materializeStringLiteral(M, arguments[i].c_str());
        PointerType * gvT = gv->getType();
        globals.push_back(ir.CreateConstGEP2_32(gvT->getElementType(), gv, 0, 0));
      }

      debug(Yes) << "creating argv_new\n";
      GlobalVariable * argv_new = new GlobalVariable(M, argv->getType(), false, 
      		     GlobalValue::ExternalLinkage, nptr1, Twine("__argv_new__"));

      LLVMContext &C = argv_new->getContext();
      MDNode *N = MDNode::get(C, ConstantAsMetadata::get(ConstantInt::get(Type::getInt64Ty(C), 0))); 
      ((GlobalObject*)argv_new)->setMetadata("track", N);

      debug(Yes) << *argv_new << "\n";
      vector<Value *> args;
      args.push_back(ConstantInt::get(int64Ty, (index_count + 1) * 8)); 
      CallInst * mallocCall =  ir.CreateCall(mallocFunc, ArrayRef<Value *>(args));
      Value * bitcast =  ir.CreateBitCast(mallocCall, argv->getType());
      ir.CreateStore(bitcast, argv_new);   
      for (unsigned i = 0; i < arguments.size(); i++) {
        Value * lptr = ir.CreateLoad(argv_new);
        Value * newArgptr = ir.CreateConstGEP1_32(lptr, i);
        if(arguments[i] != "_") {
          vector<Value *> args;
          ConstantInt * stringSize = ConstantInt::get(int64Ty, 100);
          args.push_back(stringSize);
          CallInst * mallocCall =  ir.CreateCall(mallocFunc, ArrayRef< Value *>(args));
          ir.CreateStore(mallocCall, newArgptr); 
          Value * destPtr = ir.CreateLoad(newArgptr);

          //TODO: Do we need to set alignment for parameters?

          debug(Yes) << arguments[i] << " " << i << "\n";
          std::vector<Value*> functionArgs;
          functionArgs.push_back(destPtr);
          functionArgs.push_back(globals[i]);
          functionArgs.push_back(stringSize);
          functionArgs.push_back(isvolatile);
          ir.CreateCall(llvmMemCpyFunc, ArrayRef<Value*>(functionArgs));
          Value * gep = ir.CreateConstGEP1_32(destPtr, arguments[i].size());
          ir.CreateStore(strTerm, gep);
        } else {
          debug(Yes) << "_" << i << "\n";
          debug(Yes) << *argv << "\n";
          Value* oldArgptr = ir.CreateConstGEP1_32(argv, i);
          Value* load = ir.CreateLoad(oldArgptr);   
          ir.CreateStore(load, newArgptr);                             
        }
      }
      Value * lptr = ir.CreateLoad(argv_new);
      Value* argptr = ir.CreateConstGEP1_32(lptr, arguments.size());
      ir.CreateStore(nptr2, argptr);        
      replaceUsesOutsideBlock(argv, lptr, bb);
      ir.CreateBr(origbb);
      debug(Yes)<<"Specialize-args pass completed...\n";
      return true;
    }
  };
}
char addArguments::ID = 0;
static RegisterPass<addArguments>
W("specialize-args", "Argument Specialization");
