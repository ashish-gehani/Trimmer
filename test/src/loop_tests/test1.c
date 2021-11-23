/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests complete unrolling of a simple loop with constant trip count

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  int x;
  int y;
  char * buffer;
};

void branchPruned(struct stType * st) {
  char cond = 1;
  char str[11];
  memcpy(str, "helloworld", 10); 
  for(unsigned i = 0; i < 4; i++) {
    str[10] = i + '0'; // add the last character
    if(st[i].x != i || st[i].y != i || strcmp(str, st[i].buffer))
      cond = 0;
  }
  if(cond)
    printf("branchPruned\n");
}

struct stType st[] = {{0, 0, "helloworld0"}, {1, 1, "helloworld1"}, {2, 2, "helloworld2"}, {3, 3, "helloworld3"}};

int main() {
  branchPruned(st);
  return 0;
}
