/* This Test is expected to specialized the func function such that the branch is pruned out */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  int x;
  int y;
  char * buffer;
};

void branchPruned(struct stType * st) {
  char cond = 1;
  char str[11];
  memcpy(str, "helloworld", 10); 
  for(unsigned i = 0; i < 4; i++) {
    str[10] = i + '0'; // add the last character
    if(st[i].x != i || st[i].y != i || strcmp(str, st[i].buffer))
      cond = 0;
  }
  if(cond)
    printf("branchPruned\n");
}

struct stType st[] = {{0, 0, "helloworld0"}, {1, 1, "helloworld1"}, {2, 2, "helloworld2"}, {3, 3, "helloworld3"}};

int main() {
  branchPruned(st);
  return 0;
}
