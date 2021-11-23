/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test file open, read  and lseek calls with lseek call in a non-folded branch. Hence, file offset becomes non-constant and future file I/O calls are not folded.

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchNotPruned(char * buffer) {
  if(!strcmp(buffer, "helloWorld0"))
    printf("branchNotPruned 0\n");
  else if(!strcmp(buffer, "helloWorld1"))
    printf("branchNotPruned 1\n");
}

int main(int argc, char ** argv) {
  char buffer[100];
  int fd = open("../data/configFile5.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  if(!strcmp(argv[1], "1")) lseek(fd, 11, SEEK_SET);
  int bytes_read = read(fd, buffer, 11);
  buffer[bytes_read] = '\0';
  branchNotPruned(buffer);
  close(fd);
  return 0;
}
