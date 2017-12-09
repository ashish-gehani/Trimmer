using namespace llvm;
using namespace std;
#include "InterConstProp.h"

void ConstantFolding::handleStringFunction(CallInst * callInst, Function * calledFunction) {
  if(callInst->use_empty())
    return;
  Instruction * next = callInst;
  for(unsigned index = 0; index < callInst->getNumArgOperands(); index++) {
    Value * pointerArg = callInst->getArgOperand(index);
    errs() << *pointerArg << " is the pointerArg\n";
    if(Registers.find(pointerArg) == Registers.end()) {
      StringRef stringRef;
      if(getConstantStringInfo(pointerArg, stringRef, 0, false)) {
        //TODO
      }      
    } else {
      Register * reg = Registers[pointerArg];
      //TODO-const : check if the pointerArg points to constant location
      errs() << reg->getValue() << "\n";
      char * baseStringData = (char *) memory->getActualAddr(reg->getValue());
      errs() << "baseStringData " << baseStringData << "\n";
      ConstantInt * ind0 = ConstantInt::get(IntegerType::get(module->getContext(), 64), 0);
      vector<Value *> indxList;
      indxList.push_back(ind0); 
      indxList.push_back(ind0);
      Constant * stringConstant = ConstantDataArray::getString(module->getContext(), 
                     StringRef(baseStringData), true);
      GlobalVariable * globalReadString = new GlobalVariable(*module, stringConstant->getType(), true,
                   GlobalValue::ExternalLinkage, stringConstant, "");
      GetElementPtrInst * stringPtr = GetElementPtrInst::Create(NULL, globalReadString, 
                indxList, Twine(""), callInst);
      callInst->setOperand(index, stringPtr);    
      next = stringPtr;
    }
  }
  // inst = BasicBlock::iterator(next);
  // errs() << "inst\n";
  auto InstCombineRAUW = [this](Instruction *From, Value *With) {
    From->replaceAllUsesWith(With);
  };
  LibCallSimplifier Simplifier(*DL, TLI, InstCombineRAUW);
  if (Value *With = Simplifier.optimizeCall(callInst))
    callInst->replaceAllUsesWith(With);
}

bool ConstantFolding::isStringFunction(Function * calledFunction){

  if(calledFunction == NULL) {
    return false;
  }

  string funcName = calledFunction->getName();
  if(funcName == "strcmp" || funcName == "strcasecmp" || funcName == "strcspn" 
     || funcName == "strspn" || funcName == "strncmp" || funcName == "strlen"
     || funcName == "strtol" || funcName == "atoi")
    return true;
  else
    return false;
}
