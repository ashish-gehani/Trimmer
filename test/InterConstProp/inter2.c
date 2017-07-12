
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


void branchPruned(char * buffer){
  
  char * value = strchr(buffer, '=');
  *value++ = '\0';
  if(strcmp(value, "friend") == 0)
    printf("friend\n"); 
}
 

int main(){

  char buffer[100];
  memcpy(buffer, "my=friend", 100);
  
  branchPruned(buffer);

  return 0;
}
