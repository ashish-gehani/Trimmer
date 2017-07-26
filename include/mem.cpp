#include "mem.h"

using namespace llvm;
using namespace std;

void ScalarAlloca::createData(Type* ty) {
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

Value* ScalarAlloca::createConstVal(int offset) {
  if(isa<ArrayType>(allocatedType)) // others not possible atm
    allocatedType = allocatedType->getContainedType(0);
  Value* constVal;
  if(Btype == boolType) {
    bool * loadData = (bool*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
  } else if(Btype == charType) {
    char * loadData = (char*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
    // errs() << "char loaded " << loadData[offset] << "\n";
  }  else if(Btype == intType) {
    int * loadData = (int*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
    // errs() << "int loaded " << loadData[offset] << "\n";
  }  else if(Btype == longType) {
    long * loadData = (long*) data;
    constVal = ConstantInt::get(allocatedType, loadData[offset]);
  }
  return constVal;
}

void ScalarAlloca::storeConstVal(int ConstVal, int offset) {
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
ScalarAlloca::ScalarAlloca(Type* ty) {
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

AggregateAlloca::AggregateAlloca(Type* ty) {
	allocatedType = ty;
	containedSize = 0;
	totalSize = 0;
	alloca = NULL;
	if(StructType* st = dyn_cast<StructType>(ty)) {
		Ntype = structType;
		unsigned num = st->getNumElements();
		initContained(num);
		for(unsigned i = 0; i < num; i++)
			insert(new AggregateAlloca(st->getElementType(i)));
	} else if(isa<PointerType>(ty))
		Ntype = ptrType;
	else if(isa<ArrayType>(ty) && ty->getContainedType(0)->getNumContainedTypes()) { 
		// Array of an aggregate : array of pointers, array of structs or array of arrays
		ArrayType * arType = dyn_cast<ArrayType>(ty);
		Ntype = aggrArrType;			
		unsigned num = arType->getNumElements();
		initContained(num);		
		Type* contTy = ty->getContainedType(0);
		for(unsigned i = 0; i < num; i++)
			insert(new AggregateAlloca(contTy));
	} else {
		Ntype = scalarType;
		alloca = new ScalarAlloca(ty);
	}
}
