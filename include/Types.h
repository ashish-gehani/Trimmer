

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

struct MemObj {
  void* data; // even if it is not an array e.g. an int or a char, determined by size
  BaseType btype;
  int size;
  bool initialized, constant, isArr;
};

struct MemNode {
  MemNode** contained; // if it is a basetype like char or char array then point to a MemObj
                     //  if it is a structtype then point to a list of MemNodes
  MemObj* location;
  bool isStruct, constant;  // true means location is NULL else Children is Null 
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
