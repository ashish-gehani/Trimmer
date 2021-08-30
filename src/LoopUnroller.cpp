// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*This file contain methods for loop unrolling such as getting trip count, whether the loop is a File I/O loop, whether the loop should be unrolled etc
and performs loop unrolling using UnrollLoop function in LLVM.*/

#include "LoopUnroller.h"

LoopUnroller::LoopUnroller(Module *m, bool preserveLcssa, bool useAnnot, Loop *L, LoopInfo *li) {
  module = m;
  PreserveLCSSA = preserveLcssa;
  useAnnotations = useAnnot;
  loop = L;
  ti = NULL;
  cloneOf = NULL;
  LI = li;
  fileTripCount = 0;
}

LoopUnroller::~LoopUnroller() {
  if(ti)
    delete ti;
}

void LoopUnroller::checkTermInst(Instruction * I, uint64_t seconds) {
  assert(ti && "no loop unroll test");
  if(ti->terminated)
    return;
  if(ti->checkBreakInst(I)) {
    ti->terminated = true;
  } else ti->updateIter(I); 
  ti->updateTime(I, seconds);
}

bool LoopUnroller::testTerminated() {
  assert(ti && "no loop unroll test");
  return ti->terminated;
}

bool LoopUnroller::checkUnrollHint(BasicBlock * hdr, LoopInfo &LI, Module *module) {
  Value * unrollH = module->getNamedValue("unroll_loop");
  Value *unrollHTwo = module->getNamedValue("unroll_loop_two");

  auto checkHint = [&](Value *unrollH) {
    if(!unrollH)
      return false;

    for(Use &U : unrollH->uses()) {
      Instruction * inst = dyn_cast<Instruction>(U.getUser());
      BasicBlock * BB = inst->getParent();
      Loop * L = LI.getLoopFor(BB);
      if(L && L->getHeader() == hdr)
        return true; 
    }
    return false;
  };

  return checkHint(unrollH) || checkHint(unrollHTwo); 
}

bool LoopUnroller::shouldSimplifyLoop(BasicBlock *BB, LoopInfo &LI, Module *m, bool useAnnotations) {
  if(useAnnotations && !checkUnrollHint(BB, LI, m))
    return false;
  //expectation in loop rotated form
  Loop *L = LI.getLoopFor(BB);
  BasicBlock* preheader = L->getLoopPreheader();
  auto terminator = preheader->getTerminator();

  if(pred_begin(preheader) == pred_end(preheader)) {
    debug(Yes) << "shouldSimplifyLoop: preheader has no predecessor\n";
  } else {
    preheader = *pred_begin(preheader);
    terminator = preheader->getTerminator();
  }

  debug(Yes) << "shouldSimplifyLoop: " << *terminator << "\n";
  if(auto branch = dyn_cast<BranchInst>(terminator)) {
    if(branch->isUnconditional()) {
      debug(Yes) << "shouldSimplifyLoop: unconditional branch\n";
      return true;
    } else {
      if(dyn_cast<Constant>(branch->getCondition())) {
        debug(Yes) << "shouldSimplifyLoop: constant condition\n";
        return true;
      }
    }
  } else if(auto branch = dyn_cast<SwitchInst>(terminator)) {
    if(auto si = dyn_cast<Constant>(branch->getCondition())) {
      debug(Yes) << "shouldSimplifyLoop: constant condition\n";
      return true;
    }
  }
  debug(Yes) << "shouldSimplifyLoop: false\n";
  return false;
}

bool LoopUnroller::getTripCount(TargetLibraryInfo * TLI, AssumptionCache &AC, unsigned &tripCount, bool isFileIOLoop) {
  BasicBlock *header = loop->getHeader();
  Function * F = loop->getHeader()->getParent();
  DominatorTree DT(*F);
  ScalarEvolution SE(*F, *TLI, AC, DT, *LI);
  tripCount =  SE.getSmallConstantMaxTripCount(loop);
  debug(Yes) << "Trip Multiple " << SE.getSmallConstantTripMultiple(loop) << "\n";
  if(tripCount >= 100000)
    tripCount = 0;

  for(auto &I: *header) {
    debug(Yes) << I << "\n";
      if(CallInst *call = dyn_cast<CallInst>(&I)) {
        debug(Yes) << call->getName() << " name\n";
        if(call->getCalledFunction() && call->getCalledFunction()->getName() == "unroll_loop_two") {
          tripCount = dyn_cast<ConstantInt>(call->getOperand(1))->getZExtValue();
          debug(Yes) << "Here : " << tripCount << "\n";
        }
      }
  }

  if(!tripCount || tripCount > 10000 || tripCount > 1000){
    if(isFileIOLoop)
      tripCount = fileTripCount + 5;
    else
      tripCount = DEFAULT_TRIP_COUNT + 5;
    return false;
  }

  return true;
}

