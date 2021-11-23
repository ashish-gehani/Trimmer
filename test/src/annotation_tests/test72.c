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
    char *temp = argv[1];
    char *temp2 = argv[0];
    if(temp == temp2)
        argc++;
    return 0;
}
