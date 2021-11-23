/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test simple file open and read calls

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchPruned(int size, char * buffer) {
  if(size == 10 && !strcmp(buffer, "helloWorld"))
    printf("branchPruned\n");
}

int main(int argc, char ** argv) {
  char buffer[100];
  int fd = open("../data/configFile1.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  int bytes_read = read(fd, buffer, 100);
  buffer[bytes_read] = '\0';
  branchPruned(bytes_read, buffer);
  close(fd);
  return 0;
}
