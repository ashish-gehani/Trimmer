/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test file open, read  and lseek calls (all file I/O calls are located in different functions) with lseek call in a non-folded branch. Hence, file offset becomes non-constant and future file I/O calls are not folded. The difference between test6.c and this test is that in test6.c, config->fd is set in initConfig function, whereas here it is set in main function.


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

void initConfig(char * str) {
  if(!strcmp(str, "1")) lseek(config->fd, 11, SEEK_SET);
}

void readConfig() {
  int bytes_read = read(config->fd, config->buffer, 11);
  config->buffer[bytes_read] = '\0';
}

int main(int argc, char ** argv) {
  int fd = open("../data/configFile21.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");
  config = malloc(sizeof(struct Config));
  config->fd = fd;
  initConfig(argv[1]);
  readConfig();
  branchNotPruned(config->buffer);
  close(fd);
  return 0;
}
