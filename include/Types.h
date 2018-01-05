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
  FuncInfo() {
    context = NULL;
    retReg = NULL;
  }
};

struct BBInfo {
  bool writesToMemory, partOfLoop, isHeader;
  unsigned numPreds, URfrom;
  vector<BasicBlock *> loopLatchesWithEdge, SuccsV;
  BBInfo(BasicBlock * BB) {
    writesToMemory = false;
    partOfLoop = false;
    isHeader = false;
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

typedef map<BasicBlock *, ContextInfo *> BasicBlockContInfoMap;
typedef map<Function *, ContextInfo *> FuncContInfoMap;
typedef pair<Instruction *, Instruction *> InstPair;
typedef map<Function *, FuncInfo *> FuncInfoMap;

#endif