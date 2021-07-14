/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <stdlib.h>
struct test {
  int a;
};

void branchNotPruned(int a) {
  if(a == 10 || a == 1 || a == 2)
    printf("branchNotPruned");
}

void external(int );
void external2(int );

int main(int argc, char ** argv) {
  struct test one;
  struct test two;
  int *pointer;

  one.a = 1;
  two.a = 2;
  if(argc == 2) {
    pointer = &one.a;
    external(1);
  } else {
    pointer = &two.a;
    external2(2);
  }

  *pointer = 10;
  branchNotPruned(one.a);
  return 0;
}
