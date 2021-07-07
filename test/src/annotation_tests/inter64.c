/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if conditionals dependent on argv work
 */

int main(int argc, char ** argv) {
    char *temp TRACK;
    int temp2 TRACK;
    (unsigned)&temp & (unsigned) &temp2;

    temp = argv[1];
    if(temp)
        temp2 = 1;
    return 0;
}
