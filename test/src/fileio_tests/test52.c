/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//tests open and read in a loop

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchPruned(int size, char * buffer) {
  if(size == 30 && !strcmp(buffer, "helloWorldhelloWorldhelloWorld"))
    printf("branchPruned\n");
}

int main(int argc, char ** argv) {
  char buffer[100];
  int fd = open("../data/configFile52.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  int bytes_read = 0;
  int n = 30;
  int i=0;

  while(i != 30)
  {
     read(fd, &buffer[i], 1);
     bytes_read++;
     i++;
  }
  close(fd);
  buffer[bytes_read] = '\0';
  branchPruned(bytes_read, buffer);
  return 0;
}
