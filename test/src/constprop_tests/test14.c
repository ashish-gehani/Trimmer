/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

// tests the code that contains a goto statement. Both branches in branchPruned will be pruned.

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  int x;
  int y;
  char * buffer;
};

void branchPruned(int x) {
  if(x == 3)
    printf("branchPruned 3\n");
  else if(x == 5)
    printf("branchPruned 5\n");
}

struct stType st = {0, 0, "helloworld0"};

char checkSt() {
  return (st.x == 0 && st.y == 0 && !strcmp(st.buffer, "helloworld0"));
}

int main(int argc, char ** argv) {
  int x = 0;
  if(!strcmp(argv[1], "0")) {
    printf("it is equal to zero\n");
    x = 3;
    if(!checkSt()) {
      printf("checkSt is false\n");
      goto cond;
    }
  } else {
    printf("it is equal to one\n");
    x = 5;    
    cond:
      branchPruned(x);
  }
  return 0;
}
