#ifndef FD_INFO_H
#define FD_INFO_H
# include <stdio.h>

/*
 * The structure used for tracking fileIO descriptors
 * open, read, pread, lseek, fopen, fread, fseek, fgets, mmap, munmap,close, fclose
*/
struct FdInfo {
  FILE *fptr; //for fopen, fread, fseek, fgets, fclose calls
  int fd; //for open, read, lseek, pread, mmap, munmap, close calls
  char * fileName; //File name
  long offset; // current offset of the File
  bool tracked; // tracks whether the file structure is valid or not
};

#endif
