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
  int fd = open("inter31_fileio.txt", O_RDONLY);
  int bytes_read = read(fd, buffer, 100);
  buffer[bytes_read] = '\0';
  branchPruned(bytes_read, buffer);
  return 0;
}
