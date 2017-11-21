/* $Revision$ */
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>

int main(int argc, char *argv[])
{
	int qlen = 5;

	setsockopt(sfd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen));

	return 0;
}
