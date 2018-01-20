using namespace llvm;
using namespace std;

#include "InterConstProp.h"

#ifndef UTILS_H
#define UTILS_H

bool getConstantStringInfo(const Value *, StringRef&, uint64_t, bool);

void split(string str, vector<string>& tokens) {
    size_t pos = str.find(';');
    size_t initialPos = 0;
    while(pos != string::npos) {
        tokens.push_back( str.substr(initialPos, pos - initialPos));
        initialPos = pos + 1;
        pos = str.find(';', initialPos);
    }
    tokens.push_back(str.substr(initialPos, str.size() - initialPos - 1));
}

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

void cleanUpfuncBBs(Function * f, BasicBlockContInfoMap bbc,
  ValToRegisterMap& Registers, ValSet valSet) {
  for(auto f_it = f->begin(), f_ite = f->end(); f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    if(bbc.find(BB) == bbc.end())
      continue;
    ContextInfo * ci = bbc[BB];
    if(!ci->deleted && !ci->cloneOf)
      delete ci->memory;
    delete ci;
  }
  for(auto val : valSet) {
    assert(Registers.find(val) != Registers.end() && "unexpected behavior");
    Register * reg = Registers[val];
    delete reg;
    Registers.erase(val);    
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

void ConstantFolding::addGlobalRegister(Value * val, Type * ty, uint64_t toStore) {
  Registers[val] = new Register(ty, toStore);
}

void ConstantFolding::addRegister(Value * val, Type * ty, uint64_t toStore) {
  funcValStack[funcValStack.size() - 1].insert(val);
  Registers[val] = new Register(ty, toStore);
}

void ConstantFolding::addRegister(Value * val, Register * reg) {
  funcValStack[funcValStack.size() - 1].insert(val);
  Registers[val] = new Register(*reg);
}


bool ConstantFolding::cloneRegister(Value * from, Value * with) {
  debug(Abubakar) << "attempting to copy Register for " << *with << "\n";
  
  // if this is a constant string, allocate memory for it
  handleConstStr(with);
  uint64_t val;
  if(!getSingleVal(with, val)) {
    debug(Abubakar) << "failed to create Register\n";
    return false;
  }
  addRegister(from, from->getType(), val);
  return true;
}


bool ConstantFolding::replaceOrCloneRegister(Value * from, Value * with) {
  debug(Abubakar) << "attempting to copy Register for " << *with << "\n";
  
  // if this is a constant string, allocate memory for it
  handleConstStr(with);

  Type * ty = from->getType();
  if(isa<ConstantInt>(with)) {
    replaceAndLog(from, with);
    debug(Abubakar) << "replaced with constantInt\n";
  } else if(isa<ConstantPointerNull>(with)) {
    replaceAndLog(from, with);
    debug(Abubakar) << "replaced with NULL pointer\n";
  } else if(Register * reg = getRegister(with)) {
    addRegister(from, ty, reg->getValue());    
    debug(Abubakar) << "Register from Register\n";
  } else {   
    debug(Abubakar) << "failed to simplify\n";
    return false;
  }
  return true;
}
Register * ConstantFolding::getRegister(Value * ptr) {
  
  if(Registers.find(ptr) != Registers.end())
    return Registers[ptr];
  Register * reg = NULL;
  if(ConstantExpr * ce = dyn_cast<ConstantExpr>(ptr)) {
    if(Instruction * I = ce->getAsInstruction()) { 
      runOnInst(I);
      if(Registers.find(I) != Registers.end()) {
        reg = Registers[I];
        Registers[ptr] = new Register(*reg);
      }
      I->dropAllReferences();
    }
  }  
  return reg;
}

Memory * ConstantFolding::duplicateMem() {
  return new Memory(*BasicBlockContexts[currBB]->memory);
}

void ConstantFolding::cloneContext(BasicBlock * to) {
  BasicBlockContexts[to] = BasicBlockContexts[currBB]->clone();
}

void ConstantFolding::initializeBBInfo(BasicBlock * BB) {
  LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*BB->getParent()).getLoopInfo();
  bbOps.initialize(BB, LI);
}

void ConstantFolding::createNewContext(BasicBlock * BB) {
  initializeBBInfo(BB);
  BasicBlockContexts[BB] = new ContextInfo(module);
}

void ConstantFolding::duplicateContext(BasicBlock * to) {
  initializeBBInfo(to);
  BasicBlockContexts[to] = BasicBlockContexts[currBB]->duplicate();
}

Function * ConstantFolding::addClonedFunction(Function * F, ValueToValueMapTy& vmap) {
  ClonedCodeInfo info;
  string name = F->getName().str();
  Function * clonedFunc = llvm::CloneFunction(F, vmap, &info);
  clonedFunc->setName(StringRef(name + "_clone")); 
  return clonedFunc;
}

Function * ConstantFolding::addClonedFunction(CallInst * callInst, Function * F) {
  ValueToValueMapTy vmap;
  Function * clonedFunc = addClonedFunction(F, vmap);
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
  if(calledFunction && ignorefunc(calledFunction))
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

void ConstantFolding::initializeGlobal(uint64_t addr, Constant * CC) {

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
  } else if(ConstantInt * CI = dyn_cast<ConstantInt>(CC)) {
    uint64_t size = DL->getTypeAllocSize(CI->getType());
    storeToMem(CI->getZExtValue(), size, addr);    
    debug(Abubakar) << "storing : size " << size << " at address " << addr << " " << *CC << "\n";
  } else if(ConstantExpr * CE = dyn_cast<ConstantExpr>(CC)) {
    /* 1. either we have it in memory in which case runOnInst will work*/
    /* 2. we dont have it in memory but its a constant string - need to allocate new memory */
    /* 3. points to something which is not in memory */
    Instruction * I = dyn_cast<ConstantExpr>(CE)->getAsInstruction();
    assert(I);
    assert(isa<GetElementPtrInst>(I));
    StringRef stringRef;
    if(handleConstStr(I->getOperand(0))) {
      uint64_t newAddr = getRegister(I->getOperand(0))->getValue();
      int size = DL->getTypeAllocSize(CE->getType());
      storeToMem(newAddr, size, addr);      
      debug(Abubakar) << "storing address " << newAddr << " at pointer " << addr << " size " << size << "\n";
    }
    I->dropAllReferences();
  } else {
    for(unsigned i = 0; i < CC->getNumOperands(); i++) {
      Constant * CGI = CC->getAggregateElement(i);
      initializeGlobal(addr, CGI);
      addr += DL->getTypeAllocSize(CGI->getType());
    }
  }
}

// important globals : optind, optarg, __argv_new__
void ConstantFolding::addGlobals() {
  for(auto& global : module->globals()) {
    GlobalVariable *  gv = &global;
    Type * contTy = gv->getType()->getContainedType(0);
    if(useAnnotations && AnnotationList.find(gv) == AnnotationList.end() && 
    gv->getName() != "optarg" && gv->getName() != "optind" &&
    gv->getName() != "__argv_new__")
      continue; 
    // if(gv->isConstant() && isa<ArrayType>(contTy) && contTy->getContainedType(0)->isIntegerTy(8))
    //   continue;
    debug(Abubakar) << gv->getName() << "\n"; 
    uint64_t size = DL->getTypeAllocSize(contTy);
    uint64_t addr = allocateStack(size);
    debug(Abubakar) << "addGlobal : size " << size << " at address " << addr << "\n";
    addGlobalRegister(gv, contTy, addr);
    if(gv->hasInitializer()) 
      initializeGlobal(addr, gv->getInitializer());
  }
}

bool ConstantFolding::getPointerAddr(Value * val, uint64_t& addr) {
  if(Register * reg = getRegister(val)) {
    addr = reg->getValue();
    return true;
  }
  if(isa<ConstantPointerNull>(val)) {
    addr = 0;
    return true;
  }
  return false;
}

CmpInst * ConstantFolding::foldCmp(CmpInst * CI) {
  Value * oldLHS = CI->getOperand(0);
  Value * oldRHS = CI->getOperand(1);
  uint64_t lAddr, rAddr;
  if(getPointerAddr(oldLHS, lAddr) && 
  getPointerAddr(oldRHS, rAddr)) {
    IntegerType * intTy = IntegerType::get(module->getContext(), 1);
    Value * newLHS = ConstantInt::get(intTy, lAddr != 0);
    Value * newRHS = ConstantInt::get(intTy, rAddr != 0);
    CmpInst * NCI = CmpInst::Create(CI->getOpcode(), CI->getPredicate(),
                    newLHS, newRHS);
    NCI->insertBefore(CI);
    debug(Abubakar) << *CI << " ";
    replaceAndLog(CI, NCI);
    return NCI;
  }
  return NULL;
}

Instruction * ConstantFolding::simplifyInst(Instruction * I) {
  for(unsigned i = 0; i < I->getNumOperands(); i++) {
    Value * val = I->getOperand(i);
    if(Register * reg = getRegister(val)) {
      if(IntegerType * intTy = dyn_cast<IntegerType>(val->getType()))
        replaceAndLog(val, ConstantInt::get(intTy, reg->getValue()));
    }
  }
  if(isa<CmpInst>(I) &&
  isa<PointerType>(I->getOperand(0)->getType()))     
    return foldCmp(dyn_cast<CmpInst>(I));
  else if(SelectInst * SI = dyn_cast<SelectInst>(I)) {
    if(ConstantInt * CI = dyn_cast<ConstantInt>(SI->getCondition())) {
      Value * rep = CI->getZExtValue() ? SI->getTrueValue() : SI->getFalseValue();
      replaceOrCloneRegister(I, rep);
    }
  }
  return NULL;
}

void ConstantFolding::createAnnotationList() {
  GlobalVariable * annotVar = module->
  getGlobalVariable(StringRef("llvm.global.annotations"));

  assert(annotVar && "isAnnotated and annotVar not found");

  Constant * initializer = annotVar->getInitializer();
  ArrayType * aty = dyn_cast<ConstantArray>(initializer)->getType();
  unsigned num = aty->getNumElements();
  for(unsigned i = 0; i < num; i++) {
    Constant * t1 = initializer->getAggregateElement(i);
    Constant * t2 = t1->getAggregateElement((unsigned) 0);
    Value * val;
    if(isa<GlobalVariable>(t2))
      val = t2;
    else if(Instruction * I = dyn_cast<ConstantExpr>(t2)->getAsInstruction()) {
      val = dyn_cast<User>(I)->getOperand(0);
      I->dropAllReferences();
    } else 
      continue;
    
    debug(Abubakar) << val->getName() << " will be tracked\n";
    AnnotationList.insert(val);
    StringRef stringRef;
  }
}

void ConstantFolding::createAnnotationList2() {
  vector<string> globs, funcs;
  GlobalVariable * ggv = module->getNamedGlobal("__tracked_globals__");
  if(ggv) {
    ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(ggv->getInitializer());
    split(CDA->getAsString(), globs);
  }
  GlobalVariable * fgv = module->getNamedGlobal("__tracked_funcs__");
  if(fgv) {
    ConstantDataArray * CDA = dyn_cast<ConstantDataArray>(fgv->getInitializer());
    split(CDA->getAsString(), funcs);
  }
  for(unsigned i = 0; i < globs.size(); i++) {
    GlobalValue * gv = module->getNamedValue(StringRef(globs[i]));
    debug(Abubakar) << globs[i] << " : glob " << "\n";
    AnnotationList.insert(gv);
  }
  for(unsigned i = 0; i < funcs.size(); i++) {
    GlobalValue * gv = module->getNamedValue(StringRef(funcs[i]));
    debug(Abubakar) << funcs[i] << " : func " << "\n";
    AnnotationList.insert(gv);    
  }
}

void ConstantFolding::updateAnnotationContext(Function * F) {
  if(!useAnnotations)
    return;
  if(AnnotationList.find(F) == AnnotationList.end())
    currContextIsAnnotated = false;
  else {
    currContextIsAnnotated = true;
  }
}

bool ConstantFolding::trackAllocas() {
  if(useAnnotations && !currContextIsAnnotated)
    return false;
  return true;
}

void ConstantFolding::initializeFuncInfo(Function * F) {
  if(fimap.find(F) == fimap.end()) {
    FuncInfo * fi = new FuncInfo(F);
    updatefuncInfo(F, fi);
    fimap[F] = fi;
  }
}

void ConstantFolding::updatefuncInfo(Function * F, FuncInfo * fi) {
  fi->directCallInsts = 0;
  fi->usedInLoop = false;
  for(Use &U : F->uses()) {
    User * FU = U.getUser();
    if(CallInst * ci = dyn_cast<CallInst>(FU)) {
      if(!ci->getParent())
        continue;
      fi->directCallInsts++;
      LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>(*ci->getFunction()).getLoopInfo();
      if(LI.getLoopFor(ci->getParent()))
        fi->usedInLoop = true;     
    }
  }
}

bool ConstantFolding::satisfyConds(Function * F) {
 
  if(fimap.find(F) == fimap.end())
    return false;

  FuncInfo* fi = fimap[F];  
  if(AnnotationList.find(F) != AnnotationList.end()) 
    return true;

  return !(fi->usedInLoop || fi->addrTaken || fi->directCallInsts > 1); 
}

bool ConstantFolding::getSingleVal(Value * val, uint64_t& num) {
  if(ConstantInt * CI = dyn_cast<ConstantInt>(val)) 
    num =  CI->getZExtValue();
  else if(isa<ConstantPointerNull>(val))
    num = 0;
  else if(Register * reg = getRegister(val)) 
    num = reg->getValue();
  else 
    return false;  
  return true;
}

bool ConstantFolding::getStr(Value * ptr, char *& str, uint64_t size) {
  StringRef stringRef;
  if(getConstantStringInfo(ptr, stringRef, 0, false)) {
    str = new char[stringRef.str().size()];
    strcpy(str, stringRef.str().c_str());
  } else if(Register * reg = getRegister(ptr)) {
    if(!checkConstMem(reg->getValue(), size)) {
      debug(Abubakar) << "getStr : ptr not constant\n";
      return false;   
    }
    str = (char *) getActualAddr(reg->getValue());
  } else {
    debug(Abubakar) << "getStr : ptr not found in Map\n";
    return false;   
  }
  return true;
}

bool ConstantFolding::handleConstStr(Value * ptr) {
  StringRef stringRef;
  if(getConstantStringInfo(ptr, stringRef, 0, false)) {  
    string str = stringRef.str(); 
    int strSize = str.size(); /* allocate memory for that string */
    uint64_t newAddr = allocateStack(strSize);
    char * source = (char *) getActualAddr(newAddr);      
    memcpy(source, str.c_str(), strSize);
    addGlobalRegister(ptr, ptr->getType(), newAddr);
    debug(Abubakar) << "created new constant string " << str << "\n";
    return true;
  } 
  return false;
}

void ConstantFolding::handleInt(Value * val, uint64_t num) {
  Type * ty = val->getType();
  if(ty->isPointerTy()) {
    if(!num) {
      ConstantPointerNull * nullP = ConstantPointerNull::get(dyn_cast<PointerType>(ty));
      replaceAndLog(val, nullP);
    } else {
      addRegister(val, ty, num); 
    }
  } else if(IntegerType * intTy = dyn_cast<IntegerType>(ty))
    replaceAndLog(val, ConstantInt::get(intTy, num));
}

#endif