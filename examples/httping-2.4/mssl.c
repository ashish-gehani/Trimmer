/* Released under GPLv2 with exception for the OpenSSL library. See license.txt */
/* $Revision$ */

#include <errno.h>
#include <libintl.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <openssl/bio.h>
#include <openssl/conf.h>
#include <openssl/engine.h>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <openssl/md5.h>
#include <openssl/ssl.h>
#include <openssl/x509.h>

#include "error.h"
#include "gen.h"
#include "mssl.h"
#include "tcp.h"
#include "io.h"
#include "http.h"
#include "utils.h"

BIO *bio_err = NULL;

void shutdown_ssl(void)
{
	BIO_free(bio_err);

	ERR_free_strings();

	ERR_remove_state(0);
	ENGINE_cleanup();
	CONF_modules_free();
	EVP_cleanup();
	CRYPTO_cleanup_all_ex_data();
}

char close_ssl_connection(SSL *ssl_h)
{
	int rc = SSL_shutdown(ssl_h);

	if (!rc)
		rc = SSL_shutdown(ssl_h);

/*
ignoring failures: the socket will be closed
anyway later on so any openssl failures won't
do any harm
	if (rc == -1)
	{
		fprintf(stderr, "SSL_shutdown failed: %s\n", strerror(errno));
		return -1;
	}
*/

	return 0;
}

int READ_SSL(SSL *ssl_h, char *whereto, int len)
{
	int cnt=len;

	while(len>0)
	{
		int rc;

		rc = SSL_read(ssl_h, whereto, len);
		if (rc == -1)
		{
			if (errno != EINTR && errno != EAGAIN)
			{
				set_error(gettext("READ_SSL: io-error: %s"), strerror(errno));
				return -1;
			}
		}
		else if (rc == 0)
		{
			return 0;
		}
		else
		{
			whereto += rc;
			len -= rc;
		}
	}

	return cnt;
}

int WRITE_SSL(SSL *ssl_h, const char *wherefrom, int len)
{
	int cnt=len;

	while(len>0)
	{
		int rc;

		rc = SSL_write(ssl_h, wherefrom, len);
		if (rc == -1)
		{
			if (errno != EINTR && errno != EAGAIN)
			{
				set_error(gettext("WRITE_SSL: io-error: %s"), strerror(errno));
				return -1;
			}
		}
		else if (rc == 0)
		{
			return 0;
		}
		else
		{
			wherefrom += rc;
			len -= rc;
		}
	}

	return cnt;
}

int connect_ssl(int fd, SSL_CTX *client_ctx, SSL **ssl_h, BIO **s_bio, double timeout, double *ssl_handshake)
{
	int dummy = -1;
	double dstart = get_ts();

	struct timeval tv;
	tv.tv_sec  = (long)(timeout / 1000.0);
	tv.tv_usec = (long)(timeout * 1000.0) % 1000000;

	*ssl_handshake = -1.0;

	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof tv) == -1)
	{
		set_error(gettext("problem setting receive timeout (%s)"), strerror(errno));
		return -1;
	}

	if (setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof tv) == -1)
	{
		set_error(gettext("problem setting transmit timeout (%s)"), strerror(errno));
		return -1;
	}

	*ssl_h = SSL_new(client_ctx);

	*s_bio = BIO_new_socket(fd, BIO_NOCLOSE);
	SSL_set_bio(*ssl_h, *s_bio, *s_bio);

	dummy = SSL_connect(*ssl_h);
	if (dummy <= 0)
	{
		set_error(gettext("problem starting SSL connection: %d"), SSL_get_error(*ssl_h, dummy));
		return -1;
	}

	*ssl_handshake = get_ts() - dstart;

	return 0;
}

