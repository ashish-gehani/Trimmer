
#include<string.h>

__attribute__((always_inline)) int strcmp2(const char* s1, const char* s2)
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


__attribute__((always_inline)) char * strchr2(const char * source, char character){  
  // Peeling the loop rather manually
  int count = 20; // loop peel count
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

