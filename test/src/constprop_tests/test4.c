/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests constant propagation, strcmp and memcpy

#include<stdio.h>
#include<string.h>
#include<stdlib.h>


void branchPruned(char * buffer, char * buffer2){
  
  if(strcmp(buffer, buffer2) == 0)
    printf("Both strings are equal\n"); 
}

int main(){

  char buffer[100];
  memcpy(buffer, "value=key", 100);
  char buffer2[100];
  memcpy(buffer2, "value=key", 100);
  branchPruned(buffer, buffer2);

  return 0;
}
