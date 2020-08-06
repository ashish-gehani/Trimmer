#include <stdio.h>

/**
 * Test added due to bug in BBOps cloning,
 * instead of duplicating read only BB memory.
 * This resulted in total begin evaluated as 0
 * even after the not folded branch in main
 */
void branchNotPruned(int a) {
    if(1 == a)
        printf("branchPruned\n");
}

int main(int argc) {
    int x = 0;
    int total = 0;
    if(argc == 2) {
        x = 1;
        total = x + argc%2;
    }
    branchNotPruned(x);
    return total;
}
