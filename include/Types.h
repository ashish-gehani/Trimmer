

using namespace std;
using namespace llvm;

struct SplitString;
struct StringAlloca;
struct StringPointer;
struct CallOperand;
struct Indices;

enum BaseType {
  boolType, charType, intType, longType
};

enum NodeType {
  baseDataType,
  structType,
  structArrType,
  other // not handled yet... like pointers
};

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

struct MemAlloca {
  void* data; // even if it is not an array e.g. an int or a char, determined by size
  bool* initialized;
  BaseType btype;
  int size;
  bool constant;
};

struct MemPointer {
  MemPointer** contained; // if it is a basetype like char or char array then point to a MemAlloca
                     //  if it is a structtype then point to a list of MemPointers
  NodeType ntype;
  MemAlloca* alloca;
  int position;
  Type* ty;
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

typedef map<Value*, MemPointer*> ValMemPointerMap;
typedef map<Value*, MemAlloca*> ValMemAllocaMap;
typedef map<BasicBlock*, bool> BBboolMap;