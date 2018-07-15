/* This Pass identifies and annotates program configuration structures */

#include "llvm/Transforms/Scalar.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BlockFrequencyInfoImpl.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/Loads.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/ValueHandle.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionAliasAnalysis.h"
#include "llvm/Analysis/ScalarEvolutionExpander.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include <map>
#include <vector>
#include <fstream>

#include "../include/VecUtils.h"
#include "../include/Debug.h"

using namespace llvm;
using namespace std;

#define debugPrint 1


struct Alloca {
  Value * val;  
  Function *parentFunction;
  bool isArgv;

  int arg;
  bool global;
  vector<Function *> loaders;
  vector<Function *> storers;
};

int AllocCount = 0;
int FuncInfoCount = 0;
Alloca * initAlloca(Value * val, Function * F, bool isArgv, int arg) {
  AllocCount++;
  Alloca * alloca = new Alloca;
  alloca->val = val;
  alloca->parentFunction = F;
  alloca->isArgv = isArgv;
  alloca->arg = arg;
  alloca->global = isa<GlobalVariable>(val);
  return alloca;
}

struct FuncInfo {
  vector<Alloca *> args;
  vector<Value *> usedGlobals;
  vector<Alloca *> allocas;
};

struct Annotate : public ModulePass {

  static char ID; 
  
  Annotate(): ModulePass(ID){}

  vector<Function *> loadsArgv;
  map<Function *, FuncInfo *> FuncInfoMap;

  void initFuncInfo(Function * F, unsigned size) {
    FuncInfoCount++;
    FuncInfo * fi = new FuncInfo;
    for(unsigned i = 0; i < size; i++)
      fi->args.push_back(NULL);
    FuncInfoMap[F] = fi;
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<AssumptionCacheTracker>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetLibraryInfoWrapperPass>();
  }


