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

/*
  This enumeration is used to keep track of the results of constant propagation 
  on instruction.
  e.g. i32 %a = load i32* %b
  if we replace %a with the loaded value the above instruction will be marked as
  folded
*/
enum ProcResult {
  UNDECIDED,
  NOTFOLDED,
  PARTOFLOOP,
  FOLDED
};
/*
  Each basic block is allocated a ContextInfo structure 
  which keeps track of its current Instruction iterator
  and contains its copy of shadow memory.  
  Except for the entry basic block of the program, the basic blocks
  may be allocated by two main operations
  1. imaging from parent - Both blocks share the same memory
  2. duplicating from parent - Both blocks share different memories and at the start of
  the execution of the child, its memory is a copy of parent's memory
  We prefer imaging if, as a result of constant propagation, there is no ambiguity about
  the parent's successor and no ambiguity about the child's successor
  e.g.

  BB0 int a = 5;
      switch(a) { 
        case '1':
        case '2':
        case '3':
        case '4':
  BB5   case '5':
      }
  BB6

  before inter-const-prop
  BB0 -> 5 successors
  BB5 -> 1 predecessor, 1 successor
  BB6 -> has 5 predecessors

  During inter-const-prop
  BB0 -> BB5 : image because BB0 successor folded
  BB5 -> BB6 : image because BB6 predecessors folded

  if there was ambiguity in the switch statement we would have duplicated on both these occasions
*/
struct ContextInfo {
  Memory * memory;
  BasicBlock::iterator inst;

  ContextInfo * imageOf;  
  bool deleted;

  ContextInfo() {
    deleted = false;
    imageOf = NULL;
  }
  ContextInfo(Module * M) {
    deleted = false;
    imageOf = NULL;
    memory = new Memory(M);    
  }
  ContextInfo * image() {
    ContextInfo * nci = new ContextInfo();
    nci->memory = memory;
    if(imageOf)
      nci->imageOf = imageOf;
    else
      nci->imageOf = this;
    return nci;        
  }
  ContextInfo * duplicate() {
    ContextInfo * nci = new ContextInfo();
    nci->memory = new Memory(*memory);
    return nci;
  }
};

/*
  structure keeping track of basic function info 
  as well as value returned and context at return.
*/
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
/*
  structure keeping track of basic BB info   
*/
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
/*
  structure used for loop unroll testing
*/
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
/*
  The structure used for tracking fileIO system calls
  open, read, lseek
*/
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