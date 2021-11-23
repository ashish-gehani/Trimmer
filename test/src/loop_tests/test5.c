/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests complete unrolling of a getopt_long loop

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>

struct Config {
  int area, perimeter, length, breadth;
};

void branchPruned(struct Config *config) {
  if(config->area == 1 && config->perimeter == 1 && 
  config->length == 5 && config->breadth == 10)
    printf("branchPruned\n");
} 
struct Config config;
static struct option long_options[] = {
  {"area",      no_argument,       0,  'a' },
  {"perimeter", no_argument,       0,  'p' },
  {"length",    required_argument, 0,  'l' },
  {"breadth",   required_argument, 0,  'b' },
  {"defaultL", no_argument, &config.length, 10},
  {"defaultB", no_argument, &config.breadth, 10},
  {0,           0,                 0,  0   }
};


int main() { 
  int opt = 0;
  int argc = 6;
  char * argv[] = {"test", "--area", "-p", "--length", "5", "--defaultB"};
  memset((char *) &config, '\0', sizeof(struct Config));
  int long_index = 0;
  while ((opt = getopt_long(argc, argv,"apl:b:", 
  long_options, &long_index )) != -1) {
    switch (opt) {
      case 'a': 
        config.area = 1;
        break;
      case 'p': 
        config.perimeter = 1;
        break;
      case 'l': 
        config.length = atoi(optarg); 
        break;
      case 'b': 
        config.breadth = atoi(optarg);
        break;
    }
  }
  branchPruned(&config);
  printf("%d\n", optind);
}
