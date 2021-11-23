/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

void branchPruned(int x) {
    if(x==705082704)
      printf("branchPruned");
}

int main(){
  int count = 0;
    for(int i = 0; i <= 100000; i++)
        count += i;

  branchPruned(count);
  return count;
}
