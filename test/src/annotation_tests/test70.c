/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"
#include <string.h>

/*
 * Annotation test. Check if pointer to non pointer casts
 * are tracked
 */


int main(int argc, char ** argv) {
    int * temp TRACK;
    char * temp1 TRACK;
    temp1 = argv[0];
    temp = (int)temp1;
    return 0;
}
