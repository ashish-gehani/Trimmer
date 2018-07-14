#include "ConstantFolding.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Instruction.h"	
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Transforms/Utils/SimplifyLibCalls.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include <unistd.h>
#include <sys/stat.h>
#include <map>
#include <set>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include <fcntl.h>


#include "getopt_local.h"
extern string err_local;

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
