/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests string functions such as strchr and strcspn. The branches in branchPruned function will be pruned. 

#include<stdio.h>
#include<string.h>
#include<stdlib.h>


void branchPruned(char * buf){
  
  //char * value = strchr(buf, '=');
  char * test1 = strchr(buf, '=');
  if(!strcmp(test1, "=friend")) printf("branchPruned\n"); 
  int index = strcspn(buf, "=");
  char * test2 = buf + index;
  *test2++ = '\0';
  if(!strcmp(test2, "friend")) printf("branchPruned\n"); 
}

int main(){

  char buffer[100];
  memcpy(buffer, "my=friend", 100);

  branchPruned(buffer);
  return 0;
}
