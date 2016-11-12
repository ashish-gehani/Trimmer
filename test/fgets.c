
#include <stdio.h>
#include <string.h>

int strcmp2(const char* s1, const char* s2)
{  
  int length2 = strlen(s2);
  for(int i = 0; i < length2; i++){
    if(*s1 && (*s1==*s2)){
      s1++,s2++;
    }
    else
      break;
  }
  return *(const unsigned char*)s1-*(const unsigned char*)s2;
}


int main()
{
  FILE *fp;
  char str[60];
  /* opening file for reading */
  fp = fopen("configFile" , "r");
  
  while(fgets(str, 60, fp)) {
    /* writing content to stdout */
    if(strcmp2(str, "port=80\n") == 0)
       printf("port is 80 \n");  
    puts(str);
  }

  fclose(fp);   
  return(0);
}
