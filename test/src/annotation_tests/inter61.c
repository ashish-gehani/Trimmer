/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

char *argv[] = {"abcdefg"};
char progName[1024];

void copyFileName(char *to, char*from) {
    strncpy(progName, argv[0], 6);
}

int main() {
    copyFileName ( progName, argv[0] );
    return 0;
}