  void runOnFunction(Function *F, map<Function*, bool> & visited,
      map<Value*, Alloca*> pointers, map<Value*, Alloca*> &memoryObjects) {

    if(visited.find(F) != visited.end())
      return; // Visited each function once

    visited[F] = true;
    for(auto it = F->begin(), end = F->end(); it != end; it++) {
      BasicBlock *BB = &*it;

      for (BasicBlock::iterator inst = BB->begin(), ie = BB->end(); inst != ie; ) {
        Instruction * I = &(*inst);
        debug(Abubakar) << *I << " " << F->getName() << "\n";
        if( AllocaInst * allocaInst = dyn_cast<AllocaInst>(&*I)) {
          Alloca *alloca = initAlloca(I, F, false, -1);
          memoryObjects[allocaInst] = alloca;
          pointers[allocaInst] = alloca;
          InsertUnique(FuncInfoMap[F]->allocas, alloca);
        } else if(GetElementPtrInst * GEPInst = dyn_cast<GetElementPtrInst>(&*I)) {
          Value * ptr = GEPInst->getOperand(0);
          Alloca *baseAlloca;
          if(pointers.find(ptr) == pointers.end()) {
            inst++; 
            continue;
          }
          else
            baseAlloca = pointers[ptr];
          pointers[I] = baseAlloca;       
        } else if(LoadInst * loadInst = dyn_cast<LoadInst>(&*I)) {
          Value * ptr = loadInst->getOperand(0);
          // Search for the pointer in map of constant pointers - pointers with constant offsets
          if(pointers.find(ptr) == pointers.end()) {
            inst++;
            continue;
          }
          Alloca * baseAlloca = pointers[ptr]; 
          if(!baseAlloca) {
            inst++;
            continue;
          }

          // NOTE: Handling pointer loads
          if(ptr->getType()->isPointerTy())
            pointers[I] = baseAlloca;      
          if(baseAlloca->isArgv) {
            InsertUnique(loadsArgv, F);
            debug(Abubakar) << "inserted from loadInst " << F->getName() << "\n";
          } else if(baseAlloca->arg >= 0) {
            InsertUnique(baseAlloca->loaders, F);
          } else if(baseAlloca->global) {
            InsertUnique(FuncInfoMap[F]->usedGlobals, baseAlloca->val);
          }
        } else if(StoreInst * storeInst = dyn_cast<StoreInst>(&*I)) {
          Value * arg1 = storeInst->getOperand(0);
          Value * arg2 = storeInst->getOperand(1); 
          Alloca * alloca1 = pointers[arg1];
          Alloca * alloca2 = pointers[arg2];

          if(alloca2) {
            if(alloca1 && isa<CallInst>(alloca1->val)) {
              InsertUnique(alloca2->storers, dyn_cast<CallInst>(alloca1->val)->getCalledFunction());              
            }
            if(alloca2->global) {
              InsertUnique(FuncInfoMap[F]->usedGlobals, alloca2->val);
            }                
            InsertUnique(alloca2->storers, F);
          }
          if(alloca1) {
            if(arg1->getType()->isPointerTy()) 
              pointers[arg2] = alloca1;   
            if(alloca1->global) {
              InsertUnique(FuncInfoMap[F]->usedGlobals, alloca1->val);
            } 
            InsertUnique(alloca1->storers, F);
          } 
        } else if(CallInst * callInst = dyn_cast<CallInst>(&*I)) {
          Function * calledFunction = callInst->getCalledFunction();
          if(!calledFunction) {
            inst++;
            continue;            
          }
          if(calledFunction->isDeclaration()) {
            inst++;
            continue;
          }
          if(calledFunction->isVarArg()) {
            inst++;
            continue;            
          }          
          if(calledFunction->getName() == F->getName()) {
            inst++;
            continue;
          }
          if(FuncInfoMap.find(calledFunction) == FuncInfoMap.end()) {
            initFuncInfo(calledFunction, callInst->getNumArgOperands());
            for(unsigned i = 0; i < callInst->getNumArgOperands(); i++) {
              Value *funcArg = getFunctionArgument(calledFunction, i);
              pointers[funcArg] = initAlloca(funcArg, calledFunction, false, i); 
              FuncInfoMap[calledFunction]->args[i] = pointers[funcArg]; 
            }
            runOnFunction(calledFunction, visited, pointers, memoryObjects);
          }
          pointers[callInst] = initAlloca(callInst, F, false, -1);
          for(unsigned i = 0; i < callInst->getNumArgOperands(); i++) {
            Value *argOperand = callInst->getArgOperand(i);
            if(pointers.find(argOperand) != pointers.end()) {
              Alloca * baseAlloca = pointers[argOperand];
              Alloca * argAlloca = FuncInfoMap[calledFunction]->args[i];
              if(!baseAlloca)
                continue;
              if(argAlloca->loaders.size()) {
                for(unsigned i = 0; i < argAlloca->loaders.size(); i++)
                  debug(Abubakar) << "inserted loader " << argAlloca->loaders[i]->getName() << "\n";
                if(baseAlloca->isArgv) {
                  InsertUnique(loadsArgv, argAlloca->loaders);
                } else {
                  InsertUnique(baseAlloca->loaders, argAlloca->loaders);
                }
              } 
              if(argAlloca->storers.size()) {
                for(unsigned i = 0; i < argAlloca->storers.size(); i++)
                  debug(Abubakar) << "inserted storer " << argAlloca->storers[i]->getName() << "\n";
                InsertUnique(baseAlloca->storers, argAlloca->storers);
              }
            }  
          }          
        } else if(BitCastInst * bitcastInst = dyn_cast<BitCastInst>(&*I)) {
          Value * ptr = bitcastInst->getOperand(0);
          Alloca * baseAlloca;
          if(pointers.find(ptr) == pointers.end()){
            inst++;
            continue;
          }
          else
            baseAlloca = pointers[ptr];
          pointers[I] = baseAlloca; 
        }
        inst++;
      }
    }
  }

  Value *getFunctionArgument(Function *F, int argIndex) {
    int index = 0;
    for(auto arg = F->arg_begin(); arg != F->arg_end(); arg++, index++) {
      if(index == argIndex)
        return &*arg; 
    }
    return NULL;
  }

  GlobalVariable*
  materializeStringLiteral(llvm::Module& m, const char* data, string name) {
      Constant* ary = llvm::ConstantDataArray::getString(m.getContext(), data, true);
      GlobalVariable* gv = new GlobalVariable(m, ary->getType(), true, GlobalValue::LinkageTypes::PrivateLinkage, ary, Twine(name));
      gv->setConstant(true);
      return gv;
  }
   
