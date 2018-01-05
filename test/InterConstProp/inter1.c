#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  int x;
  int y;
  char * buffer;
};

void branchPruned(struct stType * st) {
  if(st[0].x == 0 && st[0].y == 0 && !strcmp(st[0].buffer, "helloworld0") &&
  st[1].x == 1 && st[1].y == 1 && !strcmp(st[1].buffer, "helloworld1") &&
  st[2].x == 2 && st[2].y == 2 && !strcmp(st[2].buffer, "helloworld2") &&
  st[3].x == 3 && st[3].y == 3 && !strcmp(st[3].buffer, "helloworld3"))
    printf("branchPruned\n");
}

struct stType st[] = {{0, 0, "helloworld0"}, {1, 1, "helloworld1"}, {2, 2, "helloworld2"}, {3, 3, "helloworld3"}};

int main(){
  branchPruned(st);
  return 0;
}