bool LoopUnroller::runtest(TargetLibraryInfo * TLI, AssumptionCache &AC, RegOps regOps,BBOps bbOps,map<int,uint64_t> fdInfoMap, BasicBlock * currBB) {

  unsigned tripCount;
  bool isFileIOLoop = checkIfFileIOLoop(loop, regOps, bbOps,fdInfoMap, currBB);

  bool constTripCount = getTripCount(TLI, AC, tripCount, isFileIOLoop);

  debug(Yes) << "ConstTripCount :" << constTripCount << "\n";

  debug(Yes) << "TripCount :" << tripCount << "\n";
  ti = new LoopUnrollTest(loop, module, constTripCount, isFileIOLoop,fileTripCount);

  if(!doUnroll(TLI, AC, tripCount)) {
    delete ti;
    ti = NULL;
    return false;
  }
  return true;
}



bool LoopUnroller::doUnroll(TargetLibraryInfo * TLI, AssumptionCache &AC, unsigned tripCount) {
  Function * F = loop->getHeader()->getParent();
  DominatorTree DT(*F); 

  ScalarEvolution SE(*F, *TLI, AC, DT, *LI);
  Loop * L = LI->getLoopFor(loop->getHeader());
  OptimizationRemarkEmitter ORE(F); 
  debug(Yes) << "Trying trip count: " << tripCount << "\n";
  bool allowRuntime = false;
  bool unrollRemainder = false;
  int UnrollResult = (int) UnrollLoop(L, tripCount, tripCount, true, allowRuntime, false, 
                true, false, 1, 0, unrollRemainder ,LI, &SE, &DT, &AC, &ORE, PreserveLCSSA);//unrollRemaineder set to false currently
  if(!UnrollResult) {
    debug(Yes) << "failed in unrolling\n";
    return false;
  }
  debug(Yes) << "succeeded in unrolling for " << tripCount << " iterations\n";
  return true;
}

bool LoopUnroller::checkPassed() {
  assert(ti && "no loop unroll test");
  return ti->checkPassed();
}

void LoopUnroller::setCloneOf(Function *F) {
  cloneOf = F;
}

Function *LoopUnroller::getCloneOf() {
  return cloneOf;
}

LoopInfo *LoopUnroller::getLoopInfo() {
  return LI;
}

bool LoopUnroller::deleteLoop(BasicBlock *failed) {
  CallInst *unrollCall = NULL;
  for(auto &I: *failed) {
    if(auto call = dyn_cast<CallInst>(&I))
      if(call->getCalledFunction() && call->getCalledFunction()->getName() == "unroll_loop")
        unrollCall = call;
  }

  if(!unrollCall)
    return false;

  Module *module = failed->getParent()->getParent();
  Value * unrollH = module->getNamedValue("unroll_loop");
  if(!unrollH) return false;

  set<Instruction*> toDelete;
  toDelete.insert(unrollCall);

  for(auto user: unrollH->users()) {
    CallInst *call = NULL;
    if(!(call = dyn_cast<CallInst>(user)))
        continue;

    assert(call->getNumArgOperands() == 1);

    if(call->getArgOperand(0) == unrollCall->getArgOperand(0))
      toDelete.insert(call);
  }

  for(auto &del: toDelete) {
    debug(Yes) << "DELETING: " << *del << "\n";
    del->dropAllReferences();
    del->eraseFromParent();
  }

  return true;
}

