/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests complete unrolling of a triple-nested loop

#include <stdio.h>

void branchPruned(int a) {
    if(a == 104)
        printf("branchPruned\n");
}

int main() {
    int i, j, k, total = 0;
    for(i = 0; i < 26; i++) {
        for(j = 0 ; j < 2; j++)
            for(k = 0; k < 2; k++) {
                total += 1;
            }
    }

    branchPruned(total);
    return 0;
}
