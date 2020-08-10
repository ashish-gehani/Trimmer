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
char * argv[] = {"test", "-a", "-b", "-s", "hello"};
int argc = 5;

int main(argc) {
    int *temp TRACK;
    temp = (int) argv[0];
    return 0;
}
