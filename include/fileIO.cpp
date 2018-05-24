using namespace llvm;
using namespace std;
#include <fcntl.h>
#include <unistd.h>
#include "InterConstProp.h"
#include "Utils.cpp"

/* TODO : in case of read, lseek e.t.c when there is an error stop tracking the fd */


bool ConstantFolding::handleFileIOCall(CallInst * ci) {
	string name = ci->getCalledFunction()->getName();
	if(name == "open") 		 handleFileIOOpen(ci);
	else if(name == "read")  handleFileIORead(ci);
	else if(name == "lseek") handleFileIOLSeek(ci);
	else return false;
	return true;
}

void ConstantFolding::handleFileIOOpen(CallInst * ci) {
	Value * nameptr = ci->getOperand(0);
	char * fname;
	Value * flagVal = ci->getOperand(1);
	uint64_t flag; 
	if(!getStr(nameptr, fname, 100)) {
		debug(Abubakar) << "handleFileIOOpen : fname not found in map\n";
		return;
	}
	if(!getSingleVal(flagVal, flag)) {
		debug(Abubakar) << "handleFileIOOpen : flag not constant\n";
		return;   
	}
	int fd = open(fname, flag);
	if(fd < 0) return;
	handleInt(ci, fd);
}
void ConstantFolding::handleFileIORead(CallInst * ci) {
	Value * fdVal = ci->getOperand(0);
	Value * bufPtr = ci->getOperand(1);
	Value * sizeVal = ci->getOperand(2);
	uint64_t fd, size;
	Register * reg = getRegister(bufPtr);  
	if(!reg) {
		debug(Abubakar) << "handleFileIORead : buffer Not found in Map\n";
		return;
	}
	if(!getSingleVal(fdVal, fd) || !getSingleVal(sizeVal, size)) {
		debug(Abubakar) << "handleFileIORead : fd and/or size not constant\n";
		setConstContigous(false, reg->getValue()); 
		return;   
	}
	char * buffer = (char *) getActualAddr(reg->getValue());
	int bytes_read = read(fd, buffer, size);
	if(bytes_read < 0) {
		debug(Abubakar) << "handleFileIORead : read returned error\n";
		setConstContigous(false, reg->getValue()); 
		return;   		
	}
	handleInt(ci, bytes_read);
}
void ConstantFolding::handleFileIOLSeek(CallInst * ci) {
	Value * fdVal = ci->getOperand(0);
	Value * offSetVal = ci->getOperand(1);
	Value * flagVal = ci->getOperand(2);
	uint64_t fd, offset, flag;
	if(!getSingleVal(fdVal, fd) || !getSingleVal(offSetVal, offset) || 
		!getSingleVal(flagVal, flag)) {
		debug(Abubakar) << "handleFileIOLSeek : one of fd, offset, flag not constant\n";
		return;   
	}	
	int ret = lseek(fd, offset, flag);
	if(ret < 0) return;
	handleInt(ci, ret);
}