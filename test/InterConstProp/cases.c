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
    obj[0]->str[9] == 'd')
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
  branchPruned(obj); 

  return 0;
}