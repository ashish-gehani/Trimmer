using namespace llvm;
using namespace std;

#include "InterConstProp.h"

#ifndef UTILS_H
#define UTILS_H

bool getConstantStringInfo(const Value *, StringRef&, uint64_t, bool);

Value * getArg(Function * func, int index){
  int i = 0;
  for(auto arg = func->arg_begin(), argEnd = func->arg_end(); arg != argEnd; arg++){
    if(i == index) 
      return &*arg;
    i++;
  }
  return NULL;  
}

void replaceAndLog(Value * from, Value * to) {
  if(!from || !to)
    return;
  from->replaceAllUsesWith(to);
  debug(Abubakar) << "replaced with " << *to << "\n";
}

void handleConst(Value * val, uint64_t num, 
  ValToRegisterMap& Registers) {
  Type * ty = val->getType();
  if(ty->isPointerTy()) {
    if(!num) {
      ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
      replaceAndLog(val, nullP);
    } else 
      Registers[val] = new Register(ty, num); 
  } else if(IntegerType * intTy = dyn_cast<IntegerType>(ty))
      replaceAndLog(val, ConstantInt::get(intTy, num));
}

void cleanUpfuncBBs(Function * f, BasicBlockContInfoMap bbc) {
  for(auto f_it = f->begin(), f_ite = f->end(); f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    if(bbc.find(BB) == bbc.end())
      continue;
    ContextInfo * ci = bbc[BB];
    if(!ci->deleted && !ci->cloneOf)
      delete ci->memory;
    delete ci;
  }  
}

bool ignorefunc(Function * F) {
  if(F->getName() == "printf")
    return true;
  return false;
}

ContextInfo * ConstantFolding::getCurrContext() {
  return BasicBlockContexts[currBB];
}

void ConstantFolding::copyContext(Memory * mem) {
  BasicBlockContexts[currBB]->memory->copyfrom(mem);
}

uint64_t ConstantFolding::allocateStack(uint64_t size) {
  return BasicBlockContexts[currBB]->memory->allocateStack(size);  
}

uint64_t ConstantFolding::allocateHeap(uint64_t size) {
  return BasicBlockContexts[currBB]->memory->allocateHeap(size);  
}

uint64_t ConstantFolding::loadMem(uint64_t addr, uint64_t size) {
  return BasicBlockContexts[currBB]->memory->load(addr, size); 
}

void ConstantFolding::storeToMem(uint64_t val, uint64_t size, uint64_t addr) {
  BasicBlockContexts[currBB]->memory->store(val, size, addr);  
}

void ConstantFolding::setConstMem(bool val, uint64_t addr, uint64_t size) {
  BasicBlockContexts[currBB]->memory->setConstant(val, addr, size);  
}

void ConstantFolding::setConstContigous(bool val, uint64_t addr) {
  BasicBlockContexts[currBB]->memory->setConstContigous(val, addr);
}

uint64_t ConstantFolding::getRemainingContigousSize(uint64_t addr) {
  return BasicBlockContexts[currBB]->memory->getRemainingContigousSize(addr);
}

void * ConstantFolding::getActualAddr(uint64_t addr) {
  return BasicBlockContexts[currBB]->memory->getActualAddr(addr);
}

bool ConstantFolding::checkConstMem(uint64_t addr, uint64_t size) {
  return BasicBlockContexts[currBB]->memory->checkConstant(addr, size);
}

bool ConstantFolding::checkConstStr(uint64_t addr) {
  char * mem = (char *) getActualAddr(addr);
  for(unsigned i = 0; mem[i] != '\0'; i++) {
    if(!checkConstMem(addr + i, 1))
      return false; 
  }
  return checkConstMem(addr, 1); // if the string starts with '\0'
}

bool ConstantFolding::checkConstStr(uint64_t addr, uint64_t max) {
  char * mem = (char *) getActualAddr(addr);
  for(unsigned i = 0; mem[i] != '\0' && i < max; i++) {
    if(!checkConstMem(i, 1))
      return false; 
  }
  return true;
}

void ConstantFolding::addRegister(Value * val, Type * ty, uint64_t toStore) {
  Registers[val] = new Register(ty, toStore);
}

Register * ConstantFolding::getRegister(Value * ptr) {
  if(Registers.find(ptr) != Registers.end())
    return Registers[ptr];
  if(ConstantExpr * ce = dyn_cast<ConstantExpr>(ptr)) {
    if(Instruction * I = ce->getAsInstruction()) {
      if(Registers.find(I) != Registers.end())
        return Registers[I]; 
      runOnInst(I);
      if(Registers.find(I) != Registers.end())
        return Registers[I];      
    }
  }  
  return NULL;
}

Memory * ConstantFolding::duplicateMem() {
  return new Memory(*BasicBlockContexts[currBB]->memory);
}

void ConstantFolding::cloneContext(BasicBlock * to) {
  BasicBlockContexts[to] = BasicBlockContexts[currBB]->clone();
}

