/* 
   Author: Hashim Sharif
   Email: hsharif3

   Description: This test demonstrates the optimizations (sccp) 
   achieved with specializing read calls with llvm.memcpy intrinsics.
*/

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>
 
#define BUF_SIZE 15
 
int main(int argc, char* argv[]) {
  
  int n;
  int input_fd, output_fd;    /* Input and output file descriptors */
  ssize_t ret_in, ret_out;    /* Number of bytes returned by read() and write() */
  char buffer[BUF_SIZE];      /* Character buffer */
  
  /* Create input file descriptor */
  input_fd = open ("test/staticFile", O_RDONLY);
  if (input_fd == -1) {
    perror ("open");
    return 2;
  }
   
  /* This read call will be replaced with llvm.memcpy instrinsic */ 
  int retBytes = read(input_fd, &buffer, 10);    
  if(buffer[0] == 'S'){
    printf("This print will be transformed to an unconditional call"); 
  }

  /* Close file descriptor */
  close (input_fd);
 
  return (EXIT_SUCCESS);
}    

