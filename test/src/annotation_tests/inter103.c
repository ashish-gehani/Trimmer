/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
__attribute__((annotate("specializeArg")))
void branchNotPruned(int test) {
  if (test == 10)
    printf("branchPruned");
}

int external(int *v);
__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int)); 
  *a = 10;
  external(a); 

  branchNotPruned(*a);
}
