/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdio.h>
#include <stdlib.h>
struct temp {
  int a;
};

int testing = 0;
int *temp;
void branchPruned(int);

void branchPruned(int test) {
  if (test == 10)
    printf("branchPruned");
}

int external();
void checkptCall();

int main(int argc, char **argv) {
  int a = 20;
  int b = 20; 
  struct temp t;
  struct temp *z = malloc(sizeof(struct temp));
  z->a = 10;
  t.a = 10; 
    
  checkptCall();


  branchPruned(z->a);
}
