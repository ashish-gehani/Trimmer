using namespace llvm;
using namespace std;

class Memory {
public:
	Memory(Module * M) {
		module = M;
		allocIndex = 1;
		totalSize = 1000;
		memory = new int8_t[totalSize];
		constant = new bool[totalSize];
		memset(memory, '\0', totalSize);
		setConstant(true, 0, totalSize);
	}
	~Memory() {
		delete memory;
		delete constant;
	}
	uint64_t allocate(uint64_t size) {
		uint64_t address = allocIndex;
		allocIndex += size;
		errs() << "allocated " << size << " bytes at location "  << address << "\n";
		errs() << allocIndex << " is the allocated index -------------\n";
		return address;
	}
	void store(uint64_t val, uint64_t size, uint64_t address) {
		for(uint64_t i = 0; i < size; i++)
			memory[address + i] = (int8_t) (val >> (8 * i)) & 0xff;
		setConstant(true, address, size);
	}
	uint64_t load(uint64_t size, uint64_t address) {
		return *(uint64_t *) &memory[address];
	}
	void copy(uint64_t to, uint64_t from, uint64_t size) {
		memcpy(&memory[to], &memory[from], size);
	}
	bool checkConstant(uint64_t address, uint64_t size) {
		for(uint64_t i = address; i < address + size; i++) {
			if(!constant[i])
				return false;
		}
		return true;
	}
	void setConstant(bool val, uint64_t address, uint64_t size) {
		fill(&constant[address], &constant[address] + size, val);
	}
	void * getActualAddr(uint64_t address) {
		return &memory[address];
	} 
	uint64_t getAllocIndex() {
		return allocIndex;
	}
	uint64_t getAllocatedSize() {
		return allocIndex - 1;
	}	
	uint64_t getTotalSize() {
		return totalSize;
	}
	Module * getModule() {
		return module;
	}
	int8_t * getMemImage() {
		return memory;
	}
	bool * getConstant() {
		return constant;
	}
private:
	uint64_t totalSize;
	uint64_t allocIndex;
	Module * module;
	int8_t * memory;
	bool * constant;
};

class Register {
public:
	Register(Type * allocatedType, uint64_t sv) {
		if(allocatedType)
		errs() << "new creating " << *allocatedType << "\n";
		ty = allocatedType;
		storedValue = sv;
		errs() << "stored\n";
	}
	Type * getType() {
		return ty;
	}
	uint64_t getValue() {
		return storedValue;
	}
private:
	uint64_t storedValue;
	Type * ty;
};

typedef map<Value *, Register *> ValToRegisterMap;