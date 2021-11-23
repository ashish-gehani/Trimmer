/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test simple file open and read calls 2 (only difference with test1.c is that in test1.c, the condition is written as fd<0 whereas here it is written as 0<=fd)

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
  int fd = open("../data/configFile14.txt", O_RDONLY);
  if(0<=fd){
    int bytes_read = read(fd, buffer, 100);
    buffer[bytes_read] = '\0';
    branchPruned(bytes_read, buffer);
    close(fd);
  }
 

  else printf("file not found\n");

  return 0;
}
