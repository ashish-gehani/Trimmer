/* This test aims at testing whether the Pass skips the specialization of 'func' and 'func2', 
since they are not called once. 'func' is called twice from the 'main' function, while func2 is called in a loop */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>


extern void externalFunc(char * buffer);


void func(char * buffer, char * buffer2){  
  if(strcmp(buffer, buffer2) == 0)
    printf("Func: Both strings are equal\n"); 
}

void func2(char * buffer, char * buffer2){  
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
  func(buffer, buffer2);
  func(buffer, buffer2);

  // func2 called within loop - shouldn't specialize
  for(int i = 0; i < 10; i++){
    func2(buffer, buffer2);
  }

  return 0;
}
