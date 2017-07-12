
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


void branchPruned(char * buffer){
  
  //char * value = strchr(buffer, '=');
  int index = strcspn(buffer, "=");
  char * value = buffer + index;
  *value++ = '\0';
  printf("name = %s\n", buffer);
  printf("value = %s\n", value);

  if(strcmp(value, "friend") == 0)
    printf("friend\n"); 
}

void branchNotPruned(char* buffer) {
  if(buffer[90] == '\n') {
    printf("random check for testing node merging \n");
  }
}

int main(){

  char buffer[100];
  memcpy(buffer, "my=friend", 100);

  branchNotPruned(buffer);
  branchPruned(buffer);
  return 0;
}
