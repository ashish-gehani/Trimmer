
#include <stdio.h>
#include <string.h>

char * strchr2(const char * source, char character);
int strcmp2(const char* s1, const char* s2);


int main()
{
  FILE *fp;
  char str[60];

  /* open file for reading */
  fp = fopen("configFile" , "r");
  
  while(fgets(str, 60, fp)) {
    /* writing content to stdout */
    char * str2 = strchr2(str, 'o');
    if(strcmp2(str2, "ort=80\n") == 0)
       printf("port is 80 \n");  
    puts(str);
  }

  fclose(fp);   
  return(0);
}


