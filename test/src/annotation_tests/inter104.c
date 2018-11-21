#include <stdio.h>
struct temp {
  int a;
  int *b;
};

__attribute__((annotate("specializeArg")))
void branchNotPruned(int test) {
  if (test == 20)
    printf("branchPruned");
}

int external();

int temp(unsigned long temp);
__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int a = 20;
  int b = 20; 
  int test = 0;
  struct temp *te[1];
  struct temp t;
  t.a = 10; 
  t.b = &b;
  te[0] = &t;
  while(a >= 10) {
    a -= external();
    if(a == 4)
        te[0]->a = 1;
    te[0]->b += 2;
  } 

  branchNotPruned(*t.b);
}
