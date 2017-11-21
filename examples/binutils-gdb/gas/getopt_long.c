
int optind;
char * optarg = NULL;
int get_next_opt(int argc, char ** argv) {
  for(int i = optind; i < argc; i++) {
    if(argv[i][0] == '-')
      return i;
  }
  return -1;
}

void set_optarg(char ** argv) {
  optind++;
  int len = strlen(argv[optind]);
  optarg = malloc(len * sizeof(char));
  memcpy(optarg, argv[optind], len);
}

int handle_long(char * arg, char ** argv, struct option *longopts, int * longind) {
  for(int i = 0; i < sizeof(longopts); i++) {
    if(!strcmp(longopts[i].name, argv[optind])) {
      *longind = i;
      if(longopts[i].has_arg == required_argument)
        set_optarg(argv);
      else if(longopts[i].has_arg == optional_argument) {
        if(argv[optind + 1][0] != '-')
        set_optarg(argv);
      }
      return longopts[i].val;
    }
  }

  return -1;
}

int my_getopt_long_only(int argc, char ** argv, char * shortopts, struct option *longopts, int * longind) {
  optarg = NULL;
  int next = get_next_opt(argc, argv);
  if(next == -1)
    return next;
  optind = next;
  char * arg = &argv[optind][1];
  if(arg[0] == '-')    
    arg = &arg[1];
  int val = handle_long(&arg[1], argv, longopts, longind);
  if(val != -1)
    return val;
  // return handle_short(shortopts);
}