/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test a nonfolded if condition without else statement. The value x after the if condition should be non-constant.

#include <stdio.h>
void branchNotPruned(int a) {
    if(1 == a)
        printf("branchNotPruned\n");
}

int main(int argc, char ** argv) {
    int x = 0;
    int total = 0;
    if(argc == 2) {
        x = 1;
        total = x + argc%2;
    }
    branchNotPruned(x);
    return total;
}
