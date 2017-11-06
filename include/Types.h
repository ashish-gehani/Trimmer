

using namespace std;
using namespace llvm;

struct SplitString;
struct StringAlloca;
struct StringPointer;
struct CallOperand;
struct Indices;


struct Indices{
  int start;
  int end;
};

struct StringAlloca{
  char * data;
  int size;
  bool initialized;
  bool constant;
  bool split; // If string is split
  list<SplitString> splitStrings;
};

struct SplitString {
  Indices indices;
  StringAlloca* splitAlloca;
};

struct StringPointer{
  int position;
  StringAlloca* alloca; // pointer to the alloca for the string
};

struct CallOperand{
  Value * newOperand;
  int index; // index into the CallInst argument
};


struct SpecializedCall{
  CallInst * origCall;
  CallInst * specCall;
  bool used;
};

typedef map<Value *, SSAPointer *> ValSSAPointerMap;
typedef map<Value *, ScalarAlloca *> ValScalarAllocaMap;
typedef map<Value *, AggregateAlloca *> ValAggrAllocaMap;
struct ContextInfo {
  ValSSAPointerMap SSAPointers;
  vector<AggregateAlloca *> AggregateAllocas;
  vector<Value *> InstOrder;
  map<unsigned, AggregateAlloca *> idmap;
  vector<unsigned> * modifiedAllocas;
  vector<BasicBlock *> ancestors;
  bool useless;
  bool deleted;
  bool executed;
  ContextInfo * cloneOf;
  BasicBlock::iterator inst;
  ContextInfo(bool val) {
    deleted = false;
    executed = false;
    useless = val;
    cloneOf = NULL;
    modifiedAllocas = new vector<unsigned>;
  }
  ContextInfo * clone() {
    ContextInfo * nci = new ContextInfo(true);
    nci->SSAPointers = SSAPointers;
    nci->AggregateAllocas = AggregateAllocas;
    nci->InstOrder = InstOrder;
    nci->idmap = idmap;
    nci->modifiedAllocas = modifiedAllocas;  
    nci->ancestors = ancestors;
    if(cloneOf)
      nci->cloneOf = cloneOf;
    else
      nci->cloneOf = this;
    return nci;        
  }
};
typedef map<BasicBlock *, ContextInfo *> BasicBlockContInfoMap;
typedef pair<GlobalVariable *, unsigned> GlobalIdPair;
typedef pair<CallInst *, CallInst *> callInstPair;

struct FuncInfo {
  unsigned numCallInsts, numVisits;
  AggregateAlloca * returnVal;
  ContextInfo * ci;
  vector<Function *> calledFunctions;
  bool calledInLoop, contextMisMatch, usesGlobals, addrTaken;
};

struct BBInfo {
  bool writesToMemory, partOfLoop, isHeader;
  unsigned numPreds, URfrom;
  vector<BasicBlock *> loopLatchesWithEdge, SuccsV;
};

#define MAXRECURSION 20