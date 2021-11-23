/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check whether argc values are being tracked
 */


int main(int argc, char ** argv) {
    int *temp TRACK;
    int temp2 TRACK;
    temp2 = argc;
    if(temp2) {
        temp+= 1;
    }
    return 0;
}
