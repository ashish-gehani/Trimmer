/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test file open, read  and lseek calls (all file I/O calls are located in different functions) with lseek call in a non-folded branch. Hence, file offset becomes non-constant and future file I/O calls are not folded.


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

struct Config {
  char buffer[100];
  int fd;
};

struct Config * config;

void branchNotPruned(char * buffer) {
  if(!strcmp(buffer, "helloWorld0"))
    printf("branchNotPruned 0\n");
  else if(!strcmp(buffer, "helloWorld1"))
    printf("branchNotPruned 1\n");
}

void initConfig(char * str, int fd) {
  config = malloc(sizeof(struct Config));
  config->fd = fd;
  if(!strcmp(str, "1")) lseek(config->fd, 11, SEEK_SET);
}

void readConfig() {
  int bytes_read = read(config->fd, config->buffer, 11);
  config->buffer[bytes_read] = '\0';
}

int main(int argc, char ** argv) {
  int fd = open("../data/configFile6.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  initConfig(argv[1], fd);
  readConfig();
  branchNotPruned(config->buffer);
  close(fd);
  return 0;
}
