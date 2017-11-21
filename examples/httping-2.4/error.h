/* Released under GPLv2 with exception for the OpenSSL library. See license.txt */
/* $Revision$ */

void error_exit(const char *format, ...);
void set_error(const char *str, ...);
void clear_error(void);
char * get_error(void);
