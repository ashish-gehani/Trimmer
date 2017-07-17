#include "Types.h"

using namespace llvm;
using namespace std;

FuncInfo* initializeFuncInfo(Function* F) {
  FuncInfo* fi = new FuncInfo;
  fi->numCallInsts = 0;
  fi->calledInLoop = false;
  fi->AddrTaken = F->hasAddressTaken();
  return fi;
}

void* createData(Type* ty, int size, BaseType& btype) {
	if(ty->isIntegerTy(1)) {
		btype = boolType;
		return new bool[size];
	}
	if(ty->isIntegerTy(8)) {
		btype = charType;
		return new char[size];
 	}
	if(ty->isIntegerTy(32)) {
		btype = intType;
		return new int[size];
	}
	if(ty->isIntegerTy(64)) {
		btype = longType;
		return new long[size];
	}
	else
		return NULL;

}

MemAlloca* createMemAlloca(Type* ty) {
	MemAlloca* mobj = new MemAlloca;
	mobj->constant = true;
	mobj->size = 1;
	if(ArrayType * arType = dyn_cast<ArrayType>(ty)) {
		mobj->size = arType->getNumElements();
		mobj->data = createData(ty->getContainedType(0), mobj->size, mobj->btype);	
	} else
		mobj->data = createData(ty, mobj->size, mobj->btype);		
	mobj->initialized = new bool[mobj->size];
	fill(mobj->initialized, mobj->initialized + mobj->size, false);
	return mobj;
}
MemPointer* createMemPointer(Type* ty) {
	MemPointer* mnode = new MemPointer;
	mnode->position = 0;
	mnode->ty = ty;
	if(StructType* st = dyn_cast<StructType>(ty)) {
		mnode->ntype = structType;
		unsigned num = st->getNumElements();
		mnode->contained = new MemPointer*[num];
		for(unsigned i = 0; i < num; i++)
			mnode->contained[i] = createMemPointer(st->getElementType(i));
		mnode->alloca = NULL;
	} else if(ty->getNumContainedTypes() && isa<StructType>(ty->getContainedType(0))) {
		if(ArrayType * arType = dyn_cast<ArrayType>(ty)) {
			mnode->ntype = structArrType;			
			unsigned num = arType->getNumElements();
			mnode->contained = new MemPointer*[num];
			for(unsigned i = 0; i < num; i++) {
				mnode->contained[i] = createMemPointer(ty->getContainedType(0));
			}				
		} else {
			mnode->ntype = other;
			errs() << "cant handle container type " << *ty << " atm\n";
		}
	} else {
		mnode->ntype = baseDataType;
		mnode->alloca = createMemAlloca(ty);
	}
	return mnode;
}

MemPointer* deepCopy(MemPointer* mnode) {
	MemPointer* rnode = new MemPointer;
	rnode->contained = mnode->contained;
	rnode->ntype = mnode->ntype;
	rnode->alloca = mnode->alloca;
	rnode->position = mnode->position;
	rnode->ty = mnode->ty;
	return rnode;
}