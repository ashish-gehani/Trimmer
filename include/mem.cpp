#include "mem.h"

using namespace llvm;
using namespace std;

void MemAlloca::createData(Type* ty) {
	if(ty->isIntegerTy(1)) {
		Btype = boolType;
		data = new bool[size];
	}
	if(ty->isIntegerTy(8)) {
		Btype = charType;
		data = new char[size];
		memset(data, '\0', size);
 	}
	if(ty->isIntegerTy(32)) {
		Btype = intType;
		data = new int[size];
	}
	if(ty->isIntegerTy(64)) {
		Btype = longType;
		data = new long[size];
	}
}

Value* MemAlloca::CreateConstVal(int offset) {
  if(isa<ArrayType>(allocatedType)) // others not possible atm
    allocatedType = allocatedType->getContainedType(0);
  Value* constVal;
  if(Btype == boolType) {
    bool * loadData = (bool*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
  } else if(Btype == charType) {
    char * loadData = (char*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
    // errs() << "char loaded " << data[offset] << "\n";
  }  else if(Btype == intType) {
    int * loadData = (int*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
    // errs() << "int loaded " << data[offset] << "\n";
  }  else if(Btype == longType) {
    long * loadData = (long*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
  }
  return constVal;
}

void MemAlloca::StoreConstVal(int ConstVal, int offset) {
  if(Btype == boolType) {
    bool storeVal = (bool) ConstVal;
    bool * storeData = (bool*) data;
    storeData[offset] = storeVal;
  } else if(Btype == charType) {
    char storeVal = (char) ConstVal;
    char * storeData = (char*) data;
    storeData[offset] = storeVal;
  }  else if(Btype == intType) {
    int storeVal = (int) ConstVal;
    int * storeData = (int*) data;
    storeData[offset] = storeVal;
  }  else if(Btype == longType) {
    long storeVal = (long) ConstVal;
    long * storeData = (long*) data;
    storeData[offset] = storeVal;
  }
}

MemAlloca::MemAlloca(Type* ty) {
	constant = true;
	size = 1;
	if(ArrayType * arType = dyn_cast<ArrayType>(ty)) {
		size = arType->getNumElements();
		createData(ty->getContainedType(0));	
	} else
		createData(ty);		
	initialized = new bool[size];
	fill(initialized, initialized + size, false);
	allocatedType = ty;
}

MemPointer::MemPointer(Type* ty) {
	position = 0;
	allocatedType = ty;
	if(StructType* st = dyn_cast<StructType>(ty)) {
		Ntype = structType;
		unsigned num = st->getNumElements();
		for(unsigned i = 0; i < num; i++)
			contained.push_back(new MemPointer(st->getElementType(i)));
		alloca = NULL;
	} else if(ty->getNumContainedTypes() && isa<StructType>(ty->getContainedType(0))) {
		if(ArrayType * arType = dyn_cast<ArrayType>(ty)) {
			Ntype = structArrType;			
			unsigned num = arType->getNumElements();
			for(unsigned i = 0; i < num; i++)
				contained.push_back(new MemPointer(st->getElementType(i)));
		} else {
			Ntype = other;
			errs() << "cant handle container type " << *ty << " atm\n";
		}
	} else {
		Ntype = scalarType;
		alloca = new MemAlloca(ty);
	}
}


MemPointer::MemPointer(const MemPointer& mptr) {
	contained = mptr.contained;
	Ntype = mptr.Ntype;
	alloca = mptr.alloca;
	position = mptr.position;
	allocatedType = mptr.allocatedType;
}