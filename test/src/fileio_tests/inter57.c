#include <sys/mman.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

char* mmappedData;

size_t getFileSize(const char* filename){
  struct stat st;
  stat(filename,&st);
  return st.st_size;
}

void branchPruned(char * buffer) {
  if(buffer[0]=='h' && buffer[1]=='e' && buffer[2]=='l' && buffer[3]=='l' && buffer[4]=='o' && buffer[5]=='W'&& buffer[6]=='o'&& buffer[7]=='r'&& buffer[8]=='l'&& buffer[9]=='d')
    printf("branchPruned\n");

}


int main(int argc,char** argv){
  size_t filesize = getFileSize("../data/configFile57.txt");
  int fd = open("../data/configFile57.txt",O_RDONLY);
  if (fd<0) {printf("file not found"); return -1;}
  mmappedData = mmap(NULL,80,PROT_READ,MAP_PRIVATE|MAP_POPULATE,fd,0);
  if (mmappedData !=MAP_FAILED){
  branchPruned(mmappedData);
  int rc = munmap(mmappedData,1);
  if (rc!=0){printf("unmap failed");}
   }
  close(fd);
  return 0;
}

