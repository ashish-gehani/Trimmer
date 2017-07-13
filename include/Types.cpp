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
		return new char[size];
	}
	if(ty->isIntegerTy(64)) {
		btype = longType;
		return new char[size];
	}
	else
		return NULL;

}

MemObj* createMemObj(Type* ty) {
	MemObj* mobj = new MemObj;
	mobj->initialized = false; //check
	mobj->size = 1;
	mobj->isArr = false;
	if(ArrayType * arType = dyn_cast<ArrayType>(ty)) {
		mobj->isArr = true;
		mobj->size = arType->getNumElements();
		mobj->data = createData(ty->getContainedType(0), mobj->size, mobj->btype);	
	} else
		mobj->data = createData(ty, mobj->size, mobj->btype);		
	return mobj;
}

MemNode* createMemNode(Type* ty) {
	MemNode* mnode = new MemNode;
	mnode->position = 0;
	mnode->constant = true;
	mnode->ty = ty;
	if(StructType* st = dyn_cast<StructType>(ty)) {
		mnode->isStruct = true; 
		unsigned num = st->getNumElements();
		mnode->contained = new MemNode*[num];
		for(unsigned i = 0; i < num; i++)
			mnode->contained[i] = createMemNode(st->getElementType(i));
	} else {
		mnode->isStruct = false; 
		mnode->location = createMemObj(ty);
		errs() << mnode->location->size << " " << mnode->location->btype << "\n";
	}
	return mnode;
}