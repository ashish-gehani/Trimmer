
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
#include "parse_args.h"

using namespace llvm;
using namespace std;


static cl::opt<string> args("args",
                  cl::desc("' ' space seperated argument list"));
GlobalVariable*
materializeStringLiteral(llvm::Module& m, const char* data) {
    Constant* ary = llvm::ConstantDataArray::getString(m.getContext(), data, true);
    GlobalVariable* gv = new GlobalVariable(m, ary->getType(), true, GlobalValue::LinkageTypes::PrivateLinkage, ary, "");
    gv->setConstant(true);
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
        int index_count = arguments.size();
        for(unsigned i = 0; i < arguments.size(); i++)
            errs() << arguments[i] << "\n";
        IntegerType* int64Ty = IntegerType::get(M.getContext(), 64);
        IntegerType* int32Ty = IntegerType::get(M.getContext(), 32);
        IntegerType* int8Ty = IntegerType::get(M.getContext(), 8);
        IntegerType * int1Ty = IntegerType::get(M.getContext(), 1);

        //Setting argc... 
        Function* _main = M.getFunction(StringRef("main"));
        ConstantInt* argcConst = ConstantInt::get(int32Ty, index_count);
        Function::arg_iterator ai = _main->arg_begin();
        Value* argc = (Value*) &(*ai);
        argc->replaceAllUsesWith(argcConst);   

        // Setting argv 
        ai++;
        Value* argv = (Value*) &(*ai);
        BasicBlock* origbb = &*(_main->begin());
        BasicBlock* bb = BasicBlock::Create(M.getContext());
        _main->getBasicBlockList().push_front(bb);
        IRBuilder<> ir(bb);

        Function * mf = M.getFunction(StringRef("malloc"));         
        Function * mcf = M.getFunction(StringRef("llvm.memcpy.p0i8.p0i8.i64"));         

        ConstantInt * align = ConstantInt::get(int32Ty, 0);
        ConstantInt * isvolatile = ConstantInt::get(int1Ty, 0);
        ConstantPointerNull* nptr1 = ConstantPointerNull::get(dyn_cast<PointerType>(argv->getType()));
        ConstantPointerNull* nptr2 = ConstantPointerNull::get(PointerType::get(int8Ty, 0));

        vector<Value*> globals; 
        for(unsigned i = 0; i < arguments.size(); i++) {
            errs() << "creating global for " << arguments[i] << "\n";
            GlobalVariable* gv = materializeStringLiteral(M, arguments[i].c_str());
            auto* gvT = gv->getType();
            auto* sty = cast<SequentialType>(gvT);
            globals.push_back(ir.CreateConstGEP2_32(sty->getElementType(), gv, 0, 0));
        }
        errs() << "creating argv_new\n";
        GlobalVariable * argv_new = new GlobalVariable(M, argv->getType(), false, GlobalValue::ExternalLinkage, nptr1, Twine("__argv_new__"));
        // Value * argv_new = ir.CreateConstGEP1_32(gv, 0);
        errs() << *argv_new << "\n";
        vector<Value *> args;
        args.push_back(ConstantInt::get(int64Ty, (index_count + 1) * 8)); 
        CallInst * mallocCall =  ir.CreateCall(mf, ArrayRef<Value *>(args));
        Value * bitcast =  ir.CreateBitCast(mallocCall, argv->getType());
        ir.CreateStore(bitcast, argv_new);   
        unsigned copy_index = 1;
        for (unsigned i = 0; i < arguments.size(); i++) {
            Value * lptr = ir.CreateLoad(argv_new);
            Value * newArgptr = ir.CreateConstGEP1_32(lptr, i);
            if(arguments[i] != "_") {
                vector<Value *> args;
                ConstantInt * stringSize = ConstantInt::get(int64Ty, 100);
                args.push_back(stringSize);
                CallInst * mallocCall =  ir.CreateCall(mf, ArrayRef< Value *>(args));
                ir.CreateStore(mallocCall, newArgptr); 
                Value * destPtr = ir.CreateLoad(newArgptr);
                errs() << arguments[i] << " " << i << "\n";
                std::vector<Value*> functionArgs;
                functionArgs.push_back(destPtr);
                functionArgs.push_back(globals[i]);
                functionArgs.push_back(stringSize);
                functionArgs.push_back(align);
                functionArgs.push_back(isvolatile);
                ir.CreateCall(mcf, ArrayRef<Value*>(functionArgs));
            } else {
                errs() << "_" << i << "\n";
                errs() << *argv << "\n";
                Value* oldArgptr = ir.CreateConstGEP1_32(argv, copy_index);
                Value* load = ir.CreateLoad(oldArgptr);   
                ir.CreateStore(load, newArgptr);                             
                copy_index++;
            }
        }
        Value * lptr = ir.CreateLoad(argv_new);
        Value* argptr = ir.CreateConstGEP1_32(lptr, arguments.size());
        ir.CreateStore(nptr2, argptr);        
        replaceUsesOutsideBlock(argv, lptr, bb);
        ir.CreateBr(origbb);
        return true;
    }
  };
}
char addArguments::ID = 0;
	static RegisterPass<addArguments>
	W("specialize-args", "Argument Specialization");
