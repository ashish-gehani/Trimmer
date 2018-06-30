using namespace std;
using namespace llvm;

#ifndef TYPES_H_
#define TYPES_H_

#include "Mem.h"

#define LOOPEXITBB "__loop_termination_test__"
#define LOOPITERBB "__loop_iteration_test__"
#define PRNTDBGSTR "__print_debug_string__"
#define SETDBGLEVEL "__set_debug_level__"

#define DEFAULT_TRIP_COUNT 20


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
  bool writesToMemory, partOfLoop, isHeader;
  unsigned numPreds, URfrom, Rfrom;
  vector<BasicBlock *> loopLatchesWithEdge, ancestors;
  BasicBlock * singleSucc;
  BBInfo(BasicBlock * BB) {
    writesToMemory = false;
    partOfLoop = false;
    isHeader = false;
    singleSucc = NULL;
    URfrom = 0;
    numPreds = 0;
    Rfrom = 0;
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

CallInst * getTestInst(string, Module *);

struct TestInfo {
  bool terminated, ConstTripCount;              
  vector<Instruction *> indepInsts;
  map<Instruction *, ProcResult> InstResults; 
  unsigned numOrigInsts, partOfLoop, iterations;
  TestInfo(Loop * L, Module * module, bool tripCount) {
    terminated = false;
    ConstTripCount = tripCount;
    CallInst * testCall = getTestInst(LOOPEXITBB, module);
    CallInst * iterCall = getTestInst(LOOPITERBB, module);  
    SmallVector<BasicBlock*, 16> ExitBlocks;
    L->getUniqueExitBlocks(ExitBlocks);
    for(unsigned i = 0; i < ExitBlocks.size(); i++) {
      BasicBlock * BB = ExitBlocks[i];
      testCall->clone()->insertBefore(firstInst(BB));
    }
    testCall->dropAllReferences();
    BasicBlock * latchBB = L->getLoopLatch();
    iterCall->insertBefore(firstInst(latchBB));
    numOrigInsts = partOfLoop = iterations = 0;
    for(auto block : L->blocks()) {
      BasicBlock * BB = &*block;
      numOrigInsts += distance(BB->begin(), BB->end());
    }  
  } 
  Instruction * firstInst(BasicBlock * BB) {
    BasicBlock::iterator it;
    for(it = BB->begin(); it != BB->end(); it++) {
      if(!isa<PHINode>(&*it))
        break;
    }
    return &*it;    
  }
  bool checkTestInst(Instruction * I, string testName) {
    if(CallInst * ci = dyn_cast<CallInst>(I)) {
      if(ci->getCalledFunction()->getName().str() == testName)
        return true;
    }
    return false;
  }
  bool containsTestInst(BasicBlock * BB, string testName) {
    for(BasicBlock::iterator it = BB->begin(); it != BB->end(); it++)
      if(checkTestInst(&*it, testName)) return true;
    return false;
  }
  bool checkBreakInst(Instruction * I) {
    return checkTestInst(I, LOOPEXITBB);  
  }
  void updateIter(Instruction * I) {
    if(checkTestInst(I, LOOPITERBB)) iterations++;  
  }
  bool checkPassed() {
    if(!ConstTripCount) return iterations <= DEFAULT_TRIP_COUNT;
    return true;
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