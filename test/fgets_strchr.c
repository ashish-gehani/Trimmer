
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


char * strchr2(const char * source, char character){  
  // Peeling the loop rather manually
  int maxCount = 100;
  char sourceChar;
  int i;
  for(i = 0; i < maxCount; i++){
    sourceChar = source[i];   
    if(sourceChar == '\0' || sourceChar == character)
      break;
    //source++;
  }
 
  source = &source[i];  // FIXIT: need to confirm if this doesn't break
  if(sourceChar == '\0')
    return NULL;
  if(sourceChar == character)
    return source;

  while(*source){
    if(*source == character)
      return source;
    source++;
  }

  return NULL; 
}


char * strchr3(const char * source, char character, int count){  
  // Peeling the loop rather manually
  // int maxCount = 100;
  char sourceChar;
  int i;
  for(i = 0; i < count; i++){
    sourceChar = source[i];   
    if(sourceChar == '\0' || sourceChar == character)
      break;
  }
 
  source = &source[i];  // FIXIT: need to confirm if this doesn't break
  if(sourceChar == '\0')
    return NULL;
  if(sourceChar == character)
    return source;

  return strchr(source, character);  // call original strchr
}



int main()
{
  FILE *fp;
  char str[60];

  //  char buff[] = "Newzealander santener";
  // char * strBuf = strchr2(buff, 's');
  // printf("buf check : %s \n", strBuf);

  /* opening file for reading */
  fp = fopen("configFile" , "r");
  
  while(fgets(str, 60, fp)) {
    /* writing content to stdout */
    char * str2 = strchr3(str, 'o', 20);
    if(strcmp2(str2, "ort=80\n") == 0)
       printf("port is 80 \n");  
    puts(str);
  }

  fclose(fp);   
  return(0);
}
