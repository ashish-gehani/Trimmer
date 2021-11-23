/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

struct Config {
  char a_flag;
  char b_flag;
  char str_flag;
  char * str;
};

void branchPruned(struct Config config) {
  if(config.a_flag == 1 && config.b_flag == 1 && 
  config.str_flag == 1 && !strcmp(config.str, "hello"))
    printf("branchPruned\n");
} 

int main() {
  int argc = 5;
  char * argv[] = {"test", "-a", "-b", "-s", "hello"};
  char c;
  struct Config config;
  memset((char *) &config, '\0', sizeof(struct Config));
  while ((c = getopt(argc, argv, "abs:")) != -1) {
    switch(c) {
      case 'a':
        config.a_flag = 1;
        break;
      case 'b':
        config.b_flag = 1;
        break;
      case 's':
        config.str_flag = 1;
        config.str = malloc(sizeof(char) * strlen(optarg));
        memcpy(config.str, optarg, strlen(optarg));
        break;
    }
  }
  branchPruned(config);
  printf("%d\n", optind);
  return 0;
}