/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#define TRACK __attribute__((annotate("")))

void *malloc(unsigned size) TRACK;
