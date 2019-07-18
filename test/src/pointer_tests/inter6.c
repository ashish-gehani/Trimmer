#include <string.h>
char a[] = "asd";
char b[] = "afg";

void external(char *);
void external2(char *);
void branchNotPruned(char a) {
  if(a == 'a')
    printf("branchNotPruned");
}
int main(int argc) {
  char *temp;
  int i = 0;
  for(i = 0; i < argc; i++) {
    if(argc && strcmp(a, "asd")) {
      temp = a+1;
    } else {
      temp = b+2;
    }
  }
  
  *temp = 'd';
  branchNotPruned(a[0]);
  return 0;
}
