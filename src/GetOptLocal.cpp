// Copyright (c) 2020 SRI International All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "VecUtils.h"
#include "GetOptLocal.h"
#include "llvm/Support/raw_ostream.h"
#include <cstring>

// This file contains getopt functions which actually imitates functionality of the getopt function in getopt.h.

int contains(char* str, char c){
  if(!str)
    return -1;

  unsigned len = strlen(str);

  for(unsigned i=0;i<len;i++){
    if(str[i] == c){
      return i;
    }
  }

  return -1;
}

string err_local;
int getopt_local(int argc, char ** argv, char * opts) {
  if(optind >= argc) return -1;
  int i, opt = -1;
  for(i = optind; i < argc; i++) {
    if(strlen(argv[i]) > 2) continue;
    if(argv[i][0] != '-') continue;
    opt = argv[i][1];
    break;
  }
  if(opt == -1)
    return -1;
  if(optind >= argc) return -1;
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
  if(optind >= argc) return -1;
  int i;
  int opt = -1;
  for(i = optind; i < argc; i++) {
    if(argv[i][0] != '-') continue;
    opt = argv[i][1];
    break;
  }
  if(opt == -1)
    return -1;

  if(optind >= argc) return -1;
  optind = i;
  if(argv[i][1] != '-') return getopt_local(argc, argv, opts); // -c instead of --c
  bool found = false;
  int hasEqual = contains(&argv[optind][2],'=');

  for(i = 0; long_opts[i].name && !found ; i++) {
    if(hasEqual != -1 && strlen(long_opts[i].name) >= hasEqual){
      found = strncmp(long_opts[i].name,&argv[optind][2],hasEqual) == 0;
    } else {
      found = strcmp(long_opts[i].name, &argv[optind][2]) == 0;
    }
    if(found)
      break;
  }
  if(!long_opts[i].name) { 
    err_local = "option not found in long_opts\n";
    optind++;
    return '?';
  }  
  if(long_opts[i].has_arg) {

    if(hasEqual != -1 && found){
      optarg = &argv[optind][hasEqual+2+1];//2 for -- and 1 for = 

    } else if(optind < argc - 1 && argv[optind + 1][0] != '-') {
      optarg = argv[optind + 1];

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
