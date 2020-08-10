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
char * argv[] = {"test", "-a", "-b", "-s", "hello"};

int main(argc) {
    int *temp TRACK;
    if(argc) {
        temp+= 1;
    }
    return 0;
}
