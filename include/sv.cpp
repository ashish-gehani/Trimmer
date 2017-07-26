using namespace std;
using namespace llvm;
#include "debug.h"

enum BaseType {
  boolType,
  charType, 
  intType, 
  longType
};

enum NodeType {
  scalarType,
  structType,
  ptrType,
  aggrArrType
};

class MemAlloca {
public:  
  void* data; // even if it is not an array e.g. an int or a char, determined by size
  MemAlloca(Type* ty);
  bool isConstant() {
    return this->constant;
  }
  void setConstant(bool val) {
    this->constant = val;
  }
  bool isBaseTypeOf(BaseType Btype) {
    return this->Btype == Btype;
  }
  int getSize() {
    return this->size;
  }
  void setInit(int index, bool val) {
    assert(index < this->size && "tried to access invalid index for initialized");
    this->initialized[index] = val;
  }
  bool getInit(int index) {
    assert(index < this->size && "tried to access invalid index for initialized");
    return this->initialized[index];    
  }
  void fillInit(int offset, int length, bool val) {
    assert(offset < size && offset + length < size && "trying to initialize invalid indices");
    bool* fillBuff = this->initialized + offset;
    fill(fillBuff, fillBuff + length, true);
  }
  Type* getType() {
    return this->allocatedType;
  }  
  void createData(Type* ty);
  Value* createConstVal(int offset);
  void storeConstVal(int ConstVal, int offset);
private:
  bool* initialized;
  BaseType Btype;
  int size;
  bool constant;
  Type* allocatedType;
};

class MemPointer {
public:
  MemPointer(Type* ty);

  MemPointer(const MemPointer& mptr);

  void storeScalar(Value* storeOperand);

  Value* loadScalar();

  unsigned getNumContained() {
    return this->containedSize - this->position;
  }
  MemPointer* getContained(unsigned index) {
    unsigned getIndex = index + this->position;
    assert(getIndex < this->containedSize && "tried to access invalid getIndex");
    return this->contained[getIndex];
  }
  void setOrInsert(unsigned index, MemPointer* mptr) {
    // if insertIndex is less then contained.size() then we will set as the insertIndex is already present
    // if insertIndex == contained.size() then we will insert
    // if insertIndex > contained.size() then even if we insert the insertIndex will not be equal to
    // insertIndex
    unsigned insertIndex = index + this->position;
    assert(insertIndex <= this->containedSize && "tried to insert at an invalid index");    
    if(insertIndex < this->containedSize)
      this->contained[insertIndex] = mptr;
    else
      this->insert(mptr);
  }
  Type* getType() {
    return this->allocatedType;
  }
  bool isNodeTypeOf(NodeType Ntype) {
    return this->Ntype == Ntype;
  }
  MemAlloca* getAlloca() {
    return this->alloca;
  }
  bool isNullPointer() {
    assert(isa<PointerType>(allocatedType) && 
      "isNullPointer : pointer operation on non-pointer Node");
    return !this->containedSize;
  }
private:
  void initContained(unsigned size) {
    this->contained = new MemPointer*[size];
    this->totalSize = size;
  }
  void checkAndResize() {
    if(this->totalSize == 0) {
      this->contained = new MemPointer*[100];
      this->totalSize = 100;
    }
    else if(this->containedSize == this->totalSize) {
      MemPointer** newArr = new MemPointer*[2 * totalSize];
      for(unsigned i = 0; i < this->totalSize; i++)
        newArr[i] = contained[i];
      totalSize *= 2;
      MemPointer** oldArr = contained;
      contained = newArr;
      delete oldArr;
    }     
  }
  void insert(MemPointer* mptr) {
    checkAndResize();
    this->contained[containedSize] = mptr;
    this->containedSize++;    
  }
  MemAlloca* alloca;
  MemPointer** contained; 
  unsigned containedSize; 
  unsigned totalSize;
  Type* allocatedType;
  NodeType Ntype;
};

struct SSAPointer {
  unsigned position;
  AggregateAlloca aggrAlloca; 
  Type* allocatedType;  
};

