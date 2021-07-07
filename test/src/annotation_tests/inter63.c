/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if memcpy, strcpy, strncpy work
 */


int main(int argc, char ** argv) {
    char temp[4] TRACK;     
    char temp1[4] TRACK;
    char temp2[4] TRACK;
    char temp3[4] TRACK;

    memcpy(temp, argv[0],4);
    strncpy(temp1, argv[0], 4);
    strcpy(temp2, temp1);
    memcpy(temp3, temp2, 4);
 
    return 0;
}
