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

void branchPruned(char * buffer, char * buffer2){  
  if(strcmp(buffer, buffer2) == 0)
    printf("Func2: Both strings are equal\n"); 
}

void initialize(char * buffer) {
  memcpy(buffer, "value=key", 100);  
} 

void unroll_loop(int i) {
  printf("unroll count is %d\n", i);
}

int main() {

  char buffer[100];
  char buffer2[100];
  initialize(buffer);

  for(int i = 0; i < 10; i++) {
    initialize(buffer2);
  }

  branchPruned(buffer, buffer2);
  return 0;
}
