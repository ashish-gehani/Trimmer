#include "llvm/Pass.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"
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
#include "InterConstProp.h"

using namespace llvm;
using namespace std;     

/* This routine marks a cloned call context as specialized */
/* TODO-IMP: Mark specialized whenever any specialization occurs */
void ConstantFolding::markSpecialized(BasicBlock * BB) {
  Function * func = BB->getParent();  // Get containing function
  if(specializedCalls.find(func) != specializedCalls.end()){ // If function is a cloned function
    SpecializedCall * call = specializedCalls[func];
    call->used = true;  // Marking the cloned call as specialized - replaces original call
  }  
}

void ConstantFolding::processAllocaInst(AllocaInst * allocaInst) {
  Instruction * I = allocaInst;
  Type * allocatedType = allocaInst->getAllocatedType();
  allocate(allocatedType, I);
}

void ConstantFolding::processMallocInst(unsigned totalSize, Instruction* I) {
  assert(isa<PointerType>(I->getType()) && 
    "malloc called for non pointer Instruction");
  Type* baseType = I->getType()->getContainedType(0);
  unsigned typeSize = DL->getTypeAllocSize(baseType);
  unsigned numel = totalSize/typeSize;
  SSAPointer* sptr;
  if(baseType->getNumContainedTypes()) {
    sptr = new SSAPointer(I->getType());
    for(unsigned i = 0; i < numel; i++) 
      sptr->basePointer->setOrInsert(i, new AggregateAlloca(baseType));
  } else {
    Type * arType = ArrayType::get(baseType, numel);
    sptr = new SSAPointer(arType); 
    sptr->basePointer->Ntype = scalarPtrType;
  } 
  allocate(sptr, I);  
}

void ConstantFolding::processBitCastInst(BitCastInst * bitcastInst) {
  Value* from = bitcastInst->getOperand(0);
  SSAPointer * sptr = getSSAPointer(from);
  if(!sptr)
    return;
  Type * fromType = from->getType();
  if(isa<PointerType>(fromType) && fromType->getContainedType(0)->isIntegerTy(8)) {
    unsigned totalSize = sptr->basePointer->getAlloca()->getSize() - 
      sptr->position;
    processMallocInst(totalSize, bitcastInst);
  } 
  // else {
  //   ContextInfo * ci = BasicBlockContexts[currBB];   
  //   ci->SSAPointers[bitcastInst] = new SSAPointer(sptr);     
  // }
  //  else {
  //   sptr->basePointer->setConstant(false);
  //   InsertUnique(ci->modifiedAllocas, sptr->basePointer->getId());    
  // }
}

void ConstantFolding::processMemcpyInst(MemCpyInst * memcpyInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value * toPtr = memcpyInst->getOperand(0);
  Value * fromPtr = memcpyInst->getOperand(1);
  SSAPointer * sptr = getSSAPointer(toPtr);
  if(!sptr) {
    debug(Abubakar) << "MemCpyInst : not found in map\n";
    return;
  }
  AggregateAlloca * basePointer = sptr->basePointer;
  // if(basePointer->isNodeTypeOf(structType)) {
  //   if(SSAPointer * ssptr = getSSAPointer(fromPtr)) {
  //     AggregateAlloca * sourcePtr = ssptr->basePointer;
  //     errs() << "both are present\n";
  //     basePointer->copy(sourcePtr);
  //     errs() << sourcePtr->isConstant() << "\n";
  //     errs() << basePointer << "\n";
  //   } else
  //     basePointer->setConstant(false);
  //   return;
  // }
  int offset = sptr->position;
  ScalarAlloca * alloca = basePointer->getAlloca();
  char * sourceBuffer = (char*) alloca->data;
  sourceBuffer += offset;
  StringRef stringRef;
  char * fromString;
  if(getConstantStringInfo(fromPtr, stringRef, 0, false)) {
    fromString = new char[stringRef.str().size()];
    strcpy(fromString, stringRef.str().c_str());
  } else if(SSAPointer * ssptr = getSSAPointer(fromPtr))
    fromString = (char *) ssptr->basePointer->getAlloca()->data;
  else {
    debug(Abubakar) << "MemCpyInst : destbuffer not found in map\n";
    basePointer->setConstant(false);
    InsertUnique(*ci->modifiedAllocas, basePointer->getId());
    return;     
  }
  debug(Abubakar) << "memcpy " << fromString << "\n";
  int length = strlen(fromString);   
  memcpy(sourceBuffer, fromString, length);
  alloca->fillInit(offset, length, true);
  alloca->setModified(offset, length);
  InsertUnique(*ci->modifiedAllocas, basePointer->getId());
}


