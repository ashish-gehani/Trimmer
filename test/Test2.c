
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>
 
#define BUF_SIZE 15
 

int main(int argc, char* argv[]) {
 
    int input_fd, output_fd;    /* Input and output file descriptors */
    ssize_t ret_in, ret_out;    /* Number of bytes returned by read() and write() */
    char buffer[BUF_SIZE];      /* Character buffer */
 
    
    /* Create input file descriptor */
    input_fd = open ("staticFile", O_RDONLY);
    if (input_fd == -1) {
            perror ("open");
            return 2;
    }
 
    ret_in = read (input_fd, &buffer, 10);
    
    printf("buffer value %s \n", buffer);	
    printf("bytes returned %d \n", ret_in);

    ret_in = read (input_fd, &buffer, 10);
    
    printf("buffer value %s \n", buffer);   
    printf("bytes returned %d \n", ret_in);


    /* Close file descriptors */
    close (input_fd);
 
    return (EXIT_SUCCESS);
}
