/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include "annotate.h"

/*
 * Basic annotation test. Check if temp is added to track set
 */


int main(int argc, char ** argv) {
    char *temp[1] TRACK;
    char **temp2[1] TRACK;
    temp[0] = argv[argc]; 
    temp2[0] = &argv;
    return 0;
}
