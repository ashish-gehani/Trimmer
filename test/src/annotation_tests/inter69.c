/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if pointers being traced across function
 * calls
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;


void test(int **pointer) {
    if(strcmp(argv[0], "test"))
        *pointer = malloc(sizeof(int));
}

int main(argc) {
    int *temp TRACK;
    (unsigned) &temp;
    test(&temp);
    return 0;
}
