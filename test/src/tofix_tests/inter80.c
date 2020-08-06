#include <stdio.h>
#include <string.h>

/*
 * Loop Test. Check if we can remove branches in loop
 * with one unroll
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;
struct temp {
    int a;
};

void branchPruned(struct temp *t ) {
    if(t->a == 10)
        printf("branchPruned");
}

int externa();
int main(int argc) {
    struct temp t;
    int i; 
    t.a = argv[0][0];
    for(i = 0; i < external(); i++) {
        if(t.a == 10) {
            printf("a = 10");
        } else {
            t.a++;
        }
    }

    branchPruned(&t);
    return 0;
}
