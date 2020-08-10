/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests open and read

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchNotPruned(int size, char * buffer) {
  if(size == 22 && !strcmp(buffer, "helloWorld\nabcdefghij\n"))
    printf("branch Not Pruned\n");
}

int main(int argc, char ** argv) {
  char buffer[100];
  char buffer1[100];
  int fd = open("../data/configFile59.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  int bytes_read;
  if(argc==1)
    bytes_read = read(fd, buffer, 100);
  buffer[bytes_read] = '\0';
  int bytes_read1 = read(fd, buffer1, 100);
  buffer1[bytes_read1] = '\0';
  branchNotPruned(bytes_read, buffer);
  close(fd);
  return 0;
}
