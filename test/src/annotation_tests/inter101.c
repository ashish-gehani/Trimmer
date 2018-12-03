#include <stdio.h>
struct temp {
  int **a;
};

__attribute__((annotate("specializeArg")))
void branchNotPruned(int test) {
  if (test == 13)
    printf("branchPruned");
}

__attribute__((annotate("specializeArg")))
int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int)); 
  int *d = malloc(sizeof(int));
  int **c;
  *a = 10;
  *b = 20;
  *d = 13;
  if(argc == 10) {
    c = &a;
    printf("asd");
  } else {
    c = &b;
    printf("zxc");
  }

  *c = d;
  (*a) = 14;

  branchNotPruned(*b);
}
