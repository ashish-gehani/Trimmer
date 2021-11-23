/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test whether a variable of basic type becomes non-constant when its address is taken in a nonfolded branch and its value is changed through that pointer


#include <stdio.h>
struct temp {
  int *a;
};

void branchNotPruned(int test) {
  if (test == 10)
    printf("branchNotPruned");
}
int external(int );
int main(int argc, char ** argv) {
  int a = 10;
  int b = 20; 
  struct temp t;
  if(argc == 10) {
    t.a = &a;
  }else {
    t.a = &b;
  }

  *t.a = 14;

  branchNotPruned(a);
}
