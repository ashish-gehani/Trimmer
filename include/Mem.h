/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This file contains two main classes: Memory and Register. 

 Memory consists of
 
 * stack - byte array
 * heap  - byte array
 * stackConst - byte array to check whether stack at location i is constant
 * heapConst  - byte array to check whether heap at location i is constant
 * startToSizeMap - hashMap which keeps track of how much memory was contigously allocated at each location
 
 Register consists of
 
 * Type of value stored
 * Address location of the memory (index of stack or heap) where this value is stored
 
 Registers are used to track values with pointer types.
*/

#include "llvm/IR/Module.h"
#include "VecUtils.h"
#include "llvm/Support/raw_ostream.h"

#ifndef MEM_H_
#define MEM_H_

#define DEFAULTINITSIZE 20000
#define MAXSTACKSIZE 10000000

using namespace llvm;
using namespace std;



class Memory {
public:
	/*
		starting index of stack is kept at 1
	*/
	Memory(Module * M) {
		module = M;
		stackIndex = 1;
		stackTotalSize = DEFAULTINITSIZE;
		stack = new int8_t[stackTotalSize];
		stackConst = new bool[stackTotalSize];
		memset(stack, 0, stackTotalSize);
		memset(stackConst, true,stackTotalSize);

		heapIndex = 1;
		heapTotalSize = DEFAULTINITSIZE;
		heap = new int8_t[heapTotalSize];
		heapConst = new bool[heapTotalSize];
		memset(heap, 0, heapTotalSize);
		memset(heapConst, true, heapTotalSize);
        constMemSize = 0;
	}
	/*
		Copy Constructor
	*/
	Memory(Memory& from) {
		module = from.getModule();
		stackIndex = from.getStackIndex();
		stackTotalSize = from.getStackTotalSize();
		stack = new int8_t[stackTotalSize];
		memcpy(stack, from.getStack(), stackTotalSize);
		stackConst = new bool[stackTotalSize];
		memcpy(stackConst, from.getStackConst(), stackTotalSize);
		stackStartIndices = from.getStackStartIndices();
		stackStartToSizeMap = from.getStackStartToSizeMap();

		heapIndex = from.getHeapIndex();
		heapTotalSize = from.getHeapTotalSize();
		heap = new int8_t[heapTotalSize];
		memcpy(heap, from.getHeap(), heapTotalSize);
		heapConst = new bool[heapTotalSize];
		memcpy(heapConst, from.getHeapConst(), heapTotalSize);
		heapStartIndices = from.getHeapStartIndices();
		heapStartToSizeMap = from.getHeapStartToSizeMap();
	}
	~Memory() {
		delete [] stack;
		delete [] heap;
		delete [] stackConst;
		delete [] heapConst;
	}
	void copyfrom(Memory * from) {
		memcpy(stack, from->getStack(), stackIndex); 
		memcpy(stackConst, from->getStackConst(), stackIndex);

		assert(heapTotalSize <= from->getHeapTotalSize() && " heapSize cannot be greater");
		while(heapTotalSize < from->getHeapTotalSize())
			resize(heap, heapConst, heapTotalSize);
		assert(heapTotalSize == from->getHeapTotalSize() && "unexpected behaviour");
		heapIndex = from->getHeapIndex();
		memcpy(heap, from->getHeap(), heapTotalSize);
		memcpy(heapConst, from->getHeapConst(), heapTotalSize);
		heapStartIndices = from->getHeapStartIndices();
		heapStartToSizeMap = from->getHeapStartToSizeMap();
	}
	/*
		compare all location of memory A with memory B
		if stack location i is not equat then set stackConst[i] to false
		same for heap
	*/
	void compareWith(Memory * with) {
		int8_t * withStack = with->getStack();
		int8_t * withHeap = with->getHeap();
		bool * withStackConst = with->getStackConst();
		bool * withHeapConst = with->getHeapConst();
                uint64_t hIndex;

		for(unsigned i = 0; i < stackIndex; i++) {
			if(!withStackConst[i])
				stackConst[i] = false;
			if(stackConst[i]) {
				if(stack[i] != withStack[i])
					stackConst[i] = false;
			} 
 		}


                if(heapTotalSize >= with->getHeapTotalSize()){
                  if(heapIndex >= with->getHeapIndex())
                    hIndex = with->getHeapIndex();
                  else
                    hIndex = heapIndex;
                }

                else 
                  hIndex = heapTotalSize;
                  
		for(unsigned i = 0; i < hIndex; i++) {
	          if(!withHeapConst[i])
		    heapConst[i] = false;
		    if(heapConst[i]) {
		      if(heap[i] != withHeap[i]) {
		        heapConst[i] = false;
		      }
		    }
 		}

	}
	uint64_t allocateStack(uint64_t size) {
		uint64_t address = stackIndex;
		stackIndex += size;
		stackIndex++; // space of 1 between each allocation
		while(stackIndex >= stackTotalSize)
			resize(stack, stackConst, stackTotalSize);
		stackStartIndices.push_back(address);
		stackStartToSizeMap[address] = size;
		return address;
	}
	/*
		The addresses of heap seen outside this class are offset
		by the variable MAXSTACKSIZE
		so the heap address 15 will be shown as MAXSTACKSIZE + 15;
	*/
	uint64_t allocateHeap(uint64_t size) {
		uint64_t address = heapIndex;
		heapIndex += size;
		heapIndex++; // space of 1 between each allocation
        //errs() << "allocating" << "\n";
		while(heapIndex >= heapTotalSize)
			resize(heap, heapConst, heapTotalSize);
		heapStartIndices.push_back(address);
		heapStartToSizeMap[address] = size;
        //errs() << "returning" <<"\n";
		return address + MAXSTACKSIZE;
	}	
	void store(uint64_t val, uint64_t size, uint64_t address) {
		uint64_t origAddr = address;
		int8_t * memory = stackOrHeap(origAddr);
		for(uint64_t i = 0; i < size; i++)
			memory[origAddr + i] = (int8_t) (val >> (8 * i)) & 0xff;
		setConstant(true, address, size);
	}
	uint64_t load(uint64_t size, uint64_t address) {
		int8_t * memory = stackOrHeap(address);
		return *(uint64_t *) &memory[address];
	}
	bool checkConstant(uint64_t address, uint64_t size) {
		bool * constant = stackOrHeapConst(address);
		for(uint64_t i = address; i < address + size; i++) {
            //errs() << "address = " << i << " constantness = " << constant[i] << "\n";
			if(!constant[i])
				return false;
		}
		return true;
	}
	void setConstant(bool val, uint64_t address, uint64_t size) {
		bool * constant = stackOrHeapConst(address);
        if(val)
          constMemSize += size;
        else
          constMemSize -= size;
        //errs() << "filling with " << val << " from address " << address << " to " << address + size <<"\n";
		fill(&constant[address], &constant[address] + size, val);
	}
	void * getActualAddr(uint64_t address) {
		int8_t * memory = stackOrHeap(address);
		return &memory[address];
	} 	
	uint64_t getStartContigous(uint64_t address) {
		if(stackOrHeap(address) == stack)
			return getStackStartContigous(address);
		else 
			return getHeapStartContigous(address);
	}	
	uint64_t getSizeContigous(uint64_t address) {
		if(stackOrHeap(address) == stack)
			return getStackSizeContigous(address);
		else 
			return getHeapSizeContigous(address);
	}
	uint64_t getRemainingContigousSize(uint64_t address) {
		if(stackOrHeap(address) == stack)
			return getStackRemainingContigousSize(address);
		else 
			return getHeapRemainingContigousSize(address);	
	}	
	void setConstContigous(bool val, uint64_t address) {
		if(stackOrHeap(address) == stack)
			setStackConstContigous(val, address);
		else 
			setHeapConstContigous(val, address);
	}
	bool checkConstContigous(uint64_t address) {
		if(stackOrHeap(address) == stack)
			return checkStackConstContigous(address);
		else 
			return checkHeapConstContigous(address);
	}	
	int8_t * getStack() {
		return stack;
	}	
	int8_t * getHeap() {
		return heap;
	}	
	bool * getStackConst() {
		return stackConst;
	}
	bool * getHeapConst() {
		return heapConst;
	}
	uint64_t getStackIndex() {
		return stackIndex;
	}
	uint64_t getHeapIndex() {
		return heapIndex;
	}
	uint64_t getStackSize() {
		return stackIndex - 1;
	}	
	uint64_t getHeapSize() {
		return heapIndex - 1;
	}		
	uint64_t getStackTotalSize() {
		return stackTotalSize;
	}		
	uint64_t getHeapTotalSize() {
		return heapTotalSize;
	}							
	vector<uint64_t> getStackStartIndices() {
		return stackStartIndices;
	}	
	vector<uint64_t> getHeapStartIndices() {
		return heapStartIndices;
	}		
	map<unsigned, unsigned> getStackStartToSizeMap() {
		return stackStartToSizeMap;
	}
	map<unsigned, unsigned> getHeapStartToSizeMap() {
		return heapStartToSizeMap;
	}
	Module * getModule() {
		return module;
	}
    uint64_t getConstMemSize() {
        return constMemSize;
    }
private:
	int8_t * stackOrHeap(uint64_t& address) {
		if(address >= MAXSTACKSIZE) {
			address -= MAXSTACKSIZE;
			return heap;
		}
		return stack;
	}
	bool * stackOrHeapConst(uint64_t& address) {
		if(address >= MAXSTACKSIZE) {
			address -= MAXSTACKSIZE;
			return heapConst;
		}
		return stackConst;
	}
	uint64_t getStackStartContigous(uint64_t address) {
		return binarySearchIndices(stackStartIndices, 0, stackStartIndices.size() > 0 ? stackStartIndices.size() - 1 : 0, address);		
	}
	uint64_t getHeapStartContigous(uint64_t address) {
		return binarySearchIndices(heapStartIndices, 0, heapStartIndices.size() > 0 ? heapStartIndices.size() - 1 : 0, address);		
	}		
	uint64_t getStackSizeContigous(uint64_t address) {
		address = getStackStartContigous(address);
		return stackStartToSizeMap[address];
	}
	uint64_t getHeapSizeContigous(uint64_t address) {
		address = getHeapStartContigous(address);
		return heapStartToSizeMap[address];
	}	
	uint64_t getStackRemainingContigousSize(uint64_t address) {
		uint64_t start = getStackStartContigous(address);
		return start + stackStartToSizeMap[start] - address; 		
	}	
	uint64_t getHeapRemainingContigousSize(uint64_t address) {
		uint64_t start = getHeapStartContigous(address);
		return start + heapStartToSizeMap[start] - address; 		
	}	
	void setStackConstContigous(bool val, uint64_t address) {
		address = getStackStartContigous(address);
		setConstant(val, address, stackStartToSizeMap[address]);
	}
	void setHeapConstContigous(bool val, uint64_t address) {
		address = getHeapStartContigous(address);
		setConstant(val, address + MAXSTACKSIZE, heapStartToSizeMap[address]);
	}	
	bool checkStackConstContigous(uint64_t address) {
		address = getStackStartContigous(address);
		return checkConstant(address, stackStartToSizeMap[address]);
	}
	bool checkHeapConstContigous(uint64_t address) {
		address = getHeapStartContigous(address);
		return checkConstant(address + MAXSTACKSIZE, heapStartToSizeMap[address]);
	}			
	void resize(int8_t *& memory, bool *& constant, uint64_t& totalSize) {		 
        //errs() << "resized" << "\n";
		int8_t * newMem = new int8_t[totalSize * 2];
        //errs() << "resized1" << "\n";
		memcpy(newMem, memory, totalSize);
		memset(newMem + totalSize, 0, totalSize);
		int8_t * delMem = memory;
		memory = newMem;

       // errs() << "resized2" << "\n";
		delete [] delMem;
        //errs() << "resized3" << "\n";
		bool * newConst = new bool[totalSize * 2];
		memcpy(newConst, constant, totalSize);
		memset(newConst + totalSize, true, totalSize);
		bool * delConst = constant;
		constant = newConst;
		delete [] delConst;

		totalSize *= 2;
	}

	int8_t * stack, * heap;
	bool * stackConst, * heapConst;	
	uint64_t stackIndex, heapIndex;
	uint64_t stackTotalSize, heapTotalSize;
    uint64_t constMemSize;
	map<unsigned, unsigned> stackStartToSizeMap, heapStartToSizeMap;
	vector<uint64_t> stackStartIndices, heapStartIndices;
    vector<unsigned> impMemIndices;

	Module * module;
};

class Register {
public:
	Register(Type * allocatedType, uint64_t sv, bool trkd = false) {
		ty = allocatedType;
		storedValue = sv;
        ptsToCount = 1;
        tracked = trkd;
	}
	Register(Register& from) {
		ty = from.getType();	
		storedValue = from.getValue();
        ptsToCount = from.getPointsToCount();
        tracked = from.tracked;
	}
	Type * getType() {
		return ty;
	}
	uint64_t getValue() {
		return storedValue;
	}
    uint32_t getPointsToCount() {
      return ptsToCount;
    }
    inline bool getTracked() {
      return tracked;
    }

    bool tracked;
private:
	uint64_t storedValue;
	Type * ty;
    uint32_t ptsToCount;
};

typedef map<Value *, Register *> ValToRegisterMap;

#endif
