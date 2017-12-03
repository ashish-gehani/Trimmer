
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/CommandLine.h"
#include <llvm/Analysis/LoopInfo.h>
#include "llvm/IR/IRBuilder.h"
#include <string> 
#include <unistd.h> 
#include "parse_args.h"

using namespace llvm;
using namespace std;

#define debugPrint 0 

static cl::opt<string> args("args",
                  cl::desc("':' colon seperated argument list"));

namespace {

 struct LibSimplify : public FunctionPass {

   static char ID; // Pass identification, replacement for typeid
   LibSimplify() : FunctionPass(ID) {} 
   void getAnalysisUsage(AnalysisUsage &AU) const { 
     AU.addRequired<LoopInfoWrapperPass>();
    }
  IntegerType * int1Ty = NULL;
  IntegerType * int8Ty = NULL;
  IntegerType * int32Ty = NULL;
  IntegerType * int64Ty = NULL;
  bool spec = false;
  char ** argv;
  int argc;
  void initOptargConst(CallInst * callInst, Function * func) {
    
    Module * M = func->getParent();
    Constant * stringConstant = ConstantDataArray::getString(func->getParent()->getContext(), 
                                                             StringRef(optarg), true);
    GlobalVariable * globalString = new GlobalVariable(*func->getParent(), stringConstant->getType(), 
                                                       true, GlobalValue::ExternalLinkage, stringConstant, "");

    GlobalVariable * optargVar =  M->getNamedGlobal(StringRef("optarg"));

    vector<Type*> argumentTypes;
    argumentTypes.push_back(Type::getInt8PtrTy(M->getContext()));
    argumentTypes.push_back(Type::getInt8PtrTy(M->getContext()));
    argumentTypes.push_back(Type::getInt64Ty(M->getContext()));
    argumentTypes.push_back(Type::getInt32Ty(M->getContext()));
    argumentTypes.push_back(Type::getInt1Ty(M->getContext()));

    FunctionType * FT = FunctionType::get(Type::getVoidTy(M->getContext()), argumentTypes, false);      
    Function * llvmMemcpy = M->getFunction(StringRef("llvm.memcpy.p0i8.p0i8.i64"));
    if(!llvmMemcpy)
      llvmMemcpy = Function::Create(FT, GlobalValue::ExternalLinkage, "llvm.memcpy.p0i8.p0i8.i64", M);

    ConstantInt * zeroIndex = ConstantInt::get(int32Ty, 0);
    ConstantInt * align = ConstantInt::get(int32Ty, 0);
    ConstantInt * isvolatile = ConstantInt::get(int1Ty, 0);

    vector<Value *> indxList;
    indxList.push_back(zeroIndex);
    indxList.push_back(zeroIndex);       
    GetElementPtrInst * stringPtr = GetElementPtrInst::Create(globalString->getType()->getContainedType(0), 
                                                              globalString, 
                                                              indxList, Twine(""), callInst);
    ConstantInt * size = ConstantInt::get(int64Ty, strlen(optarg) + 1);
    vector<Value *> args;
    args.push_back(size);
    Function * F = M->getFunction(StringRef("malloc"));
    CallInst * mallocInst = CallInst::Create(F->getFunctionType(), F, ArrayRef<Value*>(args),
     Twine(""), callInst);
    
    if(debugPrint) errs() << *mallocInst << "\n";
    StoreInst * storeInst = new StoreInst(mallocInst, optargVar, callInst); 

    LoadInst * destPtr = new LoadInst(optargVar, Twine(""), callInst);    
    ConstantInt * copyBytes = ConstantInt::get(int64Ty, strlen(optarg) + 1);
    std::vector<Value*> functionArgs;
    functionArgs.push_back(destPtr);
    functionArgs.push_back(stringPtr);
    functionArgs.push_back(copyBytes);
    functionArgs.push_back(align);
    functionArgs.push_back(isvolatile);
    CallInst::Create((Value*) llvmMemcpy, ArrayRef<Value*>(functionArgs), Twine(""), callInst); 
  }