SSL_CTX * initialize_ctx(char ask_compression)
{
	const SSL_METHOD *meth = NULL;
	SSL_CTX *ctx = NULL;

	if (!bio_err)
	{
		SSL_library_init();
		SSL_load_error_strings();
		ERR_load_crypto_strings();

		/* error write context */
		bio_err = BIO_new_fp(stderr, BIO_NOCLOSE);
	}

	/* create context */
	meth = SSLv23_method();
	ctx = SSL_CTX_new(meth);

#ifdef SSL_OP_NO_COMPRESSION
	if (!ask_compression)
		SSL_CTX_set_options(ctx, SSL_OP_NO_COMPRESSION);
#endif

	return ctx;
}

char * get_fingerprint(SSL *ssl_h)
{
	char *string = NULL;

	unsigned char fp_digest[EVP_MAX_MD_SIZE];
	X509 *x509_data = SSL_get_peer_certificate(ssl_h);

	if (x509_data)
	{
		unsigned int fp_digest_size = sizeof fp_digest;

		memset(fp_digest, 0x00, fp_digest_size);

		if (X509_digest(x509_data, EVP_md5(), fp_digest, &fp_digest_size))
		{
			string = (char *)malloc(MD5_DIGEST_LENGTH * 3 + 1);
			if (string)
			{
				int loop, pos =0;

				for(loop=0; loop<MD5_DIGEST_LENGTH; loop++)
				{
					if (loop)
						pos += sprintf(&string[pos], ":%02x", fp_digest[loop]);
					else
						pos = sprintf(&string[pos], "%02x", fp_digest[loop]);
				}
			}
		}

		X509_free(x509_data);
	}

	return string;
}

int connect_ssl_proxy(int fd, struct addrinfo *ai, double timeout, const char *proxy_user, const char *proxy_password, const char *hostname, int portnr, char *tfo)
{
	int rc = -1;
	char request_headers[4096] = { 0 };
	int request_headers_len = -1;
	char rh_sent = 0;
	char *response_headers = NULL, *code = NULL, *term = NULL;

	request_headers_len = snprintf(request_headers, sizeof request_headers, "CONNECT %s:%d HTTP/1.1\r\nUser-Agent: HTTPing v" VERSION \
			"\r\nProxy-Connection: keep-alive\r\nConnection: keep-alive\r\nHost: %s\r\n", hostname, portnr, hostname);

        if (proxy_user)
        {
                char ppa_string[256] = { 0 };
                char b64_ppa_string[512] = { 0 };

                sprintf(ppa_string, "%s:%s", proxy_user, proxy_password);
                enc_b64(ppa_string, strlen(ppa_string), b64_ppa_string);
                request_headers_len += snprintf(&request_headers[request_headers_len], sizeof request_headers - request_headers_len, "Proxy-Authorization: Basic %s\r\n", b64_ppa_string);
        }

	request_headers_len += snprintf(&request_headers[request_headers_len], sizeof request_headers - request_headers_len, "\r\n");

	if ((rc = connect_to(fd, ai, timeout, tfo, request_headers, request_headers_len, &rh_sent)) < 0)
		return rc;

	if (!rh_sent)
	{
		if ((rc = mywrite(fd, request_headers, request_headers_len, timeout)) < RC_OK)
		{
			set_error(gettext("Problem sending request to proxy"));
			return rc;
		}
	}

	rc = dumb_get_HTTP_headers(fd, &response_headers, timeout);
	if (rc != RC_OK)
	{
		free(response_headers);
		set_error(gettext("Problem retrieving proxy response"));
		return rc;
	}

	term = strchr(response_headers, '\r');
	if (!term)
		term = strchr(response_headers, '\n');
	if (term)
		*term = 0x00;

	code = strchr(response_headers, ' ');
	if (!code)
	{
		free(response_headers);
		set_error(gettext("Invalid proxy response headers"));
		return RC_INVAL;
	}

	if (atoi(code + 1) != 200)
	{
		free(response_headers);
		set_error(gettext("Proxy indicated error: %s"), code + 1);
		return RC_INVAL;
	}

	free(response_headers);

	return RC_OK;
}
