/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if memory in loops with known induction variables
 * dependent on argc/argv are tracked
 */



int main(int argc, char ** argv) {
    int temp TRACK;
    temp = argc;
    char * a TRACK;
    int temp3 TRACK;
    a = argv[0];
    while(strcmp(a, "as")) {
        temp3 = 5; 
    }
    return 0;
}
