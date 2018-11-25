//tests open and read

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
  int fd = open("../data/configFile53.txt", O_RDONLY);
  if(0<=fd){
    int bytes_read = read(fd, buffer, 100);
    buffer[bytes_read] = '\0';
    branchPruned(bytes_read, buffer);
    close(fd);
  }
 

  else printf("file not found\n");

  return 0;
}
