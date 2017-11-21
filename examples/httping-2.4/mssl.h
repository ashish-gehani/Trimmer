/* Released under GPLv2 with exception for the OpenSSL library. See license.txt */
/* $Revision$ */

#include <netdb.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>

void shutdown_ssl(void);
char close_ssl_connection(SSL *ssl_h);
int READ_SSL(SSL *ssl_h, char *whereto, int len);
int WRITE_SSL(SSL *ssl_h, const char *whereto, int len);
int connect_ssl(int fd, SSL_CTX *client_ctx, SSL **ssl_h, BIO **s_bio, double timeout, double *ssl_handshake);
SSL_CTX * initialize_ctx(char ask_compression);
char * get_fingerprint(SSL *ssl_h);
int connect_ssl_proxy(int fd, struct addrinfo *ai, double timeout, const char *proxy_user, const char *proxy_password, const char *hostname, int portnr, char *tfo);