  void initOptargRunTime(CallInst * callInst, Function * func) {
    Module * M = func->getParent();
    Value * argv_new =  M->getNamedGlobal(StringRef("__argv_new__"));   
    GlobalVariable * optargVar =  M->getNamedGlobal(StringRef("optarg"));
    IRBuilder<> ir(callInst);
    Value * load1 = ir.CreateLoad(argv_new);
    Value * gep = ir.CreateConstGEP1_32(load1, optind - 1);
    Value * load2 = ir.CreateLoad(gep);
    ir.CreateStore(load2, optargVar);        
  }
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

    void initializeArgs(int argc, char * argv[]){
      this->argc = argc;
      this->argv = argv;
    } 


    void specializeGetOpt(CallInst * callInst, Function * func){
       
      Module * M = func->getParent();
      Value * optstringOperand = callInst->getOperand(2);

      if(Constant * constString = dyn_cast<Constant>(&*optstringOperand)) {        
        StringRef optstringRef;
        getConstantStringInfo(optstringOperand, optstringRef);
        string optstring = optstringRef.str();
        int option = getopt(argc, argv, optstring.c_str());
        if(debugPrint) errs() << "option is " << (char) option << " optind is " << optind << "\n";
        if(option == -1 && !spec) {
          errs() << "no change made\n";
          return;
        }
        spec = true;
        if(optarg != NULL) {
          if(strcmp(optarg, "_"))
            initOptargConst(callInst, func);
          else
            initOptargRunTime(callInst, func);
        }

        GlobalVariable * optindVar =  M->getNamedGlobal(StringRef("optind"));
        GlobalVariable * opterrVar =  M->getNamedGlobal(StringRef("opterr"));
        GlobalVariable * optoptVar =  M->getNamedGlobal(StringRef("optopt"));

        if(optindVar != NULL) { 
          ConstantInt * optindConst = ConstantInt::get(int32Ty, optind);
          StoreInst * optindStore = new StoreInst(optindConst, optindVar, callInst);
        }

        if(optoptVar != NULL){
          ConstantInt * optoptConst = ConstantInt::get(int32Ty, optopt);
          StoreInst * optoptStore = new StoreInst(optoptConst, optoptVar, callInst);
        }

        if(opterrVar != NULL){ 
          ConstantInt * opterrConst = ConstantInt::get(int32Ty, opterr);
          StoreInst * opterrStore = new StoreInst(opterrConst, opterrVar, callInst);
        }        
     
        ConstantInt * getoptResult = ConstantInt::get(int32Ty, option);  
        callInst->replaceAllUsesWith(getoptResult);
        callInst->eraseFromParent();
      }
    }
    
    virtual bool runOnFunction(Function & F) {
      Function * func = &F;
      spec = false;
      int64Ty = IntegerType::get(func->getContext(), 64);
      int32Ty = IntegerType::get(func->getContext(), 32);
      int8Ty = IntegerType::get(func->getContext(), 8); 
      int1Ty = IntegerType::get(func->getContext(), 1);

      for(Function::iterator b = func->begin(), e = func->end(); b != e; ++b) {
        BasicBlock *BB = &*b;
        for(BasicBlock::iterator it = BB->begin(), it2 = BB->end(); it != it2; it++) {
          if(CallInst * callInst = dyn_cast<CallInst>(&*it)) {
            if(callInst != NULL && callInst->getCalledFunction() != NULL 
                  && !callInst->getCalledFunction()->isIntrinsic()) {
              Function * callee = callInst->getCalledFunction();
              std::string functionName = callee->getName().str();
              if(functionName == "getopt_long" || functionName == "getopt") {
                if(debugPrint) errs() << F.getName() << " " << spec << "\n";
                char** arr = new char*[10];
                int argc = parse_args(args, arr);
                initializeArgs(argc, arr);
                specializeGetOpt(callInst, func);
                break;           
              }
            }
          }      
        }
      }
      return true;
    }
  };
}

char LibSimplify::ID = 0;
static RegisterPass<LibSimplify> X("lib-simplify", "Simplifying library calls", false, false);
