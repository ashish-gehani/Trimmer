/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

// This file consists of a structure MMapInfo, which is used to bridge the gap between mmap and munmap instructions. 

#ifndef M_MAP_INFO_H
#define M_MAP_INFO_H
# include <stdio.h>

struct MMapInfo {
  int sfd; //the file descriptor number
  char * buffer; // the buffer where mmap instruction is mapped
};

#endif
