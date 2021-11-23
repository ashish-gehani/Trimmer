/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
struct temp {
  int *a;
};

void branchNotPruned(int test) {
  if (test == 10)
    printf("branchPruned");
}

int main(int argc, char **argv) {
  int a = 10;
  int b = 20; 
  struct temp t;
  int *x;
  if(argc == 10) {
    x = &a;
    b++;
  } else {
    x = &b;
    b += 2;
  }

  *x = 14;

  branchNotPruned(a);
}
