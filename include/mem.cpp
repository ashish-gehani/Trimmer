#include "mem.h"

using namespace llvm;
using namespace std;

unsigned getSizeOf(Type* ty) {
  if(ty->getNumContainedTypes()) {
    if(ArrayType* arType = dyn_cast<ArrayType>(ty)) {
      unsigned numel = arType->getNumElements();
      return numel * getSizeOf(ty->getContainedType(0));
    } else if(StructType* stType = dyn_cast<StructType>(ty)) {
      unsigned numel = stType->getNumElements();
      unsigned size = 0;
      for(unsigned i = 0; i < numel; i++)
        size += getSizeOf(stType->getContainedType(i));
      return size;        
    } else if(isa<PointerType>(ty))
      return 8;
  } else {
    if(ty->isIntegerTy(8))
      return 1;
    else if(ty->isIntegerTy(32))    
      return 4;
    else if(ty->isIntegerTy(64))
      return 8;
  }
  return -1;
}


void ScalarAlloca::createData(Type* ty) {
	if(ty->isIntegerTy(1)) {
		Btype = boolType;
		data = new bool[size];
	}
	if(ty->isIntegerTy(8)) {
		Btype = charType;
		data = new char[size + 1];
		memset(data, '\0', size + 1);
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

void ScalarAlloca::copyData(void * cdata, bool * cinitialized, int csize) {
  size = csize;
  if(Btype == boolType) {
	data = new bool[size];
	initialized = new bool[size];
	bool * castData = (bool *) data;
	bool * cCastData = (bool *) cdata;
	for(int i = 0; i < size; i++) {
		castData[i] = cCastData[i];
		initialized[i] = cinitialized[i];
	}
  } else if(Btype == charType) {
	data = new char[size + 1];
	initialized = new bool[size];
	char * castData = (char *) data;
	char * cCastData = (char *) cdata;
	for(int i = 0; i < size; i++) {
		castData[i] = cCastData[i];
		initialized[i] = cinitialized[i];
		// errs() << castData[i] << " copy data " << initialized[i] << "\n";		
	}
	castData[size] = '\0';
  }  else if(Btype == intType) {
	data = new int[size];
	initialized = new bool[size];
	int * castData = (int *) data;
	int * cCastData = (int *) cdata;
	for(int i = 0; i < size; i++) {
		castData[i] = cCastData[i];
		initialized[i] = cinitialized[i];
	}
  }  else if(Btype == longType) {
	data = new long[size];
	initialized = new bool[size];
	long * castData = (long *) data;
	long * cCastData = (long *) cdata;
	for(int i = 0; i < size; i++) {
		castData[i] = cCastData[i];
		initialized[i] = cinitialized[i];
	}
  }
}

Value* ScalarAlloca::createConstVal(int offset) {
  Type * ty = allocatedType;
  if(isa<ArrayType>(ty)) // others not possible atm
    ty = ty->getContainedType(0);
  Value* constVal;
  if(Btype == boolType) {
    bool * loadData = (bool*) data;
    constVal = ConstantInt::get(ty, loadData[offset]);
  } else if(Btype == charType) {
    char * loadData = (char*) data;
    constVal = ConstantInt::get(ty, loadData[offset]);
    // errs() << "char loaded " << loadData[offset] << "\n";
  }  else if(Btype == intType) {
    int * loadData = (int*) data;
    constVal = ConstantInt::get(ty, loadData[offset]);
    // errs() << "int loaded " << loadData[offset] << "\n";
  }  else if(Btype == longType) {
    long * loadData = (long*) data;
    constVal = ConstantInt::get(ty, loadData[offset]);
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
    // errs() << "int stored " << storeVal << "\n";    
    storeData[offset] = storeVal;
  }  else if(Btype == longType) {
    long storeVal = (long) ConstVal;
    long * storeData = (long*) data;
    storeData[offset] = storeVal;
  }
}

ScalarAlloca::~ScalarAlloca() {
  if(Btype == boolType) {
    bool * loadData = (bool*) data;
    delete [] loadData;
  } else if(Btype == charType) {
    char * loadData = (char*) data;
    delete [] loadData;
  }  else if(Btype == intType) {
    int * loadData = (int*) data;
    delete [] loadData;
  }  else if(Btype == longType) {
    long * loadData = (long*) data;
    delete [] loadData;
  }
  delete [] initialized;
}

ScalarAlloca::ScalarAlloca(Type* ty) {
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

ScalarAlloca::ScalarAlloca(BaseType bt, Type * ty) {
	allocatedType = ty;
	Btype = bt;
}

ScalarAlloca * ScalarAlloca::createClone() {
	ScalarAlloca * sa = new ScalarAlloca(Btype, allocatedType);
	sa->copyData(data, initialized, size);
	return sa;
}

bool ScalarAlloca::checkConsistencyWith(ScalarAlloca * sa) {
	if(allocatedType != sa->allocatedType ||
	size != sa->getSize() ||
	!sa->isBaseTypeOf(Btype))
		return false;
	vector<unsigned> modcheck = modified;
	vector<unsigned> secMod = sa->getModVect();
	for(unsigned i = 0; i < secMod.size(); i++)
		InsertUnique(modcheck, secMod[i]);
	if(Btype == boolType) {
		bool * fData = (bool *) data;
		bool * sData = (bool *) sa->data;
		for(unsigned i = 0; i < modcheck.size(); i++) {
			unsigned index = modcheck[i];
			if(initialized[index] != sa->getInit(index))
				return false;
			if(initialized[index] && fData[index] != sData[index])
				return false;
		}
	} else if(Btype == charType) {
		char * fData = (char *) data;
		char * sData = (char *) sa->data;
		for(unsigned i = 0; i < modcheck.size(); i++) {
			unsigned index = modcheck[i];
			if(initialized[index] != sa->getInit(index))
				return false;
			if(initialized[index] && fData[index] != sData[index])
				return false;
		}
	}  else if(Btype == intType) {
		int * fData = (int *) data;
		int * sData = (int *) sa->data;
		for(unsigned i = 0; i < modcheck.size(); i++) {
			unsigned index = modcheck[i];
			if(initialized[index] != sa->getInit(index))
				return false;
			if(initialized[index] && fData[index] != sData[index])
				return false;
		}
	}  else if(Btype == longType) {
		long * fData = (long *) data;
		long * sData = (long *) sa->data;
		for(unsigned i = 0; i < modcheck.size(); i++) {
			unsigned index = modcheck[i];
			if(initialized[index] != sa->getInit(index))
				return false;
			if(initialized[index] && fData[index] != sData[index])
				return false;
		}
	}
	return true;	
}

AggregateAlloca::AggregateAlloca(Type* ty) {
	allocatedType = ty;
	containedSize = 0;
	totalSize = 0;
	alloca = NULL;
	parent = NULL;
	constant = true;
	allocaID = AggrAllocaID;
	AggrAllocaID++;
	// errs() << "creating " << allocaID << "\n";
	if(StructType* st = dyn_cast<StructType>(ty)) {
		Ntype = structType;
		unsigned num = st->getNumElements();
		initContained(num);
		for(unsigned i = 0; i < num; i++) {
			insert(new AggregateAlloca(st->getElementType(i)));
			getContained(i)->setParent(this, i);
		}
	} else if(isa<PointerType>(ty))
		Ntype = ptrType;
	else if(isa<ArrayType>(ty) && ty->getContainedType(0)->getNumContainedTypes()) { 
		// Array of an aggregate : array of pointers, array of structs or array of arrays
		ArrayType * arType = dyn_cast<ArrayType>(ty);
		Ntype = aggrArrType;			
		unsigned num = arType->getNumElements();
		initContained(num);		
		Type* contTy = ty->getContainedType(0);
		for(unsigned i = 0; i < num; i++) {
			insert(new AggregateAlloca(contTy));
			getContained(i)->setParent(this, i);
		}
	} else {
		Ntype = scalarType;
		alloca = new ScalarAlloca(ty);
		alloca->setParent(this);
	}
}

AggregateAlloca::AggregateAlloca(Type * ty, unsigned totalSize, bool val, 
    NodeType nty, unsigned id) {
    parent = NULL;
    allocatedType = ty;
    initContained(totalSize);
    containedSize = 0;
    constant = val;
    Ntype = nty;
    allocaID = id;
    alloca = NULL;
}

AggregateAlloca * AggregateAlloca::createClone() {
    AggregateAlloca * aa = new AggregateAlloca(allocatedType, totalSize, 
    	constant, Ntype, allocaID);
    for(unsigned i = 0; i < containedSize; i++) {
      aa->setOrInsert(i, getContained(i)->createClone());
      aa->getContained(i)->setParent(aa, i);
    }
    if(alloca) {
      aa->setAlloca(alloca->createClone());
      aa->getAlloca()->setParent(aa);
    }
    return aa;
}	

AggregateAlloca::~AggregateAlloca() {
	if(alloca)
		delete alloca;
	for(unsigned i = 0; i < containedSize; i++)
		delete contained[i];
}

void AggregateAlloca::checkConsistencyWith(AggregateAlloca * aa) {
	ScalarAlloca * sa = aa->getAlloca(); 
	if(isConstant() != aa->isConstant() ||
	allocatedType != aa->allocatedType ||
	containedSize != aa->getNumContained() ||
	!aa->isNodeTypeOf(Ntype) ||
	(!alloca && sa) || (!sa && alloca)) {
		setConstant(false);
		return;
	}
	if(alloca && !alloca->checkConsistencyWith(sa)) {
		setConstant(false);
		return;		
	}

	for(unsigned i = 0; i < containedSize; i++)
		contained[i]->checkConsistencyWith(aa->getContained(i));
}