void ConstantFolding::processStoreInst(StoreInst * storeInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value* storeOp = storeInst->getOperand(0);
  Value * ptr = storeInst->getOperand(1);
  SSAPointer * sptr = getSSAPointer(ptr);
  if(!sptr) {
    debug(Abubakar) << "storeInst : not found in map\n";
    return;
  }
  AggregateAlloca * basePointer = sptr->basePointer;
  if(basePointer->isNodeTypeOf(ptrType)) {
    // if(Function * F = dyn_cast<Function>(storeOp)) {
    //   AggregateAlloca * aa = new AggregateAlloca(F->getType());
    //   aa->setFunction(F);
    //   InsertUnique(ci->AggregateAllocas, aa);
    //   updateMap(ci->idmap, aa);      
    //   basePointer->setOrInsert(0, aa);
    // } else 
    if(isa<ConstantPointerNull>(storeOp)) 
      basePointer->setNullPointer();
    else {
      SSAPointer * nsptr = getSSAPointer(storeOp);
      if(!nsptr) {
        basePointer->setConstant(false);
      } else {
        basePointer->setOrInsert(0, nsptr->basePointer);
      }
    }
  } else if(basePointer->isNodeTypeOf(scalarType) ||
   basePointer->isNodeTypeOf(scalarPtrType)) {
    ScalarAlloca * alloca = basePointer->getAlloca();
    int allocaSize = alloca->getSize();    
    if(allocaSize > 1 && !basePointer->isConstant()) {
      debug(Abubakar) << ".. Skipping non constant basePointer string ... \n";
      return;
    }        
    Value * storeOperand = storeInst->getOperand(0);
    int constantValue;
    if(ConstantInt * constOp = dyn_cast<ConstantInt>(storeOperand))
      constantValue = constOp->getZExtValue();
    else {
      debug(Abubakar) << "--- Marking basePointer as non-const \n";
      basePointer->setConstant(false);
      InsertUnique(*ci->modifiedAllocas, basePointer->getId());
      return;
    }
    int offset = sptr->position;
    alloca->storeConstVal(constantValue, offset);
    alloca->setInit(offset, true);
    alloca->setModified(offset, 1);
    if(alloca->getSize() == 1)
      basePointer->setConstant(true);

  } 
  InsertUnique(*ci->modifiedAllocas, basePointer->getId());
}
AggregateAlloca * config = NULL;
void ConstantFolding::processLoadInst(LoadInst * loadInst) {

  if(loadInst->getParent() && BBInfoMap[loadInst->getParent()]->partOfLoop) {
    return;
  }
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value * ptr = loadInst->getOperand(0);
  SSAPointer * sptr = getSSAPointer(ptr);
  if(!sptr) {
    debug(Abubakar) << "loadInst : not found in map\n";
    return;
  }     
  AggregateAlloca * basePointer = sptr->basePointer;
  if(!basePointer->isConstant()) {
    debug(Abubakar) << ".. Skipping non constant alloca string ... \n";
    return;
  }
  if(basePointer->isNodeTypeOf(scalarPtrType) && isa<PointerType>(loadInst->getType())) {
    ci->SSAPointers[loadInst] = new SSAPointer(basePointer);
  } else if(basePointer->isNodeTypeOf(ptrType)) {
    if(basePointer->isNullPointer()) {
      PointerType * loadedType = dyn_cast<PointerType>(loadInst->getType());
      ConstantPointerNull * nptr = ConstantPointerNull::get(loadedType);
      replaceAndLog(loadInst, nptr);
    } else {
      ci->SSAPointers[loadInst] = new SSAPointer(basePointer->getContained(0));
    }
  } else if(basePointer->isNodeTypeOf(scalarType) || 
      basePointer->isNodeTypeOf(scalarPtrType)) {
    ScalarAlloca * alloca = basePointer->getAlloca();     
    int offset = sptr->position; 
    if(!alloca->getInit(offset))
      debug(Abubakar) << ".. LoadInst : value not initialized ... \n";
    replaceAndLog(loadInst, alloca->createConstVal(offset));
  }
}

