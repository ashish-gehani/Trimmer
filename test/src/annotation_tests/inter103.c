#include <stdio.h>
__attribute__((annotate("specializeArg")))
void branchNotPruned(int test) {
  if (test == 10)
    printf("branchPruned");
}

int external(int *v);
__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int)); 
  *a = 10;
  external(a); 

  branchNotPruned(*a);
}
