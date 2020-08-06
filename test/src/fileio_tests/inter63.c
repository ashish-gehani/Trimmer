#include <unistd.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <syslog.h>
#include <limits.h>
#include <sys/param.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <time.h>
#include <pwd.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <ctype.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <dirent.h>


int port;
int debug;





void branchPruned(char * str) {
  if(strcmp(str,"debug")==0)
    printf("branchPruned\n");
}

int main(int argc, char** argv)
{

    port = 0;
    debug=0;
    char line[10000];
    char * cp2;
    char * str;
    char * filename = "../data/configFile63.txt";
    FILE* fp = fopen( filename, "r" );
    if ( fp == (FILE*) 0 )
	{
	syslog( LOG_CRIT, "%s - %m", filename );
	perror( filename );
	exit( 1 );
	}

    str =fgets( line, sizeof(line), fp );
    cp2 = strchr(str,' ');
    while ( *cp2 == ' ')
         *cp2++ = '\0';
    branchPruned(str);
  
  return 0;

}


