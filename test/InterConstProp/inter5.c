
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


extern void externalFunc(char * buffer);


void branchNotPruned2(char * buffer, char * buffer2){
  
  if(strcmp(buffer, buffer2) == 0)
    printf("Both strings are equal\n"); 
}
 
void branchNotPruned1(char* buffer) {
  if(buffer[90] == '\n') {
    printf("random check for testing node merging \n");
  }
}

int main(){

  char buffer[100];
  memcpy(buffer, "value=key", 100);
  char buffer2[100];
  memcpy(buffer2, "value=key", 100);

  if(buffer[90] == '\n') {
    printf("random check for testing node merging \n");
  }
  
  branchNotPruned1(buffer);
  externalFuncbranch(buffer);
  branchNotPruned2(buffer, buffer2);

  return 0;
}
