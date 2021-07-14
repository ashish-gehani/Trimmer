/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdint.h>
#include <stdio.h>

/**
 * Without the check for not replacing pointer size
 * integers in code with constants, the following code
 * will place the shadow register value for address
 * of argc in the IR, since it was casted to an
 * integer. This needs to be fixed in a better way.
 */

void branchPruned(int x)
{
  if(x==5)
    printf("branchNotPruned");

}

int main(int argc, char ** argv) {
    uint64_t temp = &argc;  
    int * b = temp; 
    *b = 5;
    branchPruned(argc);
    return temp;
}