void ConstantFolding::processGEPInst(GetElementPtrInst * GEPInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Value * ptr = GEPInst->getOperand(0);
  SSAPointer * sptr = getSSAPointer(ptr);
  if(!sptr) {
    debug(Abubakar) << "GEPInst : not found in map\n";
    return;
  }    
  AggregateAlloca * basePointer = sptr->basePointer;
  Value * indexValue;
  vector<unsigned> indices;
  for(auto index = GEPInst->idx_begin(), end = GEPInst->idx_end(); index != end; index++){
    indexValue = *index;            
    if(ConstantInt *Idx = dyn_cast<ConstantInt>(indexValue)){
      indices.push_back(Idx->getZExtValue());
    }
    else {
      debug(Abubakar) << "GEPInst : index not constant\n";
      basePointer->setConstant(false);
      InsertUnique(*ci->modifiedAllocas, basePointer->getId());
      return;
    }
  } 

  if(basePointer->isNodeTypeOf(scalarType) || basePointer->isNodeTypeOf(scalarPtrType))
    handleBaseDataTypeGEP(indices, sptr, GEPInst, ci->SSAPointers);
  else {
    if(!basePointer->isConstant()) {
      debug(Abubakar) << "GEPInst : not constant\n";
      return;
    }

    if(indices.size() == 1)
      basePointer = basePointer->getContained(indices[0]);

    if(indices.size() >= 2 && basePointer->isNodeTypeOf(ptrType))
      basePointer = basePointer->getContained(indices[0]);
    
    for(unsigned i = 1; i < indices.size(); i++) {
      if(basePointer->isNodeTypeOf(scalarType) || 
        basePointer->isNodeTypeOf(scalarPtrType)) {
        std::vector<unsigned> split(indices.begin() + i, indices.end());  
        handleBaseDataTypeGEP(split, basePointer, GEPInst, ci->SSAPointers);
        return;
      }
      basePointer = basePointer->getContained(indices[i]);
    }   
    ci->SSAPointers[GEPInst] = new SSAPointer(basePointer);
  }
}

void ConstantFolding::processPHINode(PHINode * phiNode) {
  if(phiNode->getParent() && BBInfoMap[phiNode->getParent()]->partOfLoop) {
    return;
  }
  ContextInfo * ci = BasicBlockContexts[currBB];
  vector<unsigned> incV;
  for(unsigned i = 0; i < phiNode->getNumIncomingValues(); i++) {
    BasicBlock * BB = phiNode->getIncomingBlock(i);
    if(visited.find(BB) == visited.end())
      continue;
    // if(!findInVect(BBInfoMap[BB]->SuccsV, currBB))
    //   continue;
    incV.push_back(i);
  }
  for(unsigned i = 0; i < incV.size(); i++) {
    BasicBlock * first = phiNode->getIncomingBlock(incV[i]);
    for(unsigned j = 0; j < incV.size(); j++) {
      BasicBlock * second = phiNode->getIncomingBlock(incV[j]);
      if((first == second && j != i)
      || straightPath(second, first, BasicBlockContexts)) {
        incV.erase(incV.begin() + j);
        if(j < i)
          i--;
        j--;
      }
    }
  }
  Value * val = NULL; 
  for(unsigned i = 0; i < incV.size(); i++) {
    Value * temp = phiNode->getIncomingValue(incV[i]);
    if(val && temp != val) {
      debug(Abubakar) << "phiNode not constant\n";
      return;
    }
    val = temp;
  }
  if(ConstantInt * CI = dyn_cast<ConstantInt>(val)) {
    debug(Abubakar) << "folded phinode to constant " << *CI << "\n";
    replaceAndLog(phiNode, CI);
    return;
  } else if(ConstantPointerNull * CN = dyn_cast<ConstantPointerNull>(val)) {
    debug(Abubakar) << "folded phinode to constant " << *CN << "\n";
    replaceAndLog(phiNode, CN);
    return;
  }
  SSAPointer * sptr = getSSAPointer(val);
  if(!sptr) {
    debug(Abubakar) << "phinode corresponding value not found in map " << *val << "\n";
    return;
  }
  ci->SSAPointers[phiNode] = new SSAPointer(sptr);
  debug(Abubakar) << "replaced phinode with value " << *val << "\n";
}

