/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test file open and read calls with buffer of integer type

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchPruned(int * buffer) {
  if(buffer[0] == 1819043176 && buffer[1] == 1919899503 && buffer[2] == 25708)
    printf("branchPruned");
}

int main(int argc, char ** argv) {
  int buffer[5];
  for(int i=0;i<5;i++)
    buffer[i]=0;
  int fd = open("../data/configFile11.txt", O_RDONLY);
  if(fd < 0) { printf("file not found\n");}
  int bytes_read = read(fd, buffer, 20);
  close(fd);
  printf("%d\n",bytes_read);
  branchPruned(buffer);
  return 0;
}
