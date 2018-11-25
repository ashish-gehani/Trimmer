#ifndef M_MAP_INFO_H
#define M_MAP_INFO_H
# include <stdio.h>

/*
 * The structure is used to bridge the gap between mmap and munmap instructions 
*/
struct MMapInfo {
  int sfd; //the file descriptor number
  char * buffer; // the buffer where mmap instruction is mapped
};

#endif
