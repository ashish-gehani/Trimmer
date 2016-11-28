
#include<string.h>
#include<stdio.h>


__attribute__((always_inline)) size_t strlen2(const char* str){
  
  int count = 50;
  int n;
  for(n = 0 ; n < count; n++){
    if(!*str)  // reached null character
      break;
    else
      str++;
  }

  if(!*str)
    return n;
  else
    return n + strlen(str); 
}


__attribute__((always_inline)) int strncmp2(const char* s1, const char* s2, size_t n){
  for(int i = n; i > 0; i--)
    if(*s1++!=*s2++)
      return *(unsigned char*)(s1 - 1) - *(unsigned char*)(s2 - 1);
  return 0;
}


__attribute__((always_inline)) int strcmp2(const char* s1, const char* s2){  
  int length2 = strlen2(s2);
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
  int count = 50; // loop peel count
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


__attribute__((always_inline)) size_t strspn2(const char* cs, const char* ct) {
  size_t n;
  const char* p;
  int ctSize = strlen2(ct);
  int count = 50;
  for(n = 0; n < count; n++) {
    p = ct;
    for(int j = 0; j < ctSize; j++){
      if(*p == *cs)
        break;
      p++;  
    }

    if (!*p)
      break;
    cs++;
  }

  if(*p){
    return n + strspn(cs, ct);
  }
  else{
    return n;
  }
}


__attribute__((always_inline)) size_t strcspn2(const char* cs, const char* ct) {
  size_t n;
  const char* p;
  int ctSize = strlen2(ct);
  int count = 50;

  for(n = 0; n < count; n++) {
    p = ct;
    if(!*cs)  // if reached end of string
      break;

    for(int j = 0; j < ctSize; j++){
      if(*p == *cs)
        break;
      p++;  
    }

    // if any one character in the string was matched break
    if(*p)
      break;
    cs++;
  }

  if(!*cs)
    return n;

  // nothing from the reject set matched any character in the source string 
  if(!*p){
    return n + strcspn(cs, ct);
  }
  else{
    return n;
  }
}

