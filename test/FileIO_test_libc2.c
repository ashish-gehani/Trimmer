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
 
#define BUF_SIZE 100
 
int main(int argc, char* argv[]) {
  
  int n; 
  ssize_t ret_in, ret_out;    /* Number of bytes returned by read() and write() */
  char buffer[BUF_SIZE];      /* Character buffer */
  
  /* Create input file descriptor */
  FILE * input_fd = fopen ("test/smallFile", "r");
   
  char outChar = fgetc(input_fd);  
  /* reading the complete file in a loop */
  printf("char %c", outChar);
  outChar = fgetc(input_fd);  
  printf("char %c", outChar);
  outChar = fgetc(input_fd); 
  printf("char %c", outChar);
  if(outChar == EOF)
    printf("Did reach EOF \n");     

  /* Close file descriptors */
  fclose (input_fd);
 
  return (EXIT_SUCCESS);
}    

