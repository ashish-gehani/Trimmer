/* This Test is expected to specialized the func function such that the branch is pruned out */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType{
  int a;
  int b;
  char * str;
};


void func(struct stType * obj){  

  if(obj->a == 4 && obj->b == 8){
    printf("*** Branch Taken \n");
  }
}
 

int main(){

  struct stType obj; 
  obj.a = 4;
  obj.b = 8; 
  
  func(&obj);

  return 0;
}
