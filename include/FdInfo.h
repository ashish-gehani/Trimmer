#ifndef FD_INFO_H
#define FD_INFO_H


/*
 * The structure used for tracking fileIO system calls
 * open, read, lseek
*/
struct FdInfo {
  int fd, offset;
  bool tracked;
};

#endif
