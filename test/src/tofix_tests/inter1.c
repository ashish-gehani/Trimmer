/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <stdint.h>

/**
 * Without the check for not replacing pointer size
 * integers in code with constants, the following code
 * will place the shadow register value for address
 * of argc in the IR, since it was casted to an
 * integer. This needs to be fixed in a better way.
 */
void external(uint64_t);
int main(int argc) {
    uint64_t temp = &argc;
    external(temp);
    return temp;
}
