/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This Test is expected to specialized the func function such that the branch is pruned out */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

char buffer[100];
void branchPruned() {
  int index = strcspn(buffer, "=");
  char * value = buffer + index;
  *value++ = '\0';
  if(strcmp(value, "friend") == 0) {
    printf("name = %s\n", buffer);
    printf("value = %s\n", value);    
    printf("friend\n"); 
  }
}

int main() {
  memcpy(buffer, "my=friend", 100);
  branchPruned();
  return 0;
}
