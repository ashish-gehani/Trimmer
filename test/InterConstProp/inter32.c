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
  !strcmp(buffer[4], "helloWorld5\n"))
		printf("branchPruned\n");
}

char * getLine(int fd, char * line, int size) {
	int offset = lseek(fd, 0, SEEK_CUR);
	int bytes_read = read(fd, line, size);
	if(bytes_read <= 0) return NULL;
	int idx = strcspn(line, "\n");
  if(idx < size) line[idx + 1] = '\0';
	offset = lseek(fd, offset + idx + 1, SEEK_SET);
	return line;
}

int main(int argc, char ** argv) {
  char * buffer[10];
  buffer[0] = malloc(100);
  buffer[1] = malloc(100);
  buffer[2] = malloc(100);
  buffer[3] = malloc(100);
  buffer[4] = malloc(100);
  buffer[5] = malloc(100);
  buffer[6] = malloc(100);
  buffer[7] = malloc(100);
  buffer[8] = malloc(100);
  buffer[9] = malloc(100);

  char line[1024];
  int fd = open("inter32_fileio.txt", O_RDONLY);
  for(unsigned i = 0; getLine(fd, line, 1024); i++) {
  	memcpy(buffer[i], line, strlen(line) + 1);
  }
  branchPruned(buffer);
  return 0;
}
