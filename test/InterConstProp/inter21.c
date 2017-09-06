#include<stdio.h>
#include<string.h>
#include<stdlib.h>

char buffer[100];
void branchPruned() {
  int index = strcspn(buffer, "=");
  char * value = buffer + index;
  *value++ = '\0';
  if(strcmp(value, "friend") == 0) {
    printf("name = %s\n", buffer);
    printf("value = %s\n", value);    
    printf("friend\n"); 
  }
}

int main() {
  memcpy(buffer, "my=friend", 100);
  branchPruned();
  return 0;
}