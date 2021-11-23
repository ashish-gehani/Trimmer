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

char temp[] = "asdf";

int main(int argc, char ** argv) {
    memcpy(temp, argv[0], 2);
    return 0;
}
