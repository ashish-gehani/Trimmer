
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(){

  char line[100];
  char * name;
  char * value;
  char * cp;

  FILE * fp = fopen( "configFile", "r" );
  while ( fgets( line, sizeof(line), fp ) != (char*) 0 )
    {
      cp = line;
      value = cp + strcspn( cp, "=" );
      *value++ = '\0';
      char * end = cp + strcspn( cp, "\n");
      *end = '\0';
      name = cp;
      printf("name %s\n", name);
      printf("value %s\n", value);
      if(strcmp(name, "port") == 0)
        printf("port configuration\n");
    }
  
  return 0;
}
