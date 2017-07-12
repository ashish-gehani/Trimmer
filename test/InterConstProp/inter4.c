
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


void branchPruned(char * buffer, char * buffer2){
  
  if(strcmp(buffer, buffer2) == 0)
    printf("Both strings are equal\n"); 
}
 
void branchNotPruned(char* buffer) {
  if(buffer[90] == '\n') {
    printf("random check for testing node merging \n");
  }
}

int main(){

  char buffer[100];
  memcpy(buffer, "value=key", 100);
  char buffer2[100];
  memcpy(buffer2, "value=key", 100);
  branchNotPruned(buffer);
  branchPruned(buffer, buffer2);

  return 0;
}
