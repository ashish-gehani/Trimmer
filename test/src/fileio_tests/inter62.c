
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int debug = 0;
int port = 0;

void branchPruned(int debug,int port) {
  if(port==60)
    printf("branchPruned\n");
}

static void  read_config(char* filename )    {

  FILE* fp;
  char line[10000];
  char* cp;
  char* cp2;
  char* name;
  char* value;

  fp = fopen( filename, "r" );
  if ( fp == (FILE*) 0 )
  {
    perror( filename );
    exit( 1 );
  }

  while ( fgets(line, sizeof(line), fp ) != (char*) 0 )  {
    cp = line; 
    cp2 = cp + strcspn( cp, " \t\012\015" );
    printf("cp2: %s\n",cp2);
    /* Insert EOS and advance next-word pointer. */
    //while ( *cp2 == ' ' || *cp2 == '\t' || *cp2 == '\012' || *cp2 == '\015'){
      // *cp2++ = '\0';
      //  printf("cp2 in loop: %c\n",*cp2);}
    /* Split into name and value. */
    name = cp;
    printf("name: %s\n",name);
    printf("namesize: %i\n",strlen(name));
    value = strchr( name, '=' );
    
    if ( value != (char*) 0 ){
      *value++ = '\0';
      printf("value: %s\n",value);
    printf("valuesize: %i\n",strlen(value));}

     /* Interpret. */
    if ( strcasecmp( name, "debug" ) == 0 )
    {
      debug = 1;
      printf("debug: %i\n",debug);
    }
    else if ( strcasecmp( name, "port" ) == 0 )
    {

      port = atoi( value );
     printf("port: %i\n",port);
    }
  }

  printf("port = %d, debug = %d \n", port, debug);
}


int main(){
  read_config("../data/configFile62.txt");
  branchPruned(debug,port);
  return 0;
}

