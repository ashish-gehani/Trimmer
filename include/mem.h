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
  scalarPtrType,
  structType,
  ptrType,
  aggrArrType
};

class AggregateAlloca;
class ScalarAlloca {
public:  
  void* data; // even if it is not an array e.g. an int or a char, determined by size
  ScalarAlloca(Type* ty);
  ScalarAlloca(BaseType bt, Type * ty);
  ~ScalarAlloca();
  ScalarAlloca * createClone();
  bool equalsTo(ScalarAlloca * sa);
  void setParent(AggregateAlloca * aa) {
    this->parent = aa;
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
    assert(offset < size && offset + length <= size && "trying to initialize invalid indices");
    bool* fillBuff = this->initialized + offset;
    fill(fillBuff, fillBuff + length, true);
  }
  Type* getType() {
    return this->allocatedType;
  }  
  AggregateAlloca * getParent() {
    return parent;
  }  
  void createData(Type* ty);
  void copyData(void * data, bool * initialized, int size);
  Value* createConstVal(int offset);
  void storeConstVal(int ConstVal, int offset);
  BaseType Btype;
private:
  bool * initialized;
  int size;
  Type * allocatedType;
  AggregateAlloca * parent;
};

class AggregateAlloca {
public:
  AggregateAlloca(Type* ty);
  AggregateAlloca(Type * ty, unsigned totalSize, bool constant, 
    NodeType nty);   
  ~AggregateAlloca(); 
  AggregateAlloca * createClone();
  bool equalsTo(AggregateAlloca * aa);  
  void setParent(AggregateAlloca * aa, unsigned offset) {
    this->parent = aa;
    this->OffSetInParent = offset;
  }
  unsigned getNumContained() {
    return this->containedSize;
  }
  bool isConstant() {
    bool above = true;
    if(this->parent)
      above = this->parent->isConstant();
    return this->constant && above;
  }
  void setConstant(bool val) {
    this->constant = val;
  }
  void setConstantAnc(bool val) {
    this->setConstant(val);
    if(this->parent)
      this->parent->setConstantAnc(val);
  }  
  AggregateAlloca* getContained(unsigned index) {
    assert(index < this->containedSize && "tried to access invalid index");
    return this->contained[index];
  }
  void setOrInsert(unsigned index, AggregateAlloca* aa) {
    // if insertIndex is less then contained.size() then we will set as the insertIndex is already present
    // if insertIndex == contained.size() then we will insert
    // if insertIndex > contained.size() then even if we insert the insertIndex will not be equal to
    // insertIndex
    assert(index <= this->containedSize && "tried to insert at an invalid index");
    if(index < this->containedSize)
      this->contained[index] = aa;
    else
      this->insert(aa);
    aa->setParent(this, index);
  }
  Type* getType() {
    return this->allocatedType;
  }
  bool isNodeTypeOf(NodeType Ntype) {
    return this->Ntype == Ntype;
  }
  ScalarAlloca* getAlloca() {
    return this->alloca;
  }
  bool isNullPointer() {
    assert(this->Ntype == ptrType && 
      "isNullPointer : pointer operation on non-pointer Node");
    return !this->containedSize;
  } 
  AggregateAlloca * getParent() {
    return parent;
  }
  void setAlloca(ScalarAlloca * sa) {
    this->alloca = sa;
  }
  unsigned getOffSetInParent() {
    return OffSetInParent;
  }
  NodeType Ntype;
private:
  void initContained(unsigned size) {
    this->contained = new AggregateAlloca*[size];
    this->totalSize = size;
  }
  void checkAndResize() {
    if(this->totalSize == 0) {
      this->contained = new AggregateAlloca*[100];
      this->totalSize = 100;
    }
    else if(this->containedSize == this->totalSize) {
      AggregateAlloca** newArr = new AggregateAlloca*[2 * totalSize];
      for(unsigned i = 0; i < this->totalSize; i++)
        newArr[i] = contained[i];
      totalSize *= 2;
      AggregateAlloca** oldArr = contained;
      contained = newArr;
      delete oldArr; 
    }     
  }
  void insert(AggregateAlloca* aa) {
    checkAndResize();
    this->contained[containedSize] = aa;
    this->containedSize++;    
  }
  ScalarAlloca* alloca;
  AggregateAlloca** contained;
  AggregateAlloca* parent; 
  unsigned containedSize;
  unsigned totalSize;
  Type* allocatedType;
  bool constant;
  unsigned OffSetInParent;
};

struct SSAPointer {
  AggregateAlloca* basePointer;
  int position;
  Type* allocatedType;
  SSAPointer(Type * ty) {
    this->basePointer = new AggregateAlloca(ty);
    this->position = 0;
    this->allocatedType = ty;
  }
  SSAPointer(SSAPointer * sptr) {
    this->basePointer = sptr->basePointer;
    this->position = sptr->position;
    this->allocatedType = sptr->allocatedType;
  }
  SSAPointer(AggregateAlloca * aa) {
    this->basePointer = aa;
    this->position = 0;
    this->allocatedType = aa->getType();
  }
  SSAPointer * createClone() {
    SSAPointer * sptr = new SSAPointer(this);
    sptr->basePointer = basePointer->createClone();
    return sptr;
  }
};