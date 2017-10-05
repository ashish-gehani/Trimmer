#include "mem.h"

using namespace llvm;
using namespace std;

void ScalarAlloca::createData(Type* ty) {
	if(ty->isIntegerTy(1)) {
		Btype = boolType;
		data = new bool[size];
		fill((bool *) data, (bool *) data + size, false);		
	}
	if(ty->isIntegerTy(8)) {
		Btype = charType;
		data = new char[size + 1];
		fill((char *) data, (char *) data + size + 1, false);				
	}
	if(ty->isIntegerTy(16)) {
		Btype = shortType;
		data = new short[size];
		fill((short *) data, (short *) data + size, false);				
	}
	if(ty->isIntegerTy(32)) {
		Btype = intType;
		data = new int[size];
		fill((int *) data, (int *) data + size, false);		
	}
	if(ty->isIntegerTy(64)) {
		Btype = longType;
		data = new long[size];
		fill((long *) data, (long *) data + size, false);		
	}
	if(ty->isFloatTy()) {
		Btype = floatType;
		data = new float[size];
		fill((float *) data, (float *) data + size, false);				
	}
	if(ty->isDoubleTy()) {
		Btype = doubleType;
		data = new double[size];
		fill((double *) data, (double *) data + size, false);				
	}
}

void ScalarAlloca::copyData(void * cdata, bool * cinit, int csize) {
  size = csize;
  if(Btype == boolType) {
		data = new bool[size];
		initialized = new bool[size];
		bool * castData = (bool *) data;
		bool * copyData = (bool *) cdata;
		for(int i = 0; i < size; i++) {
			castData[i] = copyData[i];
			initialized[i] = cinit[i];
		}
  } else if(Btype == charType) {
		data = new char[size + 1];
		initialized = new bool[size];
		char * castData = (char *) data;
		char * copyData = (char *) cdata;
		for(int i = 0; i < size; i++) {
			castData[i] = copyData[i];
			initialized[i] = cinit[i];
		}
		castData[size] = '\0';
  } else if(Btype == shortType) {
		data = new short[size];
		initialized = new bool[size];
		short * castData = (short *) data;
		short * copyData = (short *) cdata;
		for(int i = 0; i < size; i++) {
			castData[i] = copyData[i];
			initialized[i] = cinit[i];
		}
  } else if(Btype == intType) {
		data = new int[size];
		initialized = new bool[size];
		int * castData = (int *) data;
		int * copyData = (int *) cdata;
		for(int i = 0; i < size; i++) {
			castData[i] = copyData[i];
			initialized[i] = cinit[i];
		}
  } else if(Btype == longType) {
		data = new long[size];
		initialized = new bool[size];
		long * castData = (long *) data;
		long * copyData = (long *) cdata;
		for(int i = 0; i < size; i++) {
			castData[i] = copyData[i];
			initialized[i] = cinit[i];
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
  } else if(Btype == shortType) {
    short * loadData = (short*) data;
    constVal = ConstantInt::get(ty, loadData[offset]);    
  }  else if(Btype == intType) {
    int * loadData = (int*) data;
    constVal = ConstantInt::get(ty, loadData[offset]);
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
  } else if(Btype == shortType) {
    short storeVal = (short) ConstVal;
    short * storeData = (short*) data;
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

void ScalarAlloca::deleteData() {
	if(Btype == boolType) {
    bool * loadData = (bool*) data;
    delete [] loadData;
  } else if(Btype == charType) {
    char * loadData = (char*) data;
    delete [] loadData;
  } else if(Btype == shortType) {
    short * loadData = (short*) data;
    delete [] loadData;    
  }  else if(Btype == intType) {
    int * loadData = (int*) data;
    delete [] loadData;
  }  else if(Btype == longType) {
    long * loadData = (long*) data;
    delete [] loadData;
  }
}

ScalarAlloca::~ScalarAlloca() {
	deleteData();
	if(Btype != doubleType && Btype != floatType)
  	delete [] initialized;
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
	} else if(Btype == shortType) {
		short * fData = (short *) data;
		short * sData = (short *) sa->data;
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

ScalarAlloca * ScalarAlloca::clone() {
	ScalarAlloca * sa = new ScalarAlloca(Btype, allocatedType);
	sa->copyData(data, initialized, size);
	return sa;
}

AggregateAlloca::AggregateAlloca(Type* ty) {
	allocatedType = ty;
	containedSize = 0;
	totalSize = 0;
	alloca = NULL;
	parent = NULL;
	constant = true;
	isBase = false;
	allocaID = AggrAllocaID;
	AggrAllocaID++;
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

AggregateAlloca::AggregateAlloca() {
  parent = NULL;
  alloca = NULL;
  containedSize = 0;
}

void AggregateAlloca::initialize(AggregateAlloca * aa, unsigned totalSize) {
  allocatedType = aa->getType();
  constant = aa->isConstant();
  allocaID = aa->getId();
  isBase = aa->base();
  initContained(totalSize);
  Ntype = aa->Ntype;  
}

AggregateAlloca * AggregateAlloca::clone() {
  AggregateAlloca * aa = new AggregateAlloca();
  aa->initialize(this, totalSize);
  if(alloca) {
    aa->setAlloca(alloca->clone());
    aa->getAlloca()->setParent(aa);
  }
  return aa;
}	

void AggregateAlloca::copy(AggregateAlloca * aa) {
  constant = aa->isConstant();
  contained = aa->getContained();
  if(aa->getAlloca()) {
    setAlloca(aa->getAlloca());
    aa->getAlloca()->setParent(this);
  }
}	

AggregateAlloca * AggregateAlloca::deepClone() {		
  AggregateAlloca * aa = new AggregateAlloca();
  aa->initialize(this, totalSize);
  for(unsigned i = 0; i < containedSize; i++) {
    aa->setOrInsert(i, getContained(i)->deepClone());
    aa->getContained(i)->setParent(aa, i);
  }
  if(alloca) {
    aa->setAlloca(alloca->clone());
    aa->getAlloca()->setParent(aa);
  }
  return aa;
}	

AggregateAlloca::~AggregateAlloca() {
	if(alloca)
		delete alloca;
}

bool AggregateAlloca::checkConsistencyWith(AggregateAlloca * aa) {
	ScalarAlloca * sa = aa->getAlloca(); 
	if(isConstant() != aa->isConstant() ||
	allocatedType != aa->allocatedType ||
	containedSize != aa->getNumContained() ||
	!aa->isNodeTypeOf(Ntype) ||
	(!alloca && sa) || (!sa && alloca)) {
		setConstant(false);
		return false;
	}
	if(alloca && !alloca->checkConsistencyWith(sa)) {
		setConstant(false);
		return false;		
	}
	return true;
}


void AggregateAlloca::deepCheck(AggregateAlloca * aa) {
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
		contained[i]->deepCheck(aa->getContained(i));
}