AggregateAlloca * test_name = NULL;
void ConstantFolding::processCallInst(CallInst * callInst) {
  ContextInfo * ci = BasicBlockContexts[currBB];
  Instruction * I = callInst; 
  Function * calledFunction = callInst->getCalledFunction();  
  // Indirect function calls need special handling
  if(calledFunction == NULL) {
    bool tracked = false;
    // Value * ptr = callInst->getOperand(callInst->getNumArgOperands() - 1);
    // if(SSAPointer * sptr = getSSAPointer(ptr)) {
    //   AggregateAlloca * basePointer = sptr->basePointer;
    //   calledFunction = basePointer->getFunction();
    //   if(calledFunction && basePointer->isConstant())
    //     tracked = true;
    // }
    if(!tracked) {
      handleIndirectCall(callInst, ci);
      ci->inst++;
      return;
    }
  }  
  if(BBInfoMap[currBB]->partOfLoop) {
    ci->inst++;
    return;
  }
  /* specialize for functions defined in string.h e.g strcmp, strchr */
  if(isStringFunction(calledFunction)) {
    if(callInst->use_empty()){
      ci->inst++;
      return; // Skip simplifying functions with unused results
    }
    if(calledFunction->getName().str() == "strtol") {
      handleStrToL(callInst, ci, M->getContext());
      ci->inst++;
      return;
    }
    if(calledFunction->getName().str() == "atoi") {
      handleAtoi(callInst, ci, M->getContext());
      ci->inst++;
      return;
    }
    Instruction * next = callInst; 
    int specIndex = 0;
    bool tracked = false;
    for(unsigned int index = 0; index < callInst->getNumArgOperands(); index++) {
      Value * pointerArg = callInst->getArgOperand(index);
      SSAPointer * sptr = getSSAPointer(pointerArg);
      if(!sptr) {
        StringRef stringRef;
        if(getConstantStringInfo(pointerArg, stringRef, 0, false)) {
          debug(Abubakar) << "StringFunc : constant string " << stringRef.str() << "\n";
          tracked = true;
        } else 
          debug(Abubakar) << "StringFunc : Arg " << index << " not found in map\n";
        continue;
      }
      tracked = true;
      AggregateAlloca * basePointer = sptr->basePointer;
      if(!basePointer->isConstant()) {
        debug(Abubakar) << "StringFunc : Arg " << index << " not constant\n";
        continue;
      }
      ScalarAlloca * alloca = basePointer->getAlloca();
      char * baseStringData = (char*) alloca->data;
      int offset = sptr->position; 
      char * newStr = baseStringData + offset;
      IntegerType * intTy = IntegerType::get(M->getContext(), 64);
      ConstantInt * index1 = ConstantInt::get(intTy, 0);
      vector<Value *> indxList;
      indxList.push_back(index1); 
      indxList.push_back(index1);
      Constant * stringConstant = ConstantDataArray::getString(M->getContext(), 
							       StringRef(newStr), true);
      GlobalVariable * globalReadString = new GlobalVariable(*M, stringConstant->getType(), true,
							     GlobalValue::ExternalLinkage, 
							     stringConstant, "");

      GetElementPtrInst * stringPtr = GetElementPtrInst::Create(NULL, globalReadString, 
								indxList, Twine(""), callInst);
      debug(Abubakar) << "tracking str in strngfunction " << newStr << "\n";      
      if(specIndex == 0)
        next = stringPtr;  
      specIndex++;    
      callInst->setOperand(index, stringPtr);
    }
    if(!tracked) {
      ci->inst++;
      return;
    }
    auto InstCombineRAUW = [this](Instruction *From, Value *With) {
      From->replaceAllUsesWith(With);
    };
    LibCallSimplifier Simplifier(*DL, TLI, InstCombineRAUW);
    if (Value *With = Simplifier.optimizeCall(callInst)) {
      debug(Abubakar) << "Value to replace = " << *With << "\n";
      if(!callInst->use_empty()) {  
      	replaceAndLog(callInst, With);              
      	ci->inst = BasicBlock::iterator(next);
      	debug(Hashim) << "Replaced uses of = " << *callInst << "\n";
      	BasicBlock * BB = I->getParent();
      	markSpecialized(BB);  // Mark the function as specialized - replaces original function
        return; // already set "inst" to the next instruction
      }
    } else {
      debug(Abubakar) << "StringFunc : failed to specialize, With is NULL\n";
    }

    /* optimize functions that are not in string.h */
    if(isSpecializable(calledFunction)) {
      string functionName = calledFunction->getName();
      /* optimizing atoi calls with constant strings with corresponding constant int */
      if(functionName == "atoi") {     
        printf("found atoi\n");        
      	StringRef stringRef;
      	if(getConstantStringInfo(callInst->getOperand(0), stringRef, 0, false)) {
      	  const char * constantString = stringRef.str().c_str();
      	  debug(Hashim) << "constant string = " << constantString << "\n";
      	  int val = atoi(constantString);
      	  IntegerType * int32Ty = IntegerType::get(M->getContext(), 32);
      	  ConstantInt * constVal = ConstantInt::get(int32Ty, val);
      	  callInst->replaceAllUsesWith(constVal);
      	  callInst->eraseFromParent();
      	  BasicBlock* BB = I->getParent();
      	  markSpecialized(BB);  // Mark the function as specialized - replaces original function
      	}
      }            
    }                         

    ci->inst++;
    return;  
  } else if(calledFunction->getName().str() == "malloc") {
    ConstantInt* sizeVal = dyn_cast<ConstantInt>(callInst->getArgOperand(0));
    if(!sizeVal) {
      ci->inst++;
      return;       
    }
    int totalSize = sizeVal->getZExtValue();
    processMallocInst(totalSize, callInst);
  } else if(!calledFunction->isDeclaration()) {
    if(!satisfyConds(calledFunction)) {
      markArgsAsNonConst(callInst, ci);
      ci->inst++;
      return;
    }
    AggregateAlloca * returnVal = NULL;
    Function * toRun = NULL; 
    ContextInfo * nci = new ContextInfo(true);
    if(FuncInfoMap[calledFunction]->usesGlobals || 
      AnnotationList.find(calledFunction) != AnnotationList.end()) {
      toRun = addClonedFunction(callInst, calledFunction);
      copyGlobals(ci, nci);
    }
    // else if(!calledFunction->arg_size() && 
    //   !calledFunction->getReturnType()->isVoidTy()) {
    //   if(FuncInfoMap[calledFunction]->visited) 
    //     returnVal = FuncInfoMap[calledFunction]->returnVal;
    //   else
    //     toRun = calledFunction; 
    // } 

    vector<unsigned> tracked;
    vector<pair<unsigned, Constant *> > constArgs;
    unsigned index = 0;
    for(auto arg = calledFunction->arg_begin(), argEnd = calledFunction->arg_end(); arg != argEnd;
        arg++, index++) {
      Value * pointerArg = callInst->getOperand(index);
      if(isa<ConstantInt>(pointerArg) || isa<ConstantPointerNull>(pointerArg) ||
        isa<ConstantFP>(pointerArg))        
        constArgs.push_back(make_pair(index, dyn_cast<Constant>(pointerArg)));

      SSAPointer * sptr = getSSAPointer(pointerArg);
      if(!sptr)
        continue;
      if(!toRun) {
        toRun = addClonedFunction(callInst, calledFunction);
        copyGlobals(ci, nci);
      }
      Value * pointerVal = getArg(toRun, index);
      SSAPointer * nsptr = new SSAPointer(sptr);
      nci->SSAPointers[pointerVal] = nsptr; 
      nci->InstOrder.push_back(pointerVal);
      InsertUnique(nci->AggregateAllocas, nsptr->basePointer);
      updateMap(nci->idmap, nsptr->basePointer);
      tracked.push_back(index);
    }
    if(!satisfyNumCond(calledFunction, nci)) {
      markArgsAsNonConst(callInst, ci);
      ci->inst++;
      return;
    }    
    if(toRun) {
      replaceConstArgs(toRun, constArgs); 
      returnVal = runOnFunction(toRun, calledFunction, nci);
      if(calledFunction->getName() == "scan_cmd_line") {
        ScalarAlloca * alloca = test_name->getAlloca();
        char * sourceBuffer = (char*) alloca->data;
        memcpy(sourceBuffer, "UDP_STREAM", 100);
      }
      // for(unsigned index = 0; index < tracked.size(); index++) {
      //   Value * pointerArg = callInst->getOperand(index);
      //   Value * pointerVal = getArg(toRun, index);

      //   AggregateAlloca * oldAA = getSSAPointer(pointerArg)->basePointer;
      //   AggregateAlloca * newAA = getSSAPointer(pointerVal, FuncInfoMap[toRun]->ci)->basePointer;
      //   if(oldAA == newAA)
      //     continue;
      //   // oldAA->copy(newAA);
      // }
    } else
      delete nci;
    if(returnVal) {
      if(!returnVal->getType()->getNumContainedTypes())
        replaceAndLog(callInst, returnVal->getAlloca()->createConstVal(0));
      else
        allocate(returnVal, callInst);       
    }      
  }
  //IMP: The following 'default' cause finds and marks any side effects of external calls
  else {
    // FIXIT: The call should have a clear purpose
    if(hasNoSideEffects(callInst)) { 
      ci->inst++;
      return;
    }
    markArgsAsNonConst(callInst, ci);
  }
  ci->inst++;
}

