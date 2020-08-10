/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
struct temp {
  int **a;
};

void branchNotPruned(int test) {
  if (test == 10)
    printf("branchNotPruned");
}

void branchPruned(int test) {
  if(test == 10)
    printf("branchNotPruned");
}
int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int) * 10); 
  int i = 0;
  int *d = b + 5;
  struct temp t;
  for(i = 0; i < 10; i++)
    b[i] = 10;

  *a = b[0];
  while(i < argc) {
    *d = 1;
    d++;
  }

  branchNotPruned(*b);
  branchPruned(*a);
}
