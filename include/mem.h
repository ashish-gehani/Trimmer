using namespace std;
using namespace llvm;

enum BaseType {
  boolType,
  charType, 
  intType, 
  longType
};

enum NodeType {
  scalarType,
  structType,
  structArrType,
  other // not handled yet... like pointers
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
  void setInit(int index, bool val) {
    assert(index < size && "tried to access invalid index for initialized");
    initialized[index] = val;
  }
  bool getInit(int index) {
    assert(index < size && "tried to access invalid index for initialized");
    return initialized[index];    
  }
  void fillInit(int offset, int length, bool val) {
    assert(offset < size && offset + length < size && "trying to initialize invalid indices");
    bool* fillBuff = this->initialized + offset;
    fill(fillBuff, fillBuff + length, true);
  }
  void createData(Type* ty);
  Value* CreateConstVal(int offset);
  void StoreConstVal(int ConstVal, int offset);
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

  unsigned getNumContained() {
    return this->contained.size();
  }
  MemPointer* getContained(unsigned index) {
    assert(index < this->contained.size() && "tried to access invalid index");
    return this->contained[index];
  }
  int getPosition() { 
    return this->position;
  }
  void setPosition(int newpos) {
    this->position = newpos;
  }
  void incrementPosition(int inc) {
    this->position += inc;
  }
  Type* getType() {
    return this->allocatedType;
  }
  bool isNodeTypeOf(NodeType Ntype) {
    return this->Ntype == Ntype;
  }
  MemAlloca* getAlloca() {
    return alloca;
  }

private:
  MemAlloca* alloca;
  vector<MemPointer*> contained; 
  int position;
  Type* allocatedType;
  NodeType Ntype;
};