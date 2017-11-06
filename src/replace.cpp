
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/CommandLine.h"
#include <string> 
#include <unistd.h> 

using namespace llvm;
using namespace std;

namespace {
  struct Replace : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    Replace() : ModulePass(ID) {}
    virtual bool runOnModule(Module &M) {

      IntegerType * intTy1 = IntegerType::get(M.getContext(), 1);
			IntegerType * int32Ty = IntegerType::get(M.getContext(), 32);
			IntegerType * int64Ty = IntegerType::get(M.getContext(), 64);

	    ConstantInt * zeroIndex = ConstantInt::get(int32Ty, 0);	    
	    ConstantInt * align = ConstantInt::get(int32Ty, 0);
	    ConstantInt * isvolatile = ConstantInt::get(intTy1, 0);    
	    vector<Value *> indxList;
	    indxList.push_back(zeroIndex);
	    indxList.push_back(zeroIndex);

      Function * llvmMemcpy = M.getFunction(StringRef("llvm.memcpy.p0i8.p0i8.i64"));
			Function * llvmMalloc = M.getFunction(StringRef("malloc"));
    	
    	int args[4] = {'b', 'p', 175, 'F'};
    	char * optargs[4] = {NULL, "MJPEG", "myfile.jpeg", "1"};
    	int index = 0;
    	vector<Instruction *> toRemove;
			for(Module::iterator mit = M.getFunctionList().begin(); 
				mit != M.getFunctionList().end(); ++mit) {
				for (Function::iterator f_it = mit->begin(), f_ite = mit->end(); 
					f_it != f_ite; ++f_it) {
					for(BasicBlock::iterator b_it = f_it->begin(), b_ite = f_it->end(); 
						b_it != b_ite; ++b_it) {
						Instruction* I = &*b_it; 
						if(CallInst * ci = dyn_cast<CallInst>(I)) {
							Function * F = ci->getCalledFunction();
							if(F && F->getName() == "fswc_getopt") {
								ConstantInt * val;
								if(index == 4)
									val = ConstantInt::get(int32Ty, -1);
								else
									val = ConstantInt::get(int32Ty, args[index]);
								errs() << *val << "\n";
								ci->replaceAllUsesWith(val);
								toRemove.push_back(ci);
								if(index == 4)
									goto end;
								if(optargs[index]) {
          				ConstantInt * size = ConstantInt::get(int64Ty, strlen(optargs[index]) + 1);
									GlobalVariable * optargVar =  M.getNamedGlobal(StringRef("optarg"));
				          vector<Value *> fargs;
				          fargs.push_back(size);
				          CallInst * mallocInst = CallInst::Create(llvmMalloc->getFunctionType(), llvmMalloc, ArrayRef<Value*>(fargs),
				           Twine(""), ci);

				          StoreInst * storeInst = new StoreInst(mallocInst, optargVar, ci); 
				          LoadInst * destPtr = new LoadInst(optargVar, Twine(""), ci);    
									errs() << *mallocInst << " " << *storeInst << " " << *destPtr << "\n"; 
				          Constant * stringConstant = ConstantDataArray::getString(M.getContext(), 
				                                                                   StringRef(optargs[index]), true);

				          errs() << *stringConstant << "\n";
				          GlobalVariable * globalString = new GlobalVariable(M, stringConstant->getType(), 
				                                                             true, GlobalValue::ExternalLinkage, stringConstant, "");

				          errs() << *globalString << "\n";
				          GetElementPtrInst * stringPtr = GetElementPtrInst::Create(globalString->getType()->getContainedType(0), 
                                                                    globalString, 
                                                                    indxList, Twine(""), ci);
				          errs() << *stringPtr << "\n";

				          std::vector<Value*> functionArgs;
				          functionArgs.push_back(destPtr);
				          functionArgs.push_back(stringPtr);
				          functionArgs.push_back(size);
				          functionArgs.push_back(align);
				          functionArgs.push_back(isvolatile);
				          CallInst::Create((Value*) llvmMemcpy, ArrayRef<Value*>(functionArgs), Twine(""), ci); 
								}
								index++;
							}
						}
					}
				}
			}
			end:
			for(unsigned i = 0; i < toRemove.size(); i++)
				toRemove[i]->eraseFromParent();
	    return true;
    }
  };
}

char Replace::ID = 0;
static RegisterPass<Replace> X("replace", "Replace Pass", false, false);