void ConstantFolding::tryFolding(Instruction * I) {
  if(I->getParent() && BBInfoMap[I->getParent()]->partOfLoop)
    return;
  Constant * constVal = ConstantFoldInstruction(I, *DL, TLI);
  if(constVal)
    replaceAndLog(I, constVal);
  else if(CmpInst * CI = dyn_cast<CmpInst>(I)) {
    if(!isa<PointerType>(CI->getOperand(0)->getType()))
      return;
    for(unsigned i = 0; i < CI->getNumOperands(); i++) {
      SSAPointer * sptr = getSSAPointer(CI->getOperand(i));
      if(!sptr)
        continue;
      if(CmpInst * NCI = foldCmp(CI, false, M->getContext()))
        tryFolding(NCI);
      break;
    }
  } else if(SelectInst * SI = dyn_cast<SelectInst>(I)) {
    if(ConstantInt * CI = dyn_cast<ConstantInt>(SI->getCondition())) {
      Value * rep = CI->getZExtValue() ? SI->getTrueValue() : SI->getFalseValue();
      if(ConstantInt * constVal = dyn_cast<ConstantInt>(rep)) {
        replaceAndLog(I, constVal);
        return;
      }
      SSAPointer * sptr = getSSAPointer(rep);
      if(!sptr)
        return;
      BasicBlockContexts[currBB]->SSAPointers[I] = new SSAPointer(sptr);
    }
  }
}

