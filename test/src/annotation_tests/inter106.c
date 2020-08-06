#include <stdio.h>
struct temp {
  int **a;
};

void branchNotPruned(struct temp *t, int *a, int *b) {
  if (**t->a == 10 || **t->a == 20 || *a == 10 || *b == 20)
    printf("branchPruned");
}

int main(int argc, char **argv) {
  int *a = malloc(sizeof(int));
  int *b = malloc(sizeof(int)); 
  *a = 10;
  *b = 20;
  struct temp t;
  if(argc == 10) {
    t.a = &a;
    b++;
  } else {
    t.a = &b;
    b += 2;
  }

  branchNotPruned(&t, a, b);
}
