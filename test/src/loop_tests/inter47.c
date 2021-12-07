/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

__attribute__((annotate("specializeArg")))
void branchPruned(char * buffer) {
  if(!strcmp(buffer, "gh")) printf("branchPruned");
}
__attribute__((annotate("specializeArg")))
void increment(int * a) {
  *a = *a + 1;
}

__attribute__((annotate("specializeArg")))
void reset(int * a) {
  *a = 0;
}

void unroll_loop(int);
__attribute__((annotate("specializeArg")))
int main() {
  char * buffer1 = "gh";
  char bufffer2[3];
  bufffer2[2] = '\0';
  int cond, i, j;
  cond = i = j = 0;
  while(i < 26) {
    unroll_loop(1);
    bufffer2[0] = 97 + i;
    while(j < 26) {
      unroll_loop(2); 
      bufffer2[1] = 97 + j;
      if(!strcmp(buffer1, bufffer2)) {
        cond = 1;
        break;
      }
      increment(&j);
    }
    if(cond) break;
    increment(&i);
    reset(&j);
  }
  branchPruned(bufffer2);
  return 0;
}