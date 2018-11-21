#include <stdlib.h>
#include <stdio.h>

struct a {
    int b;
};

void branchPruned(int t) {
    if(t == 0)
        printf("branchPruned");
}
void external(int );
void external2(int );
int main(int argc) {
    int t;
    struct a test;
    struct a test1;
    test.b = 2;
    if(test.b == 2) {
        t = 0;
        external(test.b);
    } else {
        t = 1;
        external2(test1.b);
    }

   branchPruned(t);
   printf("%lx", t);
}
