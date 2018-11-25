/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct Config {
  char * name;
  int area;
  int parameter;
  int value;
};


void branchPruned(struct Config * config) {
  if(!strcmp(config->name, "hello") &&
  config->area == 0 &&
  config-> parameter == 0 &&
  config->value == 15)
    printf("branchPruned");
}

char * options[4] = {"name", "area", "parameter", "value"};

int parse(int * idx, char ** argv, struct Config * config) {
  if(argv[*idx][0] != '-') return 0;
  for(int i = 0; i < 4; i++) {
    if(!strcmp(options[i], &argv[*idx][1])) {
      *idx = *idx + 1;
      if(argv[*idx][0] == '-') return 0;
      switch(i) {
        case 0:
          config->name = malloc(strlen(argv[*idx]) + 1);
          memcpy(config->name, argv[*idx], strlen(argv[*idx]));
          config->name[strlen(argv[*idx])] = '\0';
          break;
        case 1: config->area = atoi(argv[*idx]); break;
        case 2: config->parameter = atoi(argv[*idx]); break;
        case 3: config->value = atoi(argv[*idx]); break;
      }
      *idx = *idx + 1;
      return 1;
    }
  }
  return 0;
}

int main() {
  printf("%li\n",sizeof(struct Config));
  struct Config * config = malloc(sizeof(struct Config));
  memset(config, '\0', sizeof(struct Config));
  char * argv[4] = {"-name", "hello", "-value", "15"};
  int result = 1;
  int idx = 0;
  while(idx < 4) {
    result = parse(&idx, argv, config);
    if(!result) break;
  }
  
  branchPruned(config);
  return 0;
}
