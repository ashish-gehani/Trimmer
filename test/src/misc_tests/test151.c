/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdlib.h>
#include <stdio.h>
struct temp {
  int *a;
};

__attribute__((annotate("specializeArg")))
void branchPruned(int test) {
  if (test == 10)
    printf("branchPruned");
}

int external();
void checkptCall();

__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int a = 20;
  int b = 20; 
  struct temp t;
  struct temp *z = (struct temp *)malloc(sizeof(struct temp));
  t.a = (int*)malloc(sizeof(int)); 
  z->a = t.a;
  *t.a = 10;
    
  checkptCall();

  
  branchPruned(*z->a);
}
