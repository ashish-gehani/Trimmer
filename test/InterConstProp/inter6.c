/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>


extern void externalFunc(char * buffer);


// void branchPruned(char * buffer, char * buffer2){  
//   if(strcmp(buffer, buffer2) == 0)
//     printf("Func: Both strings are equal\n"); 
// }

void branchNotPruned(char * buffer, char * buffer2){  
  if(strcmp(buffer, buffer2) == 0)
    printf("Func2: Both strings are equal\n"); 
}
 

int main(){

  char buffer[100];
  memcpy(buffer, "value=key", 100);
  char buffer2[100];
  memcpy(buffer2, "value=key", 100);

  if(buffer[90] == '\n') {
    printf("random check for testing node merging \n");
  }

  // func called twice - shouldn't specialize
  branchNotPruned(buffer, buffer2);
  branchNotPruned(buffer, buffer2);

  // func2 called within loop - shouldn't specialize
  // for(int i = 0; i < 10; i++){
  //   branchNotPruned(buffer, buffer2);
  // }

  return 0;
}
