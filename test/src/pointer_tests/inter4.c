/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

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

int main(int argc, char ** argv) {
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
   printf("%i", t);
}
