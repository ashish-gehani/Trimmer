/*
 * Copyright (c) 2020 SRI International All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */


//A more complex example (simplified from mini_httpd) that test fgets call as a loop condition

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

void read_config( char* filename );



void branchPruned(int debug,int port) {
  if(debug == 1 && port==60)
    printf("branchPruned\n");
}

int main(int argc, char** argv)
{

    port = 0;
    debug=0;
    read_config("../data/configFile22.txt");
    branchPruned(debug,port);
  
  return 0;

}

void read_config( char* filename )
    {
    FILE* fp;
    char line[10000];
    char* cp;
    char* cp2;
    char* name;
    char* value;

    fp = fopen( filename, "r" );
    if ( fp == (FILE*) 0 )
	{
	syslog( LOG_CRIT, "%s - %m", filename );
	perror( filename );
	exit( 1 );
	}

    while ( fgets( line, sizeof(line), fp ) != (char*) 0 )
	{
	/* Trim comments. */
	if ( ( cp = strchr( line, '#' ) ) != (char*) 0 )
	    *cp = '\0';

	/* Skip leading whitespace. */
	cp = line;
        printf("strspn= %lu\n",strspn( cp, "\012" ));
	cp += strspn( cp, " \t\012\015" );
        printf("cp= %s\n",cp);


	/* Split line into words. */
	while ( *cp != '\0' )
	    {
	    /* Find next whitespace. */
	    cp2 = cp + strcspn( cp, "\012" );
            printf("cp2= %s\n",cp2);
	    /* Insert EOS and advance next-word pointer. */
	    while (*cp2 == '\012')
		*cp2++ = '\0';
	    /* Split into name and value. */
            printf("cp2= %s\n",cp2);
            printf("cp= %s\n",cp);
	    name = cp;

	    value = strchr( name, '=' );
	    if ( value != (char*) 0 )
		*value++ = '\0';

	    /* Interpret. */
	     if ( strcasecmp( name, "port" ) == 0 )
		{
		port = atoi(value);
                printf("%i\n",port);

            }

            else if ( strcasecmp( name, "debug" ) == 0 )
		{
                  debug=1;


            }
	    
	    else
		{
		printf("unknown config option '%s'\n", name );
		exit( 1 );
		}

	    /* Advance to next word. */
	    cp = cp2;
	    cp += strspn( cp, "\012" );
	    }
	}

    (void) fclose( fp );

    /* NOTE: Hardcoding do_ssl */

 }



