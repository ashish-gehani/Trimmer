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

  if(obj.coord.x == 4 && obj.coord.y == 8 && obj.arr[1] == 12
          && !strcmp(obj.str, "helloWorld")
          && obj.str[4] == 'o' && obj.str[9] == 'd')
    printf("*** Branch Taken \n");

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
