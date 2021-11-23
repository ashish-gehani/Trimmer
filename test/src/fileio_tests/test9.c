/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test file open, pread  and lseek calls

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchPruned(int size, char * buffer) {
  if(size == 8 && !strcmp(buffer, "lloWorld"))
    printf("branchPruned\n");
}

int main(int argc, char ** argv) {
  char buffer[100];
  int a = 2;
  int fd = open("../data/configFile9.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  int offset = lseek(fd,0,SEEK_SET);
  printf("%i\n",offset);
  int bytes_read = pread(fd, buffer, 100,a);
  printf("%s\n",buffer);
  offset = lseek(fd,0,SEEK_CUR);
  printf("%i\n",offset);
  buffer[bytes_read] = '\0';
  branchPruned(bytes_read, buffer);
  close(fd);
  return 0;
}
