/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

// buffer will become non-constant as it is passed as an argument to an external function. Therefore, the branch will not be pruned in branchNotPruned function.

#include<stdio.h>
#include<string.h>
#include<stdlib.h>


extern void externalFunc(char * buffer);


void branchNotPruned(char * buffer, char * buffer2){  
  if(strcmp(buffer, buffer2) == 0)
    printf("Both strings are equal\n"); 
}
 
int main(){

  char buffer[100];
  memcpy(buffer, "value=key", 100);
  char buffer2[100];
  memcpy(buffer2, "value=key", 100);
  externalFunc(buffer);
  branchNotPruned(buffer, buffer2);

  return 0;
}
