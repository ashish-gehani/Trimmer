/*
  Author: Hashim Sharif
  Email: hsharif3@illinois.edu

  Descrition: This test demonstrates:
  a) Loop unrolling to unroll all read calls with constant offsets
  b) Replacing read calls with llvm.memcpy intrinsics
  c) Replacing the read return value with correct number of returned bytes - llvm.memcpy does not return a value
  d) -03 pass run after specialisation prunes all the unnecessary calls to llvm.memcpy

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
    
  /* reading the complete file in a loop */
  while ((read (input_fd, &buffer, 10) != 0))
    printf("%s\n", buffer);	

   /* Close file descriptors */
  close (input_fd);
 
  return (EXIT_SUCCESS);
}    

