/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <ctype.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "annotate.h"


char progName[1024];

void copyFileName(char *to, char*from) {
    strncpy(to, from, 6);
}

int main(int argc, char **argv) {
    copyFileName ( progName, argv[0] );
    printf("%s\n",progName);
    return 0;
}
