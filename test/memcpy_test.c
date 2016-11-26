
#include <stdio.h>
#include <string.h>

int main(){

  char buffer[50];
  char * dest = buffer;
  memcpy(dest, "port=60\0", 8);
  //dest += strcspn(dest, "=");
  if(strcmp(dest, "port=60\0") == 0)
    printf("value 1 %s \n", dest); 
  
  memcpy(dest, "port=70\0", 8);
  if(strcmp(dest, "port=70\0") == 0)
    printf("value 2 %s \n", dest); 
  
  memcpy(dest, "port=80\0", 8);
  if(strcmp(dest, "port=80\0") == 0)
    printf("value 3 %s \n", dest); 
  
  return 0;
}
