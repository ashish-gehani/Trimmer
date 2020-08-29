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
  if(argc == 10) {
    t.a = &a;
    b++;
  } else {
    t.a = &b;
    b += 2;
  }

  *t.a = 14;

  branchNotPruned(a);
}