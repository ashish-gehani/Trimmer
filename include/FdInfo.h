/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

/*This file consists of the structure FdInfo used for tracking fileIO descriptors.*/


#ifndef FD_INFO_H
#define FD_INFO_H
# include <stdio.h>

 
struct FdInfo {
  FILE *fptr; //for fopen, fread, fseek, fgets, fclose calls
  char * fileName; //File name
  long offset; // current offset of the File
  int fd; //for open, read, lseek, pread, mmap, munmap, close calls
  bool tracked; // tracks whether the file structure is valid or not
};

#endif
