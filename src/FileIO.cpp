using namespace llvm;
using namespace std;
#include <fcntl.h>
#include <unistd.h>
#include "InterConstProp.h"
#include "Utils.cpp"

int ConstantFolding::initfdi(int fd) {
	uint64_t addr = allocateHeap(sizeof(FdInfo));
	FdInfo * fdi = (FdInfo *) getActualAddr(addr);
	fdi->fd = fd;
	fdi->offset = 0;
	fdi->tracked = true;
	srand(time(NULL));
	int sfd = rand() % 100000000 + 100000;
	fdInfoMap[sfd] = addr;
	return sfd;
}

bool ConstantFolding::getfdi(int sfd, int & fd) {
	uint64_t addr = fdInfoMap[sfd];
	if(!checkConstContigous(addr)) {
		debug(Abubakar) << "skipping non constant fd\n";
		return false;
	}
	FdInfo * fdi = (FdInfo *) getActualAddr(addr);
	if(!fdi->tracked) { 
		debug(Abubakar) << "skipping untracked fd\n";
		return false;
	}
	fd = fdi->fd;
	lseek(fd, fdi->offset, SEEK_SET);
	return true;
}

void ConstantFolding::setfdiUntracked(int sfd) {
	((FdInfo *) getActualAddr(fdInfoMap[sfd]))->tracked = false;	
}

void ConstantFolding::setfdiOffset(int sfd, int fd) {
	((FdInfo *) getActualAddr(fdInfoMap[sfd]))->offset = lseek(fd, 0, SEEK_CUR);
}

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
	fd = initfdi(fd);
	addSingleVal(ci, fd);
}

void ConstantFolding::handleFileIORead(CallInst * ci) {
	Value * fdVal = ci->getOperand(0);
	Value * bufPtr = ci->getOperand(1);
	Value * sizeVal = ci->getOperand(2);
	uint64_t sfd, size;
	int fd;
	bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
	Register * reg = getRegister(bufPtr);  
	if(!reg || !fdConst || !getSingleVal(sizeVal, size)) {
		debug(Abubakar) << "handleFileIORead : failed to specialize\n";
		if(fdConst) setfdiUntracked(sfd);
		if(reg) setConstContigous(false, reg->getValue()); 
		return;   
	}
	char * buffer = (char *) getActualAddr(reg->getValue());
	int bytes_read = read(fd, buffer, size);
	if(bytes_read < 0) {
		debug(Abubakar) << "handleFileIORead : read returned error\n";
		setfdiUntracked(sfd);
		setConstContigous(false, reg->getValue()); 
		return;   		
	}
	setConstMem(true, reg->getValue(), bytes_read);
	setfdiOffset(sfd, fd);
	addSingleVal(ci, bytes_read);
}
void ConstantFolding::handleFileIOLSeek(CallInst * ci) {
	Value * fdVal = ci->getOperand(0);
	Value * offSetVal = ci->getOperand(1);
	Value * flagVal = ci->getOperand(2);
	uint64_t sfd, offset, flag;
	int fd;
	bool fdConst = getSingleVal(fdVal, sfd) && getfdi(sfd, fd);
	if(!fdConst || !getSingleVal(offSetVal, offset) || 
		!getSingleVal(flagVal, flag)) {
		if(fdConst) setfdiUntracked(sfd);
		debug(Abubakar) << "handleFileIOLSeek : failed to specialize\n";
		return;   
	}	
	int ret = lseek(fd, offset, flag);
	if(ret < 0) { 
		setfdiUntracked(sfd);
		debug(Abubakar) << "handleFileIOLSeek : seek returned error\n";
		return;
	}
	setfdiOffset(sfd, fd);
	addSingleVal(ci, ret);
}