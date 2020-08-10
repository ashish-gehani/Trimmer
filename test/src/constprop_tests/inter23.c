/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/* This Test is expected to specialized the func function such that a branch is pruned out in one case and not pruned in other case as it depends on command-line argument*/

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct COORD {
  int *x, * y;
};
struct stType {
  struct COORD * coord;
  char str[100];
  int arr[8];
};
struct stType** obj;
void branchPruned() {  

  if(*obj[0]->coord->x == 1 &&
    *obj[0]->coord->y == 2 &&
    !strcmp(obj[0]->str, "helloWorld") &&
    obj[0]->str[4] == 'o' &&
    obj[0]->str[9] == 'd' &&   
    *obj[2]->coord->x == 11 &&
    *obj[2]->coord->y == 12 &&
    obj[2]->arr[1] == 14 &&
    !strcmp(obj[2]->str, "helloWorld") &&
    obj[2]->str[4] == 'o' &&
    obj[2]->str[9] == 'd')
      printf("*** Branch Taken \n");      
}
void branchNotPruned() {  
  if(obj[0]->arr[1] == 4 &&
  *obj[3]->coord->x == 16 &&
  *obj[3]->coord->y == 17 &&
  obj[3]->arr[1] == 19 &&
  !strcmp(obj[3]->str, "helloWorld") &&
  obj[3]->str[4] == 'o' &&
  obj[3]->str[9] == 'd')
    printf("*** Branch not Taken \n");          
}

int main(int argc, char ** argv) {
  obj = malloc(20 * sizeof(struct stType*)); 
  obj[0] = malloc(sizeof(struct stType));
  obj[0]->coord = malloc(sizeof(struct COORD));
  obj[0]->coord->x = malloc(sizeof(int));
  obj[0]->coord->y = malloc(sizeof(int));
  obj[3] = malloc(sizeof(struct stType));  
  obj[3]->coord = malloc(sizeof(struct COORD)); 
  obj[3]->coord->x = malloc(sizeof(int));
  obj[3]->coord->y = malloc(sizeof(int));
  obj[1] = malloc(sizeof(struct stType));  
  obj[1]->coord = malloc(sizeof(struct COORD));  
  obj[1]->coord->x = malloc(sizeof(int));
  obj[1]->coord->y = malloc(sizeof(int));      
  if(argc > 2) {
    if(argc > 5) {
      obj[0]->coord->x[0] = 1;
      obj[0]->coord->y[0] = 2;
    } else {
      obj[0]->coord->x[0] = 1;
      obj[0]->coord->y[0] = 2;      
    }
    obj[0]->arr[0] = 3;
    obj[0]->arr[1] = 4;
    obj[0]->arr[2] = 5; 
    obj[3]->coord->x[0] = 16;
    obj[3]->coord->y[0] = 17;
    obj[3]->arr[0] = 18;
    obj[3]->arr[1] = 19;
    obj[3]->arr[2] = 20;
    memcpy(obj[3]->str, "helloWorld\0", 11);      
  } else {
    obj[0]->coord->x[0] = 1;
    obj[0]->coord->y[0] = 2;    
    obj[1]->coord->x[0] = 6;
    obj[1]->coord->y[0] = 7;
    obj[1]->arr[0] = 8;
    obj[1]->arr[1] = 9;
    obj[1]->arr[2] = 10;
    memcpy(obj[1]->str, "helloWorld\0", 11);    
  }
  memcpy(obj[0]->str, "helloWorld\0", 11);
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
 
  branchPruned(); 
  branchNotPruned();
  return 0;
}
