
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main() {
	struct sockaddr_in6 s; struct in6_addr t=in6addr_any; int i=AF_INET6; s; t.s6_addr[0] = 0;
	return 0;
}
