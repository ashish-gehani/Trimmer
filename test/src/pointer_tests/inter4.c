#include <stdlib.h>
#include <stdio.h>

void branchNotPruned(int t) {
    if(t == 0)
        printf("branchPruned");
}
void external(int );
void external2(int );

int t = 1;
int q = 2;

int main(int argc) {
    int *pointer;
    if(argc == 2) {
        pointer = &t;
        external(t);
    } else {
        pointer = &q;
        external2(q);
    }

   *pointer = 10;
   branchNotPruned(t);
   printf("%lx", t);
}
