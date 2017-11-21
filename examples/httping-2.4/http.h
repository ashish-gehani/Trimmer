/* Released under GPLv2 with exception for the OpenSSL library. See license.txt */
/* $Revision$ */

int get_HTTP_headers(int socket_h, SSL *ssl_h, char **headers, int *overflow, double timeout);
int dumb_get_HTTP_headers(int socket_h, char **headers, double timeout);
