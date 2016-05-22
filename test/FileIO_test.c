
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
  
    // printf("enter value for n\n");
    //scanf("%d", &n);

    /* Create input file descriptor */
    input_fd = open ("staticFile", O_RDONLY);
    if (input_fd == -1) {
      perror ("open");
      return 2;
    }
 
   
    while ((read (input_fd, &buffer, 10) == 0))
      printf("buffer value %s \n", buffer);	

    /* Close file descriptors */
    close (input_fd);
 
    return (EXIT_SUCCESS);
}    

