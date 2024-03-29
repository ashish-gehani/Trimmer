/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test file open, read  and lseek calls (open and read/lseek calls are located in different functions)

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

void branchPruned(char * buffer) {
  if(!strcmp(buffer, "helloWorld0"))
    printf("branchPruned 0\n");
}

void initConfig() {
  int fd = open("../data/configFile19.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  config = malloc(sizeof(struct Config));
  config->fd = fd;


}

void readConfig() {
  int bytes_read = read(config->fd, config->buffer, 11);
  config->buffer[bytes_read] = '\0';
  lseek(config->fd,11,SEEK_SET);
}

int main(int argc, char ** argv) {
  initConfig();
  readConfig();
  branchPruned(config->buffer);
  close(config->fd);
  return 0;
}
