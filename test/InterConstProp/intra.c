

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

int main(){

  char buffer[100];
  memcpy(buffer, "my=friend", 100);
  char * value = strchr(buffer, '=');
  *value++ = '\0';
  //char * value = &buffer[3];
  printf("name %s", buffer);
  printf("value %s", value);
  if(strcmp(value, "friend") == 0)
    printf("friend\n"); 
  return 0;
}
