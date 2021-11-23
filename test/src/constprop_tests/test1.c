/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests constant propagation across function and strcmp. The branch in branchPruned function will be pruned. 

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  int x;
  int y;
  char * buffer;
};

void branchPruned(struct stType * st, char * str0, char * str1, char * str2, char * str3) {
  if(st[0].x == 0 && st[0].y == 0 && !strcmp(st[0].buffer, str0) &&
  st[1].x == 1 && st[1].y == 1 && !strcmp(st[1].buffer, str1) &&
  st[2].x == 2 && st[2].y == 2 && !strcmp(st[2].buffer, str2) &&
  st[3].x == 3 && st[3].y == 3 && !strcmp(st[3].buffer, str3))
    printf("branchPruned\n");
}

struct stType st[] = {{0, 0, "helloworld0"}, {1, 1, "helloworld1"}, {2, 2, "helloworld2"}, {3, 3, "helloworld3"}};

int main(){
  branchPruned(st, "helloworld0", "helloworld1", "helloworld2", "helloworld3");
  return 0;
}
