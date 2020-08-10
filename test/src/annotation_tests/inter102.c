/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
struct temp {
  int *a;
};

__attribute__((annotate("specializeArg")))
void branchNotPruned(int test) {
  if (test == 20)
    printf("branchPruned");
}

void external(int);
__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int)); 
  *a = 10;
  *b = 20;
  struct temp t;
  if(argc == 10) {
    t.a = a;
    external(1);
  } else {
    t.a = b;
    external(2);
  }

  branchNotPruned(*b);
}
