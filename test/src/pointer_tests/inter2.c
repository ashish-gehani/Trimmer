#include <stdio.h>
struct temp {
  int *a;
};

void branchNotPruned(int test) {
  if (test == 10)
    printf("branchPruned");
}
int external(int );
int main(int argc) {
  int a = 10;
  int b = 20; 
  struct temp t;
  if(argc == 10) {
    t.a = &a;
  }else {
    t.a = &b;
  }

  *t.a = 14;

  branchNotPruned(a);
}
