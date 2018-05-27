using namespace std;
using namespace llvm;

#ifndef TYPES_H_
#define TYPES_H_

#include "mem.h"

#define LOOPTERM "__loop_termination_test__"

enum ProcResult {
  UNDECIDED,
  NOTFOLDED,
  PARTOFLOOP,
  FOLDED
};

enum LoopOp {
  NOOP,
  UNROLLOP,
  PEELOP
};

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
  BasicBlock * headerBB; // if we fold to the exit then loopPeeling was succesful
                                   // if we reach the header then it was unsuccesful                 
  vector<Instruction *> indepInsts;
  map<Instruction *, ProcResult> InstResults; 
  unsigned numOrigInsts, partOfLoop;
  TestInfo(Loop * L, CallInst * testCall, LoopOp op) {
    terminated = passed = false;
    headerBB = op == PEELOP ? L->getHeader() : NULL;
    BasicBlock * exitBB = L->getUniqueExitBlock();
    Instruction * first = &*exitBB->begin();
    if(isa<TerminatorInst>(first)) testCall->insertBefore(first);
    else testCall->insertAfter(first);
    numOrigInsts = partOfLoop = 0;
    for(auto block : L->blocks()) {
      BasicBlock * BB = &*block;
      numOrigInsts += distance(BB->begin(), BB->end());
    }  
  } 
  bool checkExitBB(BasicBlock * BB) {
    for(BasicBlock::iterator it = BB->begin(); it != BB->end(); it++) {
      Instruction * I = &*it;
      if(CallInst * ci = dyn_cast<CallInst>(I)) {
        if(ci->getCalledFunction()->getName().str() == LOOPTERM)
          return true;
      }
    }
    return false;  
  }
};

struct FdInfo {
  int fd, offset;
  bool tracked;
};

typedef map<BasicBlock *, ContextInfo *> BasicBlockContInfoMap;
typedef map<Function *, ContextInfo *> FuncContInfoMap;
typedef pair<Instruction *, Instruction *> InstPair;
typedef map<Function *, FuncInfo *> FuncInfoMap;
typedef set<Value *> ValSet;

#endif