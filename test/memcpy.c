
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>
 
#define BUF_SIZE 15
 

int main(int argc, char* argv[]) {
 
    char buffer[BUF_SIZE];      /* Character buffer */   
    char testString[] = "What the hell are you waiting for "; 
	  
    memcpy(buffer, testString, 10);
  
    printf("buffer value %s \n", buffer);	
    //printf("bytes returned %d \n", ret_in);

    return 0;
}

