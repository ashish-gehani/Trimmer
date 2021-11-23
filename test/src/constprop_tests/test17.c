/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This Test is expected to specialized the func function such that the branch is pruned out */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct COORD {
  int x, y;
};
struct stType{
  struct COORD coord;
  char str[100];
  int arr[8];
};


void branchPruned(struct stType obj){  

  if(obj.coord.x == 4)
    printf("x matches\n");
  else if(obj.coord.y == 8)
    printf("y matches\n");
  else if(obj.arr[1] == 12)
    printf("arr matches\n");    
  else if(!strcmp(obj.str, "helloWorld"))
    printf("str matches\n");
}

void initialize(struct stType* obj) {
  obj->coord.x = 4;
  obj->coord.y = 8;
  obj->arr[0] = 12;
  obj->arr[1] = 12;
  obj->arr[2] = 12;
  memcpy(obj->str, "helloWorld\0", 11);
} 

int main(){

  struct stType obj;
  initialize(&obj); 
  branchPruned(obj);

  return 0;
}
