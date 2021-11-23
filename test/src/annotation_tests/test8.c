/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

//Annotation test. Check if pointers being traced across function calls
 


void test(char * a,int **pointer) {
    if(strcmp(a, "test"))
        *pointer = malloc(sizeof(int));
}

int main(int argc, char ** argv) {
    int *temp TRACK;
    char * a TRACK;
    (unsigned) &temp;
    a = argv[0];
    test(a,&temp);
    return 0;
}
