#include "VecUtils.h"
#include "GetOptLocal.h"
#include "llvm/Support/raw_ostream.h"
#include <cstring>


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
  errs()<<"optind: "<<optind<<", argc: "<<argc<<"\n";
  if(optind >= argc) return -1;
  int i;
  int opt = -1;
  for(i = optind; i < argc; i++) {
    errs()<<"argv["<<i<<"]: "<<argv[i]<<"\n";
    if(argv[i][0] != '-') continue;
    opt = argv[i][1];
    break;
  }
  if(opt == -1)
    return -1;
  errs()<<"i: "<<i<<", opt: "<<opt<<"\n";

  if(optind >= argc) return -1;
  optind = i;
  if(argv[i][1] != '-') return getopt_local(argc, argv, opts); // -c instead of --c
  bool found = false;
  int hasEqual = contains(&argv[optind][2],'=');

  for(i = 0; long_opts[i].name && !found ; i++) {
    if(hasEqual != -1 && strlen(long_opts[i].name) >= hasEqual){
      found = strncmp(long_opts[i].name,&argv[optind][2],hasEqual) == 0;
      errs()<<"i: "<<i<<", comparing "<<long_opts[i].name<<" with "<<&argv[optind][2]<<", strncmp on n "<<hasEqual<<": "<< strncmp(long_opts[i].name, &argv[optind][2],hasEqual)<<"\n";
    } else {
      found = strcmp(long_opts[i].name, &argv[optind][2]) == 0;
      errs()<<"i: "<<i<<", comparing "<<long_opts[i].name<<" with "<<&argv[optind][2]<<", strcmp: "<< strcmp(long_opts[i].name, &argv[optind][2])<<"\n";
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
    //errs()<<long_opts[i].name<<" has args\n";
    if(hasEqual != -1 && found){
      optarg = &argv[optind][hasEqual+2+1];//2 for -- and 1 for = 
      errs()<<"optarg: "<<optarg<<"\n";
      optind++;
    } else if(optind < argc - 1 && argv[optind + 1][0] != '-') {
      optarg = argv[optind + 1];
      errs()<<"optarg: "<<optarg<<"\n";
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
  errs()<<"Returning: "<<long_opts[i].val<<"\n";
  return long_opts[i].val;
}