void ConstantFolding::processTermInst(TerminatorInst * termInst) {   
  if(BasicBlock * single = foldToSingleSucc(termInst)) {
    markSuccessorsAsUR(termInst, single);
    visitBB(single, termInst->getParent(), true);
    return;
  }
  for(unsigned int index = 0; index < termInst->getNumSuccessors(); index++)
    visitBB(termInst->getSuccessor(index), termInst->getParent(), false);
}

void ConstantFolding::processReturnInst(ReturnInst * returnInst) {
  Function * F = currBB->getParent();
  if(F->getName() == "main")
    return;
  FuncInfoMap[F]->ci = BasicBlockContexts[currBB]->clone();
  BasicBlockContexts[currBB]->useless = true;
  Value * ptr = returnInst->getReturnValue();
  if(!ptr)
    return;
  AggregateAlloca * aa = NULL;
  if(ConstantInt * CI = dyn_cast<ConstantInt>(ptr)) {
    aa = new AggregateAlloca(ptr->getType());
    ScalarAlloca * alloca = aa->getAlloca();
    alloca->storeConstVal(CI->getSExtValue(), 0);
    alloca->setInit(0, true);    
  } else if(SSAPointer * sptr = getSSAPointer(ptr, FuncInfoMap[F]->ci)) 
    aa = sptr->basePointer;
  if(!aa)
    return;
  if(FuncInfoMap[F]->returnVal) {
    FuncInfoMap[F]->returnVal->deepCheck(aa);
  } else {
    FuncInfoMap[F]->returnVal = aa;
  }
}