/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

//test file open, read  and lseek calls

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

void branchPruned(char ** buffer) {
	if(!strcmp(buffer[0], "helloWorld1\n") &&
	!strcmp(buffer[1], "helloWorld2\n") &&
	!strcmp(buffer[2], "helloWorld3\n") &&
	!strcmp(buffer[3], "helloWorld4\n") &&
  !strcmp(buffer[4], "helloWorld5\n") &&
  !strcmp(buffer[5], "\n") &&
  !strcmp(buffer[6], "\n") &&
  !strcmp(buffer[7], "\n") &&
  !strcmp(buffer[8], "\n") &&
  !strcmp(buffer[9], "\n"))
		printf("branchPruned\n");
}
char * getLine(int fd, char * line, int size) {
  int offset = lseek(fd, 0, SEEK_CUR);
  printf("offset:%i\n",offset);
  int bytes_read = read(fd, line, size);
  printf("bytes read:%i\n",bytes_read);
  if(bytes_read <= 0) return NULL;
  if(bytes_read < size) line[bytes_read] = '\n';
  int idx = strcspn(line, "\n");
  printf("idx:%i\n",idx);
  if(idx < size) line[idx + 1] = '\0';
  offset = lseek(fd, offset + idx + 1, SEEK_SET);
  return line;
}


int main(int argc, char ** argv) {
  char * buffer[10];
  char line[1024];
  int fd = open("../data/configFile2.txt", O_RDONLY);
  if(fd < 0) printf("file not found\n");

  for(int i = 0; getLine(fd, line, 1024); i++) { 
    buffer[i] = malloc(100);
    memcpy(buffer[i], line, strlen(line) + 1);
  } 
  branchPruned(buffer);
  close(fd);
  return 0;
}
