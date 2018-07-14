#include "ConstantFolding.h"

string err_local;

int getopt_local(int argc, char ** argv, char * opts) {
  if(optind == argc) return -1;
  int i, opt;
  for(i = optind; i < argc; i++) {
    if(strlen(argv[i]) > 2) continue;
    if(argv[i][0] != '-') continue;
    opt = argv[i][1];
    break;
  }
  if(optind == argc) return -1;
  optind = i;
  for(i = 0; opts[i] && opts[i] != opt; i++) {}
  if(!opts[i]) { 
    err_local = "option not found in opts\n";
    optind++;
    return '?';
  }
  if(i < ((int) strlen(opts) - 1) && opts[i + 1] == ':') {
    if(optind < argc - 1 && argv[optind + 1][0] != '-') {
      optarg = argv[optind + 1];
      optind++;
    } else {  
      err_local = "optarg not specified\n";
      optind++;
      return '?';
    }
  }
  optind++;
  return opts[i];
}

int getopt_long_local(int argc, char ** argv, char * opts, struct option * long_opts, int * long_index) {
  if(optind == argc) return -1;
  int i, opt;
  for(i = optind; i < argc; i++) {
    if(argv[i][0] != '-') continue;
    opt = argv[i][1];
    break;
  }
  if(optind == argc) return -1;
  optind = i;
  if(argv[i][1] != '-') return getopt_local(argc, argv, opts);
  for(i = 0; long_opts[i].name && strcmp(long_opts[i].name, &argv[optind][2]); i++) {}
  if(!long_opts[i].name) { 
    err_local = "option not found in long_opts\n";
    optind++;
    return '?';
  }  
  if(long_opts[i].has_arg) {
    if(optind < argc - 1 && argv[optind + 1][0] != '-') {
      optarg = argv[optind + 1];
      optind++;
    } else {  
      err_local = "optarg not specified\n";
      optind++;
      return '?';
    }
  }
  optind++;
  if(long_index) *long_index = i;
  if(long_opts[i].flag) {
    *long_opts[i].flag = long_opts[i].val;
    return 0;
  } 
  return long_opts[i].val;
}

bool ConstantFolding::handleLongArgs(CallInst * callInst, option * long_opts,
  int *& long_index) {
  Value * val = callInst->getOperand(3);
  Register * reg = getRegister(val);
  if(!reg) {
    debug(Abubakar) << "long_opts not found\n";
    return false;
  }
  uint64_t addr = reg->getValue();
  if(!checkConstContigous(addr)) {
    debug(Abubakar) << "long_opts not constant\n";
    return false;
  }
  unsigned i = 0;
  while(1) {
    uint64_t nameAddr = loadMem(addr, 8);
    if(!nameAddr)
      break;
    long_opts[i].name = (char *) getActualAddr(nameAddr);
    long_opts[i].has_arg = loadMem(addr + 8, 4);
    uint64_t flagAddr = loadMem(addr + 12, 8);
    long_opts[i].flag = !flagAddr ? 0 : (int *) getActualAddr(flagAddr);
    long_opts[i].val = loadMem(addr + 20, 4);
    if(!long_opts[i].name)
      break;
    i++;
    addr += 32;
  }
  Value * indexVal = callInst->getOperand(4);
  reg = getRegister(indexVal);
  if(!reg) {
    debug(Abubakar) << "long_index not found\n";
    return false;
  }
  if(!checkConstContigous(reg->getValue())) {
    debug(Abubakar) << "long_index not constant\n";
    return false;
  }
  long_index = (int *) getActualAddr(reg->getValue());  
  memset((char *) &long_opts[i], '\0', sizeof(option)); 
  return true;
}

bool ConstantFolding::handleGetOpt(CallInst * ci) {
  string name = ci->getCalledFunction()->getName().str();
  if(name.size() < 6 || name.substr(0, 6) != "getopt")
    return false;
  if(name == "getopt_long_only") {
    errs() << "case not handled " << name << "\n";
    return true;
  }
  uint64_t argc;
  Register * argvReg = getRegister(ci->getOperand(1));
  Register * optsReg = getRegister(ci->getOperand(2));
  Register * optindReg = getRegister(module->getNamedGlobal("optind"));
  if(!getSingleVal(ci->getOperand(0), argc) || !argvReg || 
  !optsReg || !optindReg || !checkConstContigous(argvReg->getValue()) ||
  !checkConstContigous(optindReg->getValue())) {
    debug(Abubakar) << "conditions not satisfied\n";
    return true;
  }

  uint64_t ptrSize = DL->getTypeAllocSize(argvReg->getType());
  uint64_t intSize = DL->getTypeAllocSize(ci->getType());

  uint64_t optindAddr = optindReg->getValue();
  optind = loadMem(optindAddr, intSize);
  char ** argv = (char **) malloc(sizeof(char *) * argc);
  uint64_t addr = argvReg->getValue();
  map<char *, uint64_t> realToVirt;
  for(unsigned i = 0, iter = addr; i < argc; i++, iter += ptrSize) {
    uint64_t strAddr = loadMem(iter, ptrSize);
    if(!getStr(strAddr, argv[i])) {
      debug(Abubakar) << "updating argv\n";
      return true;
    }
    realToVirt[argv[i]] = strAddr;
  }
  char * opts = (char *) getActualAddr(optsReg->getValue());
  int result;
  if(name == "getopt_long") { 
    option * long_opts = (option *) malloc(sizeof(option) * 100);
    int * long_index;
    if(!handleLongArgs(ci, long_opts, long_index))
      return true;
    result = getopt_long_local(argc, argv, opts, long_opts, long_index);
  } else 
    result = getopt_local(argc, argv, opts);

  IntegerType * intTy = IntegerType::get(module->getContext(), intSize * 8);
  ConstantInt * resInt = ConstantInt::get(intTy, result);

  debug(Abubakar) << "getopt returned " << (char) result << "\n";
  replaceIfNotFD(ci, resInt);

  if(optarg) {
    debug(Abubakar) << "optarg is " << optarg << "\n";
    Register * optargReg = getRegister(module->getNamedGlobal("optarg"));
    uint64_t optArgAddr = optargReg->getValue();
    uint64_t strAddr = loadMem(optArgAddr, ptrSize);
    if(!strAddr) {
      Type * ty = optargReg->getType()->getContainedType(0);
      uint64_t charSize = DL->getTypeAllocSize(ty);
      strAddr = allocateHeap(charSize * 100);
      storeToMem(strAddr, ptrSize, optArgAddr);
      debug(Abubakar) << "created new string at " << strAddr << "\n";
    }
    char * source = (char *) getActualAddr(strAddr);
    memcpy(source, optarg, strlen(optarg));
    source[strlen(optarg)] = '\0';
  }
  storeToMem(optind, intSize, optindAddr);
  for(unsigned i = 0, iter = addr; i < argc; i++, iter += ptrSize)
    storeToMem(realToVirt[argv[i]], ptrSize, iter);
  return true;
} 
