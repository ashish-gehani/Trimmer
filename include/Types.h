

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
  bool calledInLoop, AddrTaken;
};

typedef map<Value *, SSAPointer *> ValSSAPointerMap;
typedef map<Value *, ScalarAlloca *> ValScalarAllocaMap;
typedef map<Value *, AggregateAlloca *> ValAggrAllocaMap;
typedef map<BasicBlock*, bool> BasicBlockBoolMap;
struct ContextInfo {
  ValSSAPointerMap SSAPointers;
  set<AggregateAlloca *> AggregateAllocas;
  ValScalarAllocaMap ScalarAllocas;
  vector<Value *> InstOrder;
};
typedef map<BasicBlock *, ContextInfo *> BasicBlockContInfoMap;
