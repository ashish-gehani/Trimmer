using namespace llvm;
using namespace std;
#include "InterConstProp.h"
#include "Utils.cpp"

bool simpleStrFunc(string name) {
  if(name == "strcmp" || name == "strcasecmp" || name == "strcspn" 
     || name == "strspn" || name == "strncmp" || name == "strncasecmp"
     || name == "strlen" || name == "strtol")
    return true;
  else
    return false;
}

bool getStrLen(CallInst * ci, uint64_t& len) {
  string name = ci->getCalledFunction()->getName();
  if(name == "strncmp" || name == "strncasecmp") {
    if(ConstantInt * CI = dyn_cast<ConstantInt>(ci->getArgOperand(2))) {
      len = CI->getZExtValue();
      return true;
    }
  }
  return false;
}

bool getConstantStringInfo(const Value * V, StringRef &Str, uint64_t Offset, bool TrimAtNul) {
   
  assert(V);
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
    if (!AT || !AT->getElementType()->isIntegerTy(8))
      return false;

    // Check to make sure that the first operand of the GEP is an integer and
    // has value 0 so that we are sure we're indexing into the initializer.
    const ConstantInt *FirstIdx = dyn_cast<ConstantInt>(GEP->getOperand(1));
    if (!FirstIdx || !FirstIdx->isZero())
      return false;

    // If the second index isn't a ConstantInt, then this is a variable index
    // into the array.  If this occurs, we can't say anything meaningful about
    // the string.
    uint64_t StartIdx = 0;
    if (const ConstantInt *CI = dyn_cast<ConstantInt>(GEP->getOperand(2)))
      StartIdx = CI->getZExtValue();
    else
      return false;
    return getConstantStringInfo(GEP->getOperand(0), Str, StartIdx + Offset,
         TrimAtNul);
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
  if (!Array || !Array->isString())
    return false;

  // Get the number of elements in the array
  uint64_t NumElts = Array->getType()->getArrayNumElements();

  // Start out with the entire array in the StringRef.
  Str = Array->getAsString();

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
}

bool ConstantFolding::handleStringFunc(CallInst * callInst) {
  string name = callInst->getCalledFunction()->getName();
  if(simpleStrFunc(name))   simplifyStrFunc(callInst);
  else if(name == "strchr") handleStrChr(callInst);
  else if(name == "strpbrk")handleStrpbrk(callInst);
  else if(name == "atoi")   handleAtoi(callInst);
  else return false;
  return true;
}

void ConstantFolding::simplifyStrFunc(CallInst * callInst) {
  if(callInst->use_empty())
    return;
  Instruction * next = callInst;
  for(unsigned index = 0; index < callInst->getNumArgOperands(); index++) {
    Value * pointerArg = callInst->getArgOperand(index);
    Register * reg = getRegister(pointerArg);

    if(!reg) {
      StringRef stringRef;
      if(getConstantStringInfo(pointerArg, stringRef, 0, false))
        debug(Abubakar) << "constant string " << stringRef << "\n";
    } else {    
      uint64_t addr = reg->getValue();
      uint64_t len;
      if(getStrLen(callInst, len)) {
        if(!checkConstStr(addr, len)) {
          debug(Abubakar) << "skipping non constant string\n";
          continue;
        }
      } else if(!checkConstStr(addr))
        continue;
      char * baseStringData = (char *) getActualAddr(addr);
      debug(Abubakar) << "baseStringData : " << baseStringData << "\n";
      ConstantInt * ind0 = ConstantInt::get(IntegerType::get(module->getContext(), 64), 0);
      vector<Value *> indxList;
      indxList.push_back(ind0); 
      indxList.push_back(ind0);
      Constant * stringConstant = ConstantDataArray::getString(module->getContext(), 
                     StringRef(baseStringData), true);
      GlobalVariable * globalReadString = new GlobalVariable(*module, stringConstant->getType(), true,
                   GlobalValue::ExternalLinkage, stringConstant, "");
      Type * elType = globalReadString->getType()->getContainedType(0);
      GetElementPtrInst * stringPtr = GetElementPtrInst::Create(elType, globalReadString, 
                indxList, Twine(""), callInst);
      callInst->setOperand(index, stringPtr);          
      next = stringPtr;
    }
  }
  auto InstCombineRAUW = [this](Instruction *From, Value *With) {
    From->replaceAllUsesWith(With);
  };
  LibCallSimplifier Simplifier(*DL, TLI, InstCombineRAUW);
  if (Value *With = Simplifier.optimizeCall(callInst)) {
    replaceAndLog(callInst, With);
  }
}

void ConstantFolding::handleStrChr(CallInst * callInst) {
  Value * bufPtr = callInst->getOperand(0);
  Value * flagVal = callInst->getOperand(1);  
  uint64_t flag;
  Register * reg = getRegister(bufPtr);  
  if(!reg) {
    debug(Abubakar) << "handleStrChr : buffer Not found in Map\n";
    return;
  }
  if(!getSingleVal(flagVal, flag)) {
    debug(Abubakar) << "handleStrChr : flag not constant\n";
    setConstContigous(false, reg->getValue()); 
    return;   
  }
  char * buffer = (char *) getActualAddr(reg->getValue());
  debug(Abubakar) << "strchr : " << buffer << " with flag " << (char) flag << "\n";
  char * remStr = strchr(buffer, flag);
  Type * ty = callInst->getType();
  if(!remStr) {
    debug(Abubakar) << "strchr : returned NULL\n";
    ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
    replaceAndLog(callInst, nullP);
    return;
  }
  uint64_t addr;
  for(addr = reg->getValue(); *buffer && buffer != remStr; addr++, buffer++);
  debug(Abubakar) << "strchr : returned idx " << (addr - reg->getValue()) << "\n";
  addRegister(callInst, ty, addr);
}

void ConstantFolding::handleStrpbrk(CallInst * callInst) {
  Value * bufPtr = callInst->getOperand(0);
  Value * keyPtr = callInst->getOperand(1);  
  handleConstStr(keyPtr);
  Register * reg1 = getRegister(bufPtr);  
  if(!reg1) {
    debug(Abubakar) << "handleStrpbrk : buffer Not found in Map\n";
    return;
  }
  Register * reg2 = getRegister(keyPtr);  
  if(!reg2) {
    setConstContigous(false, reg1->getValue()); 
    debug(Abubakar) << "handleStrpbrk : key Not found in Map\n";
    return;
  }
  char * buffer = (char *) getActualAddr(reg1->getValue());
  char * key = (char *) getActualAddr(reg2->getValue());
  char * remStr = strpbrk(buffer, key);
  Type * ty = callInst->getType();
  if(!remStr) {
    ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
    replaceAndLog(callInst, nullP);
    return;
  }
  uint64_t addr;
  for(addr = reg1->getValue(); *buffer && buffer != remStr; addr++, buffer++);
  addRegister(callInst, ty, addr);
}


void ConstantFolding::handleAtoi(CallInst * callInst) {
  Value * ptr = callInst->getArgOperand(0);
  Register * reg = getRegister(ptr);
  if(!reg) {
    debug(Abubakar) << "handleAtoi : not found in map\n";
    return;
  }
  if(!checkConstContigous(reg->getValue())) {
    debug(Abubakar) << "handleAtoi : not constant\n";
    return;
  }
  char * str = (char *) getActualAddr(reg->getValue());
  int result = atoi(str);
  IntegerType * int32Ty = IntegerType::get(module->getContext(), 32);
  replaceAndLog(callInst, ConstantInt::get(int32Ty, result)); 
}
