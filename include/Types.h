using namespace std;
using namespace llvm;

#ifndef TYPES_H_
#define TYPES_H_

#include "mem.h"

struct ContextInfo {
  Memory * memory;
  BasicBlock::iterator inst;

  ContextInfo * cloneOf;  
  bool deleted;

  ContextInfo() {
    deleted = false;
    cloneOf = NULL;
  }
  ContextInfo(Module * M) {
    deleted = false;
    cloneOf = NULL;
    memory = new Memory(M);    
  }
  ContextInfo * clone() {
    ContextInfo * nci = new ContextInfo();
    nci->memory = memory;
    if(cloneOf)
      nci->cloneOf = cloneOf;
    else
      nci->cloneOf = this;
    return nci;        
  }
  ContextInfo * duplicate() {
    ContextInfo * nci = new ContextInfo();
    nci->memory = new Memory(*memory);
    return nci;
  }
};

struct FuncInfo {
  Memory * context;
  Register * retReg;
  bool usedInLoop, addrTaken;
  unsigned directCallInsts;
  FuncInfo(Function * F) {
    context = NULL;
    retReg = NULL;
    addrTaken = (F->hasAddressTaken() > 0);
    usedInLoop = false;
    directCallInsts = 0;
  }
};

struct BBInfo {
  bool writesToMemory, partOfLoop, isHeader, singleSucc;
  unsigned numPreds, URfrom;
  vector<BasicBlock *> loopLatchesWithEdge, ancestors;
  BBInfo(BasicBlock * BB) {
    writesToMemory = false;
    partOfLoop = false;
    isHeader = false;
    singleSucc = false;
    URfrom = 0;
    numPreds = 0;
    set<BasicBlock *> preds;
    for(auto it = pred_begin(BB), et = pred_end(BB); it != et; it++) {
      BasicBlock * predecessor = *it;
      if(preds.find(predecessor) == preds.end()) {
        numPreds++;
        preds.insert(predecessor);
      }
    }   
  }
};

struct TestInfo {
  bool terminated, passed;
  unsigned numLoads, numfolded;
  BasicBlock * exitBB, * headerBB; // if we fold to the exit then loopPeeling was succesful
                                  // if we reach the header then it was unsuccesful                 
  TestInfo(Loop * L) {
    terminated = passed = false;
    numLoads = numfolded = 0;
    exitBB = L->getUniqueExitBlock();
    headerBB = L->getHeader();
  }
};
typedef map<BasicBlock *, ContextInfo *> BasicBlockContInfoMap;
typedef map<Function *, ContextInfo *> FuncContInfoMap;
typedef pair<Instruction *, Instruction *> InstPair;
typedef map<Function *, FuncInfo *> FuncInfoMap;
typedef set<Value *> ValSet;
#endif