bool LoopUnroller::checkIfFileIOLoop(Loop * L, RegOps regOps,BBOps bbOps,map<int,uint64_t> fdInfoMap, BasicBlock * currBB) {
  int size = 1;
  for (Loop::block_iterator LoopIter = L->block_begin(), End = L->block_end(); LoopIter != End; ++LoopIter) {
    BasicBlock * B = *LoopIter;
    for (auto Inst = B->begin(), J = B->end(); Inst != J; ++Inst) {
       if(strcmp(Inst->getOpcodeName(),"call")==0){
          CallInst* callInst = dyn_cast<CallInst>(Inst);
          if(callInst->isInlineAsm())
            continue;
          Function * func = callInst->getCalledFunction();
          if(func==NULL)
            continue;
          string funcname = func->getName().str();
          if(funcname.compare("read")== 0 || funcname.compare("pread")== 0)
          {
            Value * fdVal = callInst->getOperand(0);
            Value * sizeVal = callInst->getOperand(2);
            if(Register *r = regOps.getRegister(dyn_cast<CallInst>(fdVal))){     
              uint64_t fileId = r->getValue();
              uint64_t addr = fdInfoMap[fileId];
              FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB); 
              debug(Yes)<<fdi->fileName;  
              if(ConstantInt * CI = dyn_cast<ConstantInt>(sizeVal))
                size =  CI->getZExtValue();
              fileTripCount = getNumCharacters(fdi->fileName,size);  
              debug(Yes)<<"numcharacters"<<fileTripCount; 
              return true;
            }
          }
          else if(funcname.compare("fread")== 0)
          {
            Value * fdVal = callInst->getOperand(3);
            Value * sizeVal = callInst->getOperand(1);
            Value * numVal = callInst->getOperand(2);
            if(Register *r = regOps.getRegister(dyn_cast<CallInst>(fdVal))){  
                 
              uint64_t fileId = r->getValue();
              uint64_t addr = fdInfoMap[fileId];
              FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB); 
              debug(Yes)<<fdi->fileName;  
              if(ConstantInt * CI = dyn_cast<ConstantInt>(sizeVal))
                if(ConstantInt * CI2 = dyn_cast<ConstantInt>(numVal))
                  size =  CI->getZExtValue() * CI2->getZExtValue();
              fileTripCount = getNumCharacters(fdi->fileName,size);  
              debug(Yes)<<"numcharacters"<<fileTripCount; 
              return true;
            }
          
          }

          else if(funcname.compare("fgets")== 0)
          {

            Value * fdVal = callInst->getOperand(2);
            if(Register *r = regOps.getRegister(dyn_cast<CallInst>(fdVal))) { 
              uint64_t fileId = r->getValue();
              uint64_t addr = fdInfoMap[fileId];
              FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB); 
              debug(Yes)<<fdi->fileName; 
              fileTripCount = getNumLines(fdi->fileName);         
              return true;
            }
          } 
  
 
         else if(funcname.compare("getline")== 0)
          {
            Value * fdVal = callInst->getOperand(2);
            if(Register *r = regOps.getRegister(dyn_cast<CallInst>(fdVal))){     
              uint64_t fileId = r->getValue();
              uint64_t addr = fdInfoMap[fileId];
              FdInfo * fdi = (FdInfo *) bbOps.getActualAddr(addr, currBB); 
              debug(Yes)<<fdi->fileName;  
              fileTripCount = getNumLines(fdi->fileName);   
              return true;
            }
          }                   
        }
      }
    }

  return false;
}

int LoopUnroller::getNumLines(char * fileName) {
  FILE *fp; 
  int count = 0;
  char c;
  fp = fopen(fileName, "r"); 
  if (fp == NULL) {
    printf("Could not open file %s", fileName); 
    return 0;
  }
  for (c = getc(fp); c != EOF; c = getc(fp)){
    if (c == '\n') 
      count = count + 1; 
  }

  fclose(fp);
  return count;
}

int LoopUnroller::getNumCharacters(char * fileName, int size) {
  FILE *fp; 
  int count = 0;
  char c;
  fp = fopen(fileName, "r"); 
  if (fp == NULL) {
    printf("Could not open file %s", fileName); 
    return 0;
  }
  for (c = getc(fp); c != EOF; c = getc(fp)){ 
      count = count + 1; 
  }

  fclose(fp);
  return count/size;
}