void ConstantFolding::duplicateContext(BasicBlock * to) {
  BasicBlockContexts[to] = BasicBlockContexts[currBB]->duplicate();
}

Function * ConstantFolding::addClonedFunction(CallInst * callInst, Function * F) {
  Function * clonedFunc;
  ClonedCodeInfo info;
  ValueToValueMapTy vmap;
  
  string name = F->getName().str();
  clonedFunc = llvm::CloneFunction(F, vmap, true, &info);
  clonedFunc->setName(StringRef(name + "_clone")); 
  F->getParent()->getFunctionList().push_back(clonedFunc);
  std::vector<Value*> args(callInst->arg_begin(), callInst->arg_end());
  CallInst * specCallInst = CallInst::Create(clonedFunc, args);
  toReplace.push_back(make_pair(callInst, specCallInst));

  return clonedFunc;
}

void ConstantFolding::replaceUses() {
  for(unsigned i = 0; i < toReplace.size(); i++) {
    pair<Instruction *, Instruction *> cp = toReplace[i];
    Instruction * oldI = cp.first;
    Instruction * newI = cp.second; 
    BasicBlock::iterator inst = BasicBlock::iterator(oldI);
    oldI->getParent()->getInstList().insert(inst, newI);
    oldI->replaceAllUsesWith(newI); 
    oldI->eraseFromParent();
  }
}

void ConstantFolding::markArgsAsNonConst(CallInst * callInst) {
  Function* calledFunction = callInst->getCalledFunction();
  if(ignorefunc(calledFunction && calledFunction))
    return;
  if(calledFunction && calledFunction->onlyReadsMemory()) {
    return;
  }
  for(unsigned index = 0; index < callInst->getNumArgOperands(); index++) {
    Value * pointerArg = callInst->getOperand(index);
    Register * reg = getRegister(pointerArg);
    if(!reg)
      continue;
    setConstContigous(false, reg->getValue());
    debug(Abubakar) << "markArgsAsNonConst : index " << index << "\n"; 
  }
}

void ConstantFolding::initializeGlobal(uint64_t& addr, Constant * CC) {

  /* already initialize with zero */

  if(isa<ConstantPointerNull>(CC))
    return;    

  if(isa<ConstantAggregateZero>(CC))
    return;
  ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(CC);
  if(CDA && CDA->isString()) {
    char * source = (char *) getActualAddr(addr);
    string str = CDA->getAsString().str();  
    int size = str.size();
    memcpy(source, str.c_str(), size);
    debug(Abubakar) << "storing : size " << size << " at address " << addr << " " << *CC << "\n";
    addr += size;
  } else if(ConstantInt * CI = dyn_cast<ConstantInt>(CC)) {
    uint64_t size = DL->getTypeAllocSize(CI->getType());
    storeToMem(CI->getZExtValue(), size, addr);    
    debug(Abubakar) << "storing : size " << size << " at address " << addr << " " << *CC << "\n";
    addr += size;
  } else if(ConstantExpr * CE = dyn_cast<ConstantExpr>(CC)) {
    /* 1. either we have it in memory in which case runOnInst will work*/
    /* 2. we dont have it in memory but its a constant string - need to allocate new memory */
    /* 3. points to something which is not in memory */
    Instruction * I = dyn_cast<ConstantExpr>(CE)->getAsInstruction();
    assert(I);
    assert(isa<GetElementPtrInst>(I));
    StringRef stringRef;
    if(getConstantStringInfo(I->getOperand(0), stringRef, 0, false)) {  
      string str = stringRef.str(); 
      int strSize = str.size(); /* allocate memory for that string */
      uint64_t newAddr = allocateStack(strSize);
      char * source = (char *) getActualAddr(newAddr);      
      memcpy(source, str.c_str(), strSize);
      int size = DL->getTypeAllocSize(CE->getType());
      storeToMem(newAddr, size, addr);
      debug(Abubakar) << "created new constant string " << str << " at address " << newAddr << "\n";
      debug(Abubakar) << "storing address " << newAddr << " at pointer " << addr << " size " << size << "\n";
      addr += size;      
    }   
  } else {
    for(unsigned i = 0; i < CC->getNumOperands(); i++) {
      Constant * CGI = CC->getAggregateElement(i);
      initializeGlobal(addr, CGI);
    }
  }
}

// important globals : optind, optarg, __argv_new__
void ConstantFolding::addGlobals() {
  for(auto& global : module->globals()) {
    GlobalVariable *  gv = &global;
    Type * contTy = gv->getType()->getContainedType(0);
    if(gv->isConstant() && isa<ArrayType>(contTy) && contTy->getContainedType(0)->isIntegerTy(8))
      continue;
    uint64_t size = DL->getTypeAllocSize(contTy);
    uint64_t addr = allocateStack(size);
    debug(Abubakar) << "addGlobal : size " << size << " at address " << addr << "\n";
    addRegister(gv, contTy, addr);
    if(gv->hasInitializer()) 
      initializeGlobal(addr, gv->getInitializer());
  }   
}

#endif