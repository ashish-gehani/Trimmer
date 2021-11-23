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
  int *x, * y;
};
struct stType{
  struct COORD * coord;
  char str[100];
  int arr[8];
};

void branchPruned(struct stType** obj){  

  if(*obj[0]->coord->x == 1 &&
    *obj[0]->coord->y == 2 &&
    obj[0]->arr[1] == 4 &&
    !strcmp(obj[0]->str, "helloWorld") &&
    obj[0]->str[4] == 'o' &&
    obj[0]->str[9] == 'd' &&   
    *obj[1]->coord->x == 6 &&
    *obj[1]->coord->y == 7 &&
    obj[1]->arr[1] == 9 &&
    !strcmp(obj[1]->str, "helloWorld") &&
    obj[1]->str[4] == 'o' &&
    obj[1]->str[9] == 'd' &&
    *obj[2]->coord->x == 11 &&
    *obj[2]->coord->y == 12 &&
    obj[2]->arr[1] == 14 &&
    !strcmp(obj[2]->str, "helloWorld") &&
    obj[2]->str[4] == 'o' &&
    obj[2]->str[9] == 'd' &&
    *obj[3]->coord->x == 16 &&
    *obj[3]->coord->y == 17 &&
    obj[3]->arr[1] == 19 &&
    !strcmp(obj[3]->str, "helloWorld") &&
    obj[3]->str[4] == 'o' &&
    obj[3]->str[9] == 'd' &&
    obj[4] == NULL &&
    obj[5] == NULL &&
    obj[6] == NULL &&
    obj[7] == NULL &&
    obj[8] == NULL &&
    obj[9] == NULL &&
    obj[10] == NULL &&
    obj[11] == NULL &&
    obj[12] == NULL &&
    obj[13] == NULL &&
    obj[14] == NULL &&
    obj[15] == NULL &&
    obj[16] == NULL &&
    obj[17] == NULL &&
    obj[18] == NULL &&
    obj[19] == NULL)
      printf("*** Branch Taken \n");      
}

void initialize(struct stType** obj) {
 
} 

int main() {
  struct stType** obj = malloc(20 * sizeof(struct stType*)); 
  obj[0] = malloc(sizeof(struct stType));
  obj[0]->coord = malloc(sizeof(struct COORD));
  obj[0]->coord->x = malloc(sizeof(int));
  obj[0]->coord->y = malloc(sizeof(int));
  obj[0]->coord->x[0] = 1;
  obj[0]->coord->y[0] = 2;
  obj[0]->arr[0] = 3;
  obj[0]->arr[1] = 4;
  obj[0]->arr[2] = 5;
  memcpy(obj[0]->str, "helloWorld\0", 11);
  obj[1] = malloc(sizeof(struct stType));  
  obj[1]->coord = malloc(sizeof(struct COORD));  
  obj[1]->coord->x = malloc(sizeof(int));
  obj[1]->coord->y = malloc(sizeof(int));
  obj[1]->coord->x[0] = 6;
  obj[1]->coord->y[0] = 7;
  obj[1]->arr[0] = 8;
  obj[1]->arr[1] = 9;
  obj[1]->arr[2] = 10;
  memcpy(obj[1]->str, "helloWorld\0", 11);
  obj[2] = malloc(sizeof(struct stType)); 
  obj[2]->coord = malloc(sizeof(struct COORD)); 
  obj[2]->coord->x = malloc(sizeof(int));
  obj[2]->coord->y = malloc(sizeof(int));    
  obj[2]->coord->x[0] = 11;
  obj[2]->coord->y[0] = 12;
  obj[2]->arr[0] = 13;
  obj[2]->arr[1] = 14;
  obj[2]->arr[2] = 15;
  memcpy(obj[2]->str, "helloWorld\0", 11);
  obj[3] = malloc(sizeof(struct stType));  
  obj[3]->coord = malloc(sizeof(struct COORD)); 
  obj[3]->coord->x = malloc(sizeof(int));
  obj[3]->coord->y = malloc(sizeof(int));   
  obj[3]->coord->x[0] = 16;
  obj[3]->coord->y[0] = 17;
  obj[3]->arr[0] = 18;
  obj[3]->arr[1] = 19;
  obj[3]->arr[2] = 20;
  memcpy(obj[3]->str, "helloWorld\0", 11);   
  branchPruned(obj); 

  return 0;
}