  bool runOnModule(Module & M) override {
    clock_t start = clock(), diff;
    map<Value*, Alloca*> memoryObjects;
    map<Value*, Alloca*> pointers;
    map<Function*, bool> visited;

    Function *programEntry = M.getFunction(StringRef("main"));
    Value *argv = getFunctionArgument(programEntry, 1);

    // Constructing an allocation for *argv*
    Alloca *alloca = initAlloca(argv, programEntry, true, 1);
    pointers[argv] = alloca;
    memoryObjects[argv] = alloca;    
    for(auto& global : M.globals()) {
      GlobalVariable *  gv = &global;
      if(gv->getName() == "optarg" || gv->getName() == "optind") {
        Alloca *alloca = initAlloca(gv, NULL, true, -1);      
        pointers[gv] = alloca;
        memoryObjects[gv] = alloca;         
      }
      if(gv->isDeclaration())
        continue;
      Type * ty = gv->getType()->getContainedType(0);
      if(gv->isConstant() && isa<ArrayType>(ty) && ty->getContainedType(0)->isIntegerTy(8))
        continue;
      Alloca *alloca = initAlloca(gv, NULL, false, -1);      
      pointers[gv] = alloca;
      memoryObjects[gv] = alloca; 
    }            
    initFuncInfo(programEntry, 2);
    runOnFunction(programEntry, visited, pointers, memoryObjects);
    vector<Value *> trackedGlobals; 
    vector<Function *> trackedFunctions;
    InsertUnique(trackedFunctions, loadsArgv);  
    for(unsigned i = 0; i < loadsArgv.size(); i++) {
      debug(Abubakar) << "for function " << loadsArgv[i]->getName() << " :\n";
      vector<Value *> globals = FuncInfoMap[loadsArgv[i]]->usedGlobals;
      InsertUnique(trackedGlobals, FuncInfoMap[loadsArgv[i]]->usedGlobals);
      for(unsigned j = 0; j < globals.size(); j++)
        debug(Abubakar) << "inserted global " << globals[j]->getName() << "\n";
      vector<Alloca *> allocas = FuncInfoMap[loadsArgv[i]]->allocas;
      for(unsigned j = 0; j < allocas.size(); j++) {
        InsertUnique(trackedFunctions, allocas[j]->storers);
        debug(Abubakar) << *allocas[j]->val << " " << allocas[j]->storers.size() << "\n";
        for(unsigned k = 0; k < allocas[j]->storers.size(); k++) {
          debug(Abubakar) << "inserted function for allocation " << allocas[j]->storers[k]->getName() << "\n";          
        }
      }
    }
    string globals = "";
    string funcs = "";
    for(unsigned i = 0; i < trackedGlobals.size(); i++) {
      vector<Function *> storers = pointers[trackedGlobals[i]]->storers;
      InsertUnique(trackedFunctions, storers);
      globals += trackedGlobals[i]->getName().str() + ";";
    }  
    for(unsigned i = 0; i < trackedFunctions.size(); i++) {
      funcs += trackedFunctions[i]->getName().str() + ";";
    }
    globals = globals.substr(0, globals.size()-1);
    funcs = funcs.substr(0, funcs.size()-1);
    errs() << globals << "\n";
    errs() << funcs << "\n";
    materializeStringLiteral(M, globals.c_str(), "__tracked_globals__");
    materializeStringLiteral(M, funcs.c_str(), "__tracked_funcs__");


    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    errs() << (msec/1000) << "." << (msec%1000) << "\n";
    errs() <<  AllocCount << " * " << sizeof(Alloca) << "\n";
    errs() <<  FuncInfoCount << " * " << sizeof(FuncInfo) << "\n";
    errs() << (AllocCount * sizeof(Alloca) + FuncInfoCount * sizeof(FuncInfo)) << "\n";
    return true;  
  } 
};


char Annotate::ID = 0;
static RegisterPass<Annotate> X("annotate", "Annotating configuration structures",
                                         false, false);

