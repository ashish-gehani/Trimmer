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
char *argv[] = {"test", "-a", "-b", "-s", "hello"};
char temp[] = "asdf";

void test(char *argv[]) {
    char *test;
    if(strcmp(argv[2], "-a")&& &test)
        memcpy(test, argv[2], 100);
}
int main() {

    test(argv);
    return 0;
}
