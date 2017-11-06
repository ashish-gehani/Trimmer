#define DEBUG_TYPE "hello"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/InstIterator.h"
#include "llvm/IR/Instruction.h"
#include <string>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/DerivedTypes.h" 
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/IRBuilder.h"
#include <map>

using namespace llvm;

namespace {
  struct countDynamicInstructions : public ModulePass {
    static char ID; 
     unsigned int opcode;
    const char* opcodeName;
    std::string Instructions;
    std::string sampleFuncName = "_Z6samplev";
    countDynamicInstructions() : ModulePass(ID) {}
    virtual bool runOnModule(Module &m) {

      FunctionType* funcType=FunctionType::get(Type::getVoidTy(m.getContext()),   false); 
      Constant* sampleFunc = m.getOrInsertFunction("_Z6samplev",funcType);
     
      Value* countInstFunc = dyn_cast<Value>(sampleFunc);

      Module::FunctionListType &functions = m.getFunctionList();
 std::map<const char*, int> map;
            std::map<const char*, int>::iterator itr;
            // itr = map.begin();
            // itr->second=1;
            // int counter=0; //counter for total instructions
            std::vector<int> instructionsThisBlock;
        for (Module::FunctionListType::iterator it = functions.begin(),it_end = functions.end(); it != it_end; ++it) 
        {

            Function &func = *it;

          

          for (Function::iterator i = func.begin(), e = func.end(); i != e; ++i){
          // Print out the name of the basic block if it has one, and then the number of instructions that it contains
          errs() << "Basic block (name=" << i->getName() << ") has "<< i->size() << " instructions.\n";
          BasicBlock &blk=*i;

          for (BasicBlock::iterator i = blk.begin(), e = blk.end(); i != e; ++i){

              opcode=i->getOpcode();
            opcodeName=i->getOpcodeName(opcode);
         
            // itr = map.begin();
            // itr=map.find(opcodeName);
            // if(itr !=map.end())
            //   {
            //     itr->second =itr->second+1;
            //     map.insert(std::make_pair(opcodeName, itr->second)); //add +1 to value if key already present in the map
            //     counter++;
            //    }
            // else
            //   {
            //     map.insert(std::make_pair(opcodeName, itr->second)); //value =1 if key is not already present in the map
            //     counter++;
            //   }


              IRBuilder<> builder(i);
             builder.SetInsertPoint(&blk, builder.GetInsertPoint());
             Function *mycall = (Function*)(m.getOrInsertFunction(sampleFuncName, funcType));
           
                Value *strPtr = builder.CreateGlobalString(opcodeName);
               // errs()<<"str: "<<*strPtr;
              std::string name="ssa";
              Value *str = builder.CreateGlobalString(name);
               Value *strPt1r = builder.CreateGlobalStringPtr("/dev/mem", ".str");
              llvm::Value *helloWorld = builder.CreateGlobalStringPtr("hello world!\n");
              builder.CreateCall(countInstFunc,helloWorld);
         
        


             
         }
    

        }
          
        }
        // std::map<const char*, int>::iterator it = map.begin();
        // while(it != map.end())
        // {
        //   Instructions=it->first ;
        //   errs() << it->first <<"\t"<<it->second << '\n'; //print key value pairs
        //   it++;
        // }
        // errs()<<"Total"<<"\t"<<counter<< '\n'; //print total instruction count
     return false;
    }
  };
}

char countDynamicInstructions::ID = 0;
static RegisterPass<countDynamicInstructions> X("countDynamic", "counting Dynamic Instructions pass");

//run using:
//opt -load $LLVMLIB/CSE231.so -count < $BENCHMARKS/welcome/welcome.bc -o output.bc &> $OUTPUTLOGS/welcome.static.log