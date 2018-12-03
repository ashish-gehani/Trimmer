#include "VecUtils.h"
#include "GetOptLocal.h"

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
  if(optind == argc) return -1;
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
