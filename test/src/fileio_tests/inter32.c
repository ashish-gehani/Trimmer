/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests open, read and lseek with no branch pruned

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchNotPruned(int size, char * buffer) {
  if(size == 10 && !strcmp(buffer, "helloWorld"))
    printf("branchNotPruned\n");
}

int main(int argc, char ** argv) {
  char * buffer1 = argv[0];
  char buffer2[100];
  int fd = open("../data/configFile32.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  read(fd, buffer1, strlen(buffer1));
  lseek(fd, 0, SEEK_SET);
  int bytes_read = read(fd, buffer2, 100);
  buffer2[bytes_read] = '\0';
  branchNotPruned(bytes_read, buffer2);
  close(fd);
  return 0;
}
