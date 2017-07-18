
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


void branchPruned(char * buf){
  
  //char * value = strchr(buf, '=');
  int index = strcspn(buf, "=");
  char * value = buf + index;
  *value++ = '\0';
  if(strcmp(value, "friend") == 0) {
    printf("name = %s\n", buf);
    printf("value = %s\n", value);    
    printf("friend\n"); 
  }
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
