/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
#include <annotate.h>
struct temp {
  int **a;
};

__attribute__((annotate("specializeArg")))
void branchNotPruned(int test) {
  if (test == 13)
    printf("branchPruned");
}

__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int)); 
  int *d = malloc(sizeof(int));
  int **c TRACK;
  *a = argv[0][0];
  *b = argv[0][1];
  *d = argv[0][2];

  if(argc == 10) {
    c = &a;
    printf("asd");
  } else {
    c = &b;
    printf("zxc");
  }

  *c = d;

  branchNotPruned(*b);
}
