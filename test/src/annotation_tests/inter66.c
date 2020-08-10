/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if nested branches work
 */
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;

char *expected[] = {"temp", "argv", "temp3"};

int main(int argc) {
    char *temp TRACK;
    int temp2 = 0;
    int temp3 TRACK;
    int temp4;
    (unsigned)&temp & (unsigned) &temp3 & (unsigned)&temp4;

    temp = argv[1];
    if(argc == 2) {
        if(strcmp(argv[0], temp)) {
            temp2 = 1;
        }
        temp4 = 0;
    }

    temp3 = temp2;
    return 0;
}
