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

int external(struct temp *t[1]);

int temp(unsigned long temp);
__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int a = 20;
  int b = 20; 
  struct temp *te[1];
  struct temp t;
  t.a = 10; 
  te[0] = &t;
  external(te); 

  branchNotPruned(t.b);
}
