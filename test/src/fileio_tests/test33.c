/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests open and read with external function

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

extern void externalFunc(char *);

void branchPruned(int size, char * buffer) {
  if(size == 10 && !strcmp(buffer, "helloWorld"))
    printf("branchPruned\n");
}

int main(int argc, char ** argv) {
  char buffer[100];
  externalFunc(buffer);
  int fd = open("../data/configFile33.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  int bytes_read = read(fd, buffer, 100);
  buffer[bytes_read] = '\0';
  branchPruned(bytes_read, buffer);
  close(fd);
  return 0;
}
