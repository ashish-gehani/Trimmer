#include <stdio.h>

void branchPruned(int a) {
    if(a == 8)
        printf("branchPruned\n");
}

void temp();
int main() {
    int i, j, k, total = 0;
    for(i = 0; i < 26; i++) {
        for(j = 0 ; j < 2; j++)
            for(k = 0; k < 2; k++) {
                total += 1;
            }
    }
    
    branchPruned(8);
    return 0;
}
