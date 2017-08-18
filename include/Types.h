

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

struct FuncInfo {
  unsigned numCallInsts;
  AggregateAlloca * returnVal;
  vector<Function *> calledFunctions;
  vector<GlobalVariable *> usedGlobals;
  bool calledInLoop, addrTaken, visited, usesGlobals;
};

typedef map<Value *, SSAPointer *> ValSSAPointerMap;
typedef map<Value *, ScalarAlloca *> ValScalarAllocaMap;
typedef map<Value *, AggregateAlloca *> ValAggrAllocaMap;
struct ContextInfo {
  ValSSAPointerMap SSAPointers;
  vector<AggregateAlloca *> AggregateAllocas;
  vector<Value *> InstOrder;
  map<unsigned, AggregateAlloca *> idmap;
  vector<unsigned> modifiedAllocas;
  vector<BasicBlock *> ancestors;
  bool deleted;
  bool copyOrMain;
  ContextInfo(bool val) {
    deleted = false;
    copyOrMain = val;
  }
  ContextInfo * createClone() {
    ContextInfo * nci = new ContextInfo(true);
    nci->SSAPointers = SSAPointers;
    nci->AggregateAllocas = AggregateAllocas;
    nci->InstOrder = InstOrder;
    nci->idmap = idmap;
    nci->modifiedAllocas = modifiedAllocas;  
    return nci;        
  }
};
typedef map<BasicBlock *, ContextInfo *> BasicBlockContInfoMap;
typedef pair<GlobalVariable *, unsigned> GlobalIdPair;