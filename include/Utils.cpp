#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Transforms/Utils/SimplifyLibCalls.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include "mem.cpp"
#include "Types.h"

using namespace llvm;
using namespace std;

bool getConstantStringInfo(const Value *V, StringRef &Str, uint64_t Offset, bool TrimAtNul) {
   
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


/* This function specializes calls to library functions that take constant arguments */
bool isSpecializable(Function * calledFunction){
    
  string funcName = calledFunction->getName();
  if(funcName == "atoi")
    return true;
  else
    return false;
}   

// FIXIT: Check if function is readnone or readonly and has no sideeffects
bool hasNoSideEffects(CallInst * callInst) {
  
  Function * calledFunction = callInst->getCalledFunction();
  if(callInst->onlyReadsMemory() || calledFunction->onlyReadsMemory()){
    debug(Hashim) << "NOTE: *CallInst only reads memory " << *callInst << " **\n";
    return true;    
  }

  // FIXIT: Extend this list to include all read-only functions from libc if required 
  string funcName = calledFunction->getName();
  if(funcName == "atoi" || funcName == "strdup" || funcName == "printf" ||
    funcName == "memset")
    return true;
  if(funcName.substr(0, 11) == "llvm.memset")
    return true;
  return false;
}

bool isStringFunction(Function * calledFunction){

  if(calledFunction == NULL) {
    // Indirect function call skipped
    return false;
  }

  string funcName = calledFunction->getName();
  if(funcName == "strcmp" || funcName == "strcasecmp" || funcName == "strcspn" 
     || funcName == "strspn" || funcName == "strncmp" || funcName == "strlen"
     || funcName == "strtol")
    return true;
  else
    return false;
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

void compareBlockContexts(ContextInfo * newCi, ContextInfo * oldCi, 
        BasicBlockContInfoMap bbc) {
  vector<BasicBlock *> diffBBs;
  for(unsigned i = 0; i < oldCi->ancestors.size(); i++) {
    if(!findInVect(newCi->ancestors, oldCi->ancestors[i]))
      diffBBs.push_back(oldCi->ancestors[i]);
  }
  for(unsigned i = 0; i < newCi->ancestors.size(); i++) {
    if(!findInVect(oldCi->ancestors, newCi->ancestors[i]))
      diffBBs.push_back(newCi->ancestors[i]);
  }
  set<AggregateAlloca *> checked;
  for(unsigned j = 0; j < diffBBs.size(); j++) {
    ContextInfo * ci = bbc[diffBBs[j]];
    for(unsigned i = 0; i < (*ci->modifiedAllocas).size(); i++) {
      unsigned id = (*ci->modifiedAllocas)[i];
      AggregateAlloca * aa = oldCi->idmap[id];
      AggregateAlloca * naa = newCi->idmap[id];
      naa->checkConsistencyWith(aa);
      checked.insert(aa);
      vector<AggregateAlloca *> oldWL;
      vector<AggregateAlloca *> newWL;
      oldWL.push_back(aa);
      newWL.push_back(naa);
      while(oldWL.size()) {
        AggregateAlloca * oldCurr = oldWL[0];
        AggregateAlloca * newCurr = newWL[0];
        if(checked.find(aa) != checked.end()) {
          oldWL.erase(oldWL.begin());
          newWL.erase(newWL.begin());
          continue;
        }
        checked.insert(aa);
        if(newCurr->checkConsistencyWith(aa)) {
          for(unsigned i = 0; i < oldCurr->getNumContained(); i++) {
            oldWL.push_back(oldCurr->getContained(i));
            newWL.push_back(newCurr->getContained(i));
          }
        }
        oldWL.erase(oldWL.begin());
        newWL.erase(newWL.begin());        
      }
    }
  }
  for(unsigned i = 0; i < diffBBs.size(); i++)
    InsertUnique(newCi->ancestors, diffBBs[i]);
}

void handleBaseDataTypeGEP(vector<unsigned> indices, SSAPointer * bsptr,
                Instruction* I, ValSSAPointerMap & SSAPointers) {
  if(indices.size() > 2) 
    errs() << "GEPINST : case not handled ntype is baseDataType and indices > 2\n";
  SSAPointer * sptr = new SSAPointer(bsptr);
  if(indices.size())
    sptr->position += indices[indices.size() - 1];
  SSAPointers[I] = sptr;
}

void handleBaseDataTypeGEP(vector<unsigned> indices, AggregateAlloca * aa,
                Instruction* I, ValSSAPointerMap & SSAPointers) {
  if(indices.size() > 2) 
    errs() << "GEPINST : case not handled ntype is baseDataType and indices > 2\n";
  SSAPointer * sptr = new SSAPointer(aa);
  if(indices.size())
    sptr->position += indices[indices.size() - 1];
  SSAPointers[I] = sptr;
}

unsigned hasAddressTaken(Function * F) {
  unsigned num = 0;
  for (const Use &U : F->uses()) {
    const User *FU = U.getUser();
    if (isa<BlockAddress>(FU))
      continue;
    if (!isa<CallInst>(FU) && !isa<InvokeInst>(FU)) {
      num++;
      continue;
    }
    ImmutableCallSite CS(cast<Instruction>(FU));
    if (!CS.isCallee(&U))
      num++;
  }
  return num;
}

FuncInfo * initializeFuncInfo(Function * F) {
  FuncInfo * fi = new FuncInfo;
  fi->numCallInsts = 0;
  fi->calledInLoop = false;
  fi->numAddrTaken = F->hasAddressTaken();
  fi->returnVal = NULL;
  fi->visited = false;
  fi->usesGlobals = false;
  return fi;
}

BBInfo * initializeBBInfo(BasicBlock * BB) {
  BBInfo * bbi = new BBInfo;
  bbi->writesToMemory = false;
  bbi->partOfLoop = false;
  bbi->isHeader = false;
  bbi->URfrom = 0;
  bbi->numPreds = distance(pred_begin(BB), pred_end(BB));
  return bbi;
}

FuncInfo * copyFuncInfo(FuncInfo * fi) {
  FuncInfo* nfi = new FuncInfo; 
  nfi->numCallInsts = fi->numCallInsts;
  nfi->calledInLoop = fi->calledInLoop;
  nfi->numAddrTaken = fi->numAddrTaken;
  nfi->returnVal = NULL;
  nfi->visited = fi->visited;
  nfi->usesGlobals = fi->usesGlobals;
  return fi;
}

void updateMap(map<unsigned, AggregateAlloca *> & idmap, AggregateAlloca * aa) {
  vector<AggregateAlloca *> worklist;
  worklist.push_back(aa);
  while(worklist.size()) {
    AggregateAlloca * curr = worklist[0];
    idmap[curr->getId()] = curr;
    for(unsigned i = 0; i < curr->getNumContained(); i++) {
      AggregateAlloca * naa = curr->getContained(i);
      if(idmap.find(naa->getId()) == idmap.end()) 
        worklist.push_back(naa);
    }
    worklist.erase(worklist.begin());
  }
}

AggregateAlloca * dbgAA = NULL;
void duplicateAllocas(ContextInfo * newCi, ContextInfo * oldCi) {
  for(unsigned i = 0; i < oldCi->AggregateAllocas.size(); i++) {
    AggregateAlloca * aa = oldCi->AggregateAllocas[i];
    if(newCi->idmap.find(aa->getId()) != newCi->idmap.end()) {
      continue;
    }
    AggregateAlloca * naa = aa->clone();
    vector<AggregateAlloca *> oldWL;
    vector<AggregateAlloca *> newWL;
    oldWL.push_back(aa);
    newWL.push_back(naa);
    newCi->idmap[aa->getId()] = naa;
    while(oldWL.size()) {
      AggregateAlloca * oldCurr = oldWL[0];
      AggregateAlloca * newCurr = newWL[0];
      for(unsigned i = 0; i < oldCurr->getNumContained(); i++) {
        AggregateAlloca * oldChild = oldCurr->getContained(i);
        if(newCi->idmap.find(oldChild->getId()) == newCi->idmap.end()) { 
          AggregateAlloca * newChild = oldChild->clone();
          newCi->idmap[oldChild->getId()] = newChild;
          newCurr->setOrInsert(i, newChild);
          oldWL.push_back(oldChild);
          newWL.push_back(newChild);
        } else {
          AggregateAlloca * newChild = newCi->idmap[oldChild->getId()];
          newCurr->setOrInsert(i, newChild);         
        }
      }
      oldWL.erase(oldWL.begin());
      newWL.erase(newWL.begin());
    }    
    newCi->AggregateAllocas.push_back(naa);
  } 
  for(unsigned i = 0; i < oldCi->InstOrder.size(); i++) {
    Value * I = oldCi->InstOrder[i];
    if(oldCi->SSAPointers.find(I) == oldCi->SSAPointers.end())
      continue;
    SSAPointer * sptr = oldCi->SSAPointers[I];
    AggregateAlloca * aa = newCi->idmap[sptr->basePointer->getId()];
    SSAPointer * nsptr = new SSAPointer(sptr);
    nsptr->basePointer = aa;    
    newCi->SSAPointers[I] = nsptr;
    newCi->InstOrder.push_back(I);
  }
}

void freeAA(AggregateAlloca * aa, set<AggregateAlloca *> & deleted) {
  vector<AggregateAlloca *> worklist;
  worklist.push_back(aa);
  while(worklist.size()) {
    AggregateAlloca * worker = worklist[0];
    if(deleted.find(aa) != deleted.end()) {
      worklist.erase(worklist.begin());
      continue;
    }
    for(unsigned i = 0; i < worker->getNumContained(); i++)
      worklist.push_back(worker->getContained(i));
    
    deleted.insert(worker);
    worklist.erase(worklist.begin());
    delete worker;
  }   
}

void freeContextInfo(ContextInfo * ci) {
  for(auto const &ent : ci->SSAPointers) {
    SSAPointer * sptr = ent.second;
    delete sptr;
  }
  set<AggregateAlloca *> deleted;
  for(unsigned i = 0; i < ci->AggregateAllocas.size(); i++)
    freeAA(ci->AggregateAllocas[i], deleted);
}

void handleReturn(Function * F, BasicBlockContInfoMap bbc) {
  for (Function::iterator f_it = F->begin(), f_ite = F->end();
       f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    delete bbc[BB];
  }
}

void updateBBInfo(ValueToValueMapTy & vmap, map<BasicBlock *, BBInfo *> & bbimap,
      Function * F) {
  for (Function::iterator f_it = F->begin(), f_ite = F->end();
       f_it != f_ite; ++f_it) {
    BasicBlock * BB = &*f_it;
    BasicBlock * nBB = dyn_cast<BasicBlock>(vmap[BB]);
    BBInfo * bbi = bbimap[BB];
    BBInfo * nbbi = initializeBBInfo(nBB);
    nbbi->writesToMemory = bbi->writesToMemory;
    nbbi->partOfLoop = bbi->partOfLoop;
    bbimap[nBB] = nbbi;
  } 
} 

void replaceConstArgs(Function * F, 
  vector<pair<unsigned, Constant *> > constArgs) {
  for(unsigned i = 0; i < constArgs.size(); i++) {
    unsigned index = constArgs[i].first;
    Constant * with = constArgs[i].second;
    getArg(F, index)->replaceAllUsesWith(with);
  }
}   

BasicBlock * foldToSingleSucc(TerminatorInst * termInst) {
  if(BranchInst *  BI = dyn_cast<BranchInst>(termInst)) {
    if(!BI->isConditional())
      return termInst->getSuccessor(0);
    if(ConstantInt * CI = dyn_cast<ConstantInt>(BI->getCondition())) {
      if(CI->getZExtValue())
        return termInst->getSuccessor(0);
      else 
        return termInst->getSuccessor(1);
    }
  } else if(SwitchInst * SI = dyn_cast<SwitchInst>(termInst)) {
    if(ConstantInt * CI = dyn_cast<ConstantInt>(SI->getCondition()))
      return SI->findCaseValue(CI).getCaseSuccessor();
  }
  return NULL;
}

bool straightPath(BasicBlock * from, BasicBlock * to, map<BasicBlock *, BBInfo *>
  bbi) {
  BasicBlock * worker = from;
  while(true) {
    vector<BasicBlock *> sv = bbi[worker]->SuccsV;
    if(sv.size() != 1)
      return false;
    if(sv[0] == to)
      return true;
    worker = sv[0];
  }
}

bool onlyCmpUses(LoadInst * loadInst) {
  for(const Use &U : loadInst->uses()) {
    const User *LU = U.getUser();
    if(!isa<CmpInst>(LU))
      return false;
  }
  return true;
}

void replaceAndLog(Instruction * from, Value * to) {
  from->replaceAllUsesWith(to);
  debug(Abubakar) << "replaced with " << *to << "\n";
}

CmpInst * foldCmp(CmpInst * CI, bool isNull, LLVMContext & context) {
  Value * oldLHS = CI->getOperand(0);
  Value * oldRHS = CI->getOperand(1);
  Value * newLHS;
  Value * newRHS;
  IntegerType * intTy = IntegerType::get(context, 1);
  if(isa<ConstantPointerNull>(oldLHS)) {
    newLHS = ConstantInt::get(intTy, 0);
    newRHS = ConstantInt::get(intTy, !isNull);
  } else if(isa<ConstantPointerNull>(oldRHS)) {
    newLHS = ConstantInt::get(intTy, !isNull);
    newRHS = ConstantInt::get(intTy, 0);   
  } else
    return NULL;
  CmpInst * NCI = CmpInst::Create(CI->getOpcode(), CI->getPredicate(),
                                  newLHS, newRHS);
  NCI->insertBefore(CI);
  debug(Abubakar) << *CI << " ";
  replaceAndLog(CI, NCI);
  return NCI;
}

void handleStrToL(CallInst * callInst, ContextInfo * ci, LLVMContext & context) {
  Value * stringArg = callInst->getArgOperand(0);
  Value * pointerArg = callInst->getArgOperand(1);
  Value * base = callInst->getArgOperand(2);
  ConstantInt * baseInt;
  if(ci->SSAPointers.find(stringArg) == ci->SSAPointers.end())
    return; 
  if(ci->SSAPointers.find(pointerArg) == ci->SSAPointers.end())
    return;
  SSAPointer * ssptr = ci->SSAPointers[stringArg];
  SSAPointer * psptr = ci->SSAPointers[pointerArg];
  AggregateAlloca * basePointer = psptr->basePointer;

  if(!(baseInt = dyn_cast<ConstantInt>(base))) {
    basePointer->setConstant(false);
    InsertUnique(*ci->modifiedAllocas, basePointer->getId());    
    return;
  }

  char * str = (char *) ssptr->basePointer->getAlloca()->data;
  debug(Abubakar) << "specializing strtol with " << str << "\n";
  char * ptr;
  int ret = strtol(str, &ptr, baseInt->getZExtValue());
  IntegerType * int64Ty = IntegerType::get(context, 64);
  replaceAndLog(callInst, ConstantInt::get(int64Ty, ret));

  debug(Abubakar) << "specialized ptr is " << ptr << "\n";
  Type * baseType = basePointer->getType()->getContainedType(0);
  int length = strlen(ptr);
  Type * arType = ArrayType::get(baseType, length);
  AggregateAlloca * aa = new AggregateAlloca(arType);
  basePointer->setOrInsert(0, aa);
  aa->Ntype = scalarPtrType;
  InsertUnique(*ci->modifiedAllocas, basePointer->getId());    

  char * source = (char *) aa->getAlloca()->data;
  memcpy(source, ptr, length);
  aa->getAlloca()->fillInit(0, length, true);
}
