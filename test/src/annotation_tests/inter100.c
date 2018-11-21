#include <stdio.h>
struct temp {
  int a;
};

int testing;
__attribute__((annotate("specializeArg")))
void test1() {
    testing = 1;
}
void branchNotPruned(int test) {
  if (test == 10) 
    printf("branchPruned");
}

int external();
__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int a = 20;
  int b = 20; 
  struct temp t;
  t.a = 10; 
  while(a >= 10) {
    a -= external();
    if(a == 4)
        t.a++;
  } 

  branchNotPruned(t.a);
}
