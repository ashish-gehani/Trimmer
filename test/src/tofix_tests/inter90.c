/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdint.h>
#include <stdio.h>

/**
 * Since we are skipping loads on 64bit (pointer size)
 * ints, this test fails
 */
void branchPruned(uint64_t t) {
    if(t == 10)
        printf("branchPruned");
}
int main() {
    uint64_t t= 10;
    &t && &t;
    branchPruned(t);
    return 0;
}
