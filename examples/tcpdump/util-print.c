/*
 * Copyright (c) 1990, 1991, 1993, 1994, 1995, 1996, 1997
 *	The Regents of the University of California.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that: (1) source code distributions
 * retain the above copyright notice and this paragraph in its entirety, (2)
 * distributions including binary code include the above copyright notice and
 * this paragraph in its entirety in the documentation or other materials
 * provided with the distribution, and (3) all advertising materials mentioning
 * features or use of this software display the following acknowledgement:
 * ``This product includes software developed by the University of California,
 * Lawrence Berkeley Laboratory and its contributors.'' Neither the name of
 * the University nor the names of its contributors may be used to endorse
 * or promote products derived from this software without specific prior
 * written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * txtproto_print() derived from original code by Hannes Gredler
 * (hannes@gredler.at):
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that: (1) source code
 * distributions retain the above copyright notice and this paragraph
 * in its entirety, and (2) distributions including binary code include
 * the above copyright notice and this paragraph in its entirety in
 * the documentation or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND
 * WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT
 * LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include "netdissect-stdinc.h"

#include <sys/stat.h>

#ifdef HAVE_FCNTL_H
#include <fcntl.h>
#endif
#include <ctype.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

#include "netdissect.h"
#include "extract.h"
#include "ascii_strcasecmp.h"
#include "timeval-operations.h"

int32_t thiszone;		/* seconds offset from gmt to local time */
/* invalid string to print '(invalid)' for malformed or corrupted packets */
const char istr[] = " (invalid)";

/*
 * timestamp display buffer size, the biggest size of both formats is needed
 * sizeof("0000000000.000000000") > sizeof("00:00:00.000000000")
 */
#define TS_BUF_SIZE sizeof("0000000000.000000000")

#define TOKBUFSIZE 128

/*
 * Print out a character, filtering out the non-printable ones
 */
void
fn_print_char(netdissect_options *ndo, u_char c)
{
	if (!ND_ISASCII(c)) {
		c = ND_TOASCII(c);
		ND_PRINT("M-");
	}
	if (!ND_ISPRINT(c)) {
		c ^= 0x40;	/* DEL to ?, others to alpha */
		ND_PRINT("^");
	}
	ND_PRINT("%c", c);
}

/*
 * Print out a null-terminated filename (or other ASCII string), part of
 * the packet buffer.
 * If ep is NULL, assume no truncation check is needed.
 * Return true if truncated.
 * Stop at ep (if given) or before the null char, whichever is first.
 */
int
nd_print(netdissect_options *ndo,
         const u_char *s, const u_char *ep)
{
	int ret;
	u_char c;

	ret = 1;			/* assume truncated */
	while (ep == NULL || s < ep) {
		c = EXTRACT_U_1(s);
		s++;
		if (c == '\0') {
			ret = 0;
			break;
		}
		fn_print_char(ndo, c);
	}
	return(ret);
}

/*
 * Print out a null-terminated filename (or other ASCII string) from
 * a fixed-length buffer, part of the packet buffer.
 * If ep is NULL, assume no truncation check is needed.
 * Return the number of bytes of string processed, including the
 * terminating null, if not truncated.  Return 0 if truncated.
 */
u_int
nd_printztn(netdissect_options *ndo,
         const u_char *s, u_int n, const u_char *ep)
{
	u_int bytes;
	u_char c;

	bytes = 0;
	for (;;) {
		if (n == 0 || (ep != NULL && s >= ep)) {
			/*
			 * Truncated.  This includes "no null before we
			 * got to the end of the fixed-length buffer".
			 *
			 * XXX - BOOTP says "null-terminated", which
			 * means the maximum length of the string, in
			 * bytes, is 1 less than the size of the buffer,
			 * as there must always be a terminating null.
			 */
			bytes = 0;
			break;
		}

		c = EXTRACT_U_1(s);
		s++;
		bytes++;
		n--;
		if (c == '\0') {
			/* End of string */
			break;
		}
		fn_print_char(ndo, c);
	}
	return(bytes);
}

/*
 * Print out a counted filename (or other ASCII string), part of
 * the packet buffer.
 * If ep is NULL, assume no truncation check is needed.
 * Return true if truncated.
 * Stop at ep (if given) or after n bytes, whichever is first.
 */
int
nd_printn(netdissect_options *ndo,
          const u_char *s, u_int n, const u_char *ep)
{
	u_char c;

	while (n > 0 && (ep == NULL || s < ep)) {
		n--;
		c = EXTRACT_U_1(s);
		s++;
		fn_print_char(ndo, c);
	}
	return (n == 0) ? 0 : 1;
}

/*
 * Print out a null-padded filename (or other ASCII string), part of
 * the packet buffer.
 * If ep is NULL, assume no truncation check is needed.
 * Return true if truncated.
 * Stop at ep (if given) or after n bytes or before the null char,
 * whichever is first.
 */
int
nd_printzp(netdissect_options *ndo,
           const u_char *s, u_int n,
           const u_char *ep)
{
	int ret;
	u_char c;

	ret = 1;			/* assume truncated */
	while (n > 0 && (ep == NULL || s < ep)) {
		n--;
		c = EXTRACT_U_1(s);
		s++;
		if (c == '\0') {
			ret = 0;
			break;
		}
		fn_print_char(ndo, c);
	}
	return (n == 0) ? 0 : ret;
}

/*
 * Format the timestamp
 */
static char *
ts_format(netdissect_options *ndo
#ifndef HAVE_PCAP_SET_TSTAMP_PRECISION
_U_
#endif
, int sec, int usec, char *buf)
{
	const char *format;

#ifdef HAVE_PCAP_SET_TSTAMP_PRECISION
	switch (ndo->ndo_tstamp_precision) {

	case PCAP_TSTAMP_PRECISION_MICRO:
		format = "%02d:%02d:%02d.%06u";
		break;

	case PCAP_TSTAMP_PRECISION_NANO:
		format = "%02d:%02d:%02d.%09u";
		break;

	default:
		format = "%02d:%02d:%02d.{unknown}";
		break;
	}
#else
	format = "%02d:%02d:%02d.%06u";
#endif

	nd_snprintf(buf, TS_BUF_SIZE, format,
                 sec / 3600, (sec % 3600) / 60, sec % 60, usec);

        return buf;
}

/*
 * Format the timestamp - Unix timeval style
 */
static char *
ts_unix_format(netdissect_options *ndo
#ifndef HAVE_PCAP_SET_TSTAMP_PRECISION
_U_
#endif
, int sec, int usec, char *buf)
{
	const char *format;

#ifdef HAVE_PCAP_SET_TSTAMP_PRECISION
	switch (ndo->ndo_tstamp_precision) {

	case PCAP_TSTAMP_PRECISION_MICRO:
		format = "%u.%06u";
		break;

	case PCAP_TSTAMP_PRECISION_NANO:
		format = "%u.%09u";
		break;

	default:
		format = "%u.{unknown}";
		break;
	}
#else
	format = "%u.%06u";
#endif

	nd_snprintf(buf, TS_BUF_SIZE, format,
		 (unsigned)sec, (unsigned)usec);

	return buf;
}

/*
 * Print the timestamp
 */
void
ts_print(netdissect_options *ndo,
         const struct timeval *tvp)
{
	int s;
	struct tm *tm;
	time_t Time;
	char buf[TS_BUF_SIZE];
	static struct timeval tv_ref;
	struct timeval tv_result;
	int negative_offset;
	int nano_prec;

	switch (ndo->ndo_tflag) {

	case 0: /* Default */
		s = (tvp->tv_sec + thiszone) % 86400;
		ND_PRINT("%s ", ts_format(ndo, s, tvp->tv_usec, buf));
		break;

	case 1: /* No time stamp */
		break;

	case 2: /* Unix timeval style */
		ND_PRINT("%s ", ts_unix_format(ndo,
			  tvp->tv_sec, tvp->tv_usec, buf));
		break;

	case 3: /* Microseconds/nanoseconds since previous packet */
        case 5: /* Microseconds/nanoseconds since first packet */
#ifdef HAVE_PCAP_SET_TSTAMP_PRECISION
		switch (ndo->ndo_tstamp_precision) {
		case PCAP_TSTAMP_PRECISION_MICRO:
			nano_prec = 0;
			break;
		case PCAP_TSTAMP_PRECISION_NANO:
			nano_prec = 1;
			break;
		default:
			nano_prec = 0;
			break;
		}
#else
		nano_prec = 0;
#endif
		if (!(netdissect_timevalisset(&tv_ref)))
			tv_ref = *tvp; /* set timestamp for first packet */

		negative_offset = netdissect_timevalcmp(tvp, &tv_ref, <);
		if (negative_offset)
			netdissect_timevalsub(&tv_ref, tvp, &tv_result, nano_prec);
		else
			netdissect_timevalsub(tvp, &tv_ref, &tv_result, nano_prec);

		ND_PRINT((negative_offset ? "-" : " "));

		ND_PRINT("%s ", ts_format(ndo,
			  tv_result.tv_sec, tv_result.tv_usec, buf));

                if (ndo->ndo_tflag == 3)
			tv_ref = *tvp; /* set timestamp for previous packet */
		break;

	case 4: /* Default + Date */
		s = (tvp->tv_sec + thiszone) % 86400;
		Time = (tvp->tv_sec + thiszone) - s;
		tm = gmtime (&Time);
		if (!tm)
			ND_PRINT("Date fail  ");
		else
			ND_PRINT("%04d-%02d-%02d %s ",
                               tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
                               ts_format(ndo, s, tvp->tv_usec, buf));
		break;
	}
}

/*
 * Print an unsigned relative number of seconds (e.g. hold time, prune timer)
 * in the form 5m1s.  This does no truncation, so 32230861 seconds
 * is represented as 1y1w1d1h1m1s.
 */
void
unsigned_relts_print(netdissect_options *ndo,
                     uint32_t secs)
{
	static const char *lengths[] = {"y", "w", "d", "h", "m", "s"};
	static const u_int seconds[] = {31536000, 604800, 86400, 3600, 60, 1};
	const char **l = lengths;
	const u_int *s = seconds;

	if (secs == 0) {
		ND_PRINT("0s");
		return;
	}
	while (secs > 0) {
		if (secs >= *s) {
			ND_PRINT("%u%s", secs / *s, *l);
			secs -= (secs / *s) * *s;
		}
		s++;
		l++;
	}
}

/*
 * Print a signed relative number of seconds (e.g. hold time, prune timer)
 * in the form 5m1s.  This does no truncation, so 32230861 seconds
 * is represented as 1y1w1d1h1m1s.
 */
void
signed_relts_print(netdissect_options *ndo,
                   int32_t secs)
{
	if (secs < 0) {
		ND_PRINT("-");
		if (secs == INT32_MIN) {
			/*
			 * -2^31; you can't fit its absolute value into
			 * a 32-bit signed integer.
			 *
			 * Just directly pass said absolute value to
			 * unsigned_relts_print() directly.
			 *
			 * (XXX - does ISO C guarantee that -(-2^n),
			 * when calculated and cast to an n-bit unsigned
			 * integer type, will have the value 2^n?)
			 */
			unsigned_relts_print(ndo, 2147483648U);
		} else {
			/*
			 * We now know -secs will fit into an int32_t;
			 * negate it and pass that to unsigned_relts_print().
			 */
			unsigned_relts_print(ndo, -secs);
		}
		return;
	}
	unsigned_relts_print(ndo, secs);
}

/* Print the truncated string */
void nd_print_trunc(netdissect_options *ndo)
{
	ND_PRINT(" [|%s]", ndo->ndo_protocol);
}

/*
 *  this is a generic routine for printing unknown data;
 *  we pass on the linefeed plus indentation string to
 *  get a proper output - returns 0 on error
 */

int
print_unknown_data(netdissect_options *ndo, const u_char *cp,const char *ident,int len)
{
	if (len < 0) {
          ND_PRINT("%sDissector error: print_unknown_data called with negative length",
		    ident);
		return(0);
	}
	if (ndo->ndo_snapend - cp < len)
		len = ndo->ndo_snapend - cp;
	if (len < 0) {
          ND_PRINT("%sDissector error: print_unknown_data called with pointer past end of packet",
		    ident);
		return(0);
	}
        hex_print(ndo, ident,cp,len);
	return(1); /* everything is ok */
}

/*
 * Convert a token value to a string; use "fmt" if not found.
 */
const char *
tok2strbuf(const struct tok *lp, const char *fmt,
	   u_int v, char *buf, size_t bufsize)
{
	if (lp != NULL) {
		while (lp->s != NULL) {
			if (lp->v == v)
				return (lp->s);
			++lp;
		}
	}
	if (fmt == NULL)
		fmt = "#%d";

	(void)nd_snprintf(buf, bufsize, fmt, v);
	return (const char *)buf;
}

/*
 * Convert a token value to a string; use "fmt" if not found.
 * Uses tok2strbuf() on one of four local static buffers of size TOKBUFSIZE
 * in round-robin fashion.
 */
const char *
tok2str(const struct tok *lp, const char *fmt,
	u_int v)
{
	static char buf[4][TOKBUFSIZE];
	static int idx = 0;
	char *ret;

	ret = buf[idx];
	idx = (idx+1) & 3;
	return tok2strbuf(lp, fmt, v, ret, sizeof(buf[0]));
}

/*
 * Convert a bit token value to a string; use "fmt" if not found.
 * this is useful for parsing bitfields, the output strings are seperated
 * if the s field is positive.
 */
static char *
bittok2str_internal(const struct tok *lp, const char *fmt,
	   u_int v, const char *sep)
{
        static char buf[1024+1]; /* our string buffer */
        char *bufp = buf;
        size_t space_left = sizeof(buf), string_size;
        u_int rotbit; /* this is the bit we rotate through all bitpositions */
        u_int tokval;
        const char * sepstr = "";

	while (lp != NULL && lp->s != NULL) {
            tokval=lp->v;   /* load our first value */
            rotbit=1;
            while (rotbit != 0) {
                /*
                 * lets AND the rotating bit with our token value
                 * and see if we have got a match
                 */
		if (tokval == (v&rotbit)) {
                    /* ok we have found something */
                    if (space_left <= 1)
                        return (buf); /* only enough room left for NUL, if that */
                    string_size = strlcpy(bufp, sepstr, space_left);
                    if (string_size >= space_left)
                        return (buf);    /* we ran out of room */
                    bufp += string_size;
                    space_left -= string_size;
                    if (space_left <= 1)
                        return (buf); /* only enough room left for NUL, if that */
                    string_size = strlcpy(bufp, lp->s, space_left);
                    if (string_size >= space_left)
                        return (buf);    /* we ran out of room */
                    bufp += string_size;
                    space_left -= string_size;
                    sepstr = sep;
                    break;
                }
                rotbit=rotbit<<1; /* no match - lets shift and try again */
            }
            lp++;
	}

        if (bufp == buf)
            /* bummer - lets print the "unknown" message as advised in the fmt string if we got one */
            (void)nd_snprintf(buf, sizeof(buf), fmt == NULL ? "#%08x" : fmt, v);
        return (buf);
}

/*
 * Convert a bit token value to a string; use "fmt" if not found.
 * this is useful for parsing bitfields, the output strings are not seperated.
 */
char *
bittok2str_nosep(const struct tok *lp, const char *fmt,
	   u_int v)
{
    return (bittok2str_internal(lp, fmt, v, ""));
}

/*
 * Convert a bit token value to a string; use "fmt" if not found.
 * this is useful for parsing bitfields, the output strings are comma seperated.
 */
char *
bittok2str(const struct tok *lp, const char *fmt,
	   u_int v)
{
    return (bittok2str_internal(lp, fmt, v, ", "));
}

/*
 * Convert a value to a string using an array; the macro
 * tok2strary() in <netdissect.h> is the public interface to
 * this function and ensures that the second argument is
 * correct for bounds-checking.
 */
const char *
tok2strary_internal(const char **lp, int n, const char *fmt,
	int v)
{
	static char buf[TOKBUFSIZE];

	if (v >= 0 && v < n && lp[v] != NULL)
		return lp[v];
	if (fmt == NULL)
		fmt = "#%d";
	(void)nd_snprintf(buf, sizeof(buf), fmt, v);
	return (buf);
}

/*
 * Convert a 32-bit netmask to prefixlen if possible
 * the function returns the prefix-len; if plen == -1
 * then conversion was not possible;
 */

int
mask2plen(uint32_t mask)
{
	uint32_t bitmasks[33] = {
		0x00000000,
		0x80000000, 0xc0000000, 0xe0000000, 0xf0000000,
		0xf8000000, 0xfc000000, 0xfe000000, 0xff000000,
		0xff800000, 0xffc00000, 0xffe00000, 0xfff00000,
		0xfff80000, 0xfffc0000, 0xfffe0000, 0xffff0000,
		0xffff8000, 0xffffc000, 0xffffe000, 0xfffff000,
		0xfffff800, 0xfffffc00, 0xfffffe00, 0xffffff00,
		0xffffff80, 0xffffffc0, 0xffffffe0, 0xfffffff0,
		0xfffffff8, 0xfffffffc, 0xfffffffe, 0xffffffff
	};
	int prefix_len = 32;

	/* let's see if we can transform the mask into a prefixlen */
	while (prefix_len >= 0) {
		if (bitmasks[prefix_len] == mask)
			break;
		prefix_len--;
	}
	return (prefix_len);
}

int
mask62plen(const u_char *mask)
{
	u_char bitmasks[9] = {
		0x00,
		0x80, 0xc0, 0xe0, 0xf0,
		0xf8, 0xfc, 0xfe, 0xff
	};
	int byte;
	int cidr_len = 0;

	for (byte = 0; byte < 16; byte++) {
		u_int bits;

		for (bits = 0; bits < (sizeof (bitmasks) / sizeof (bitmasks[0])); bits++) {
			if (mask[byte] == bitmasks[bits]) {
				cidr_len += bits;
				break;
			}
		}

		if (mask[byte] != 0xff)
			break;
	}
	return (cidr_len);
}

/*
 * Routine to print out information for text-based protocols such as FTP,
 * HTTP, SMTP, RTSP, SIP, ....
 */
#define MAX_TOKEN	128

/*
 * Fetch a token from a packet, starting at the specified index,
 * and return the length of the token.
 *
 * Returns 0 on error; yes, this is indistinguishable from an empty
 * token, but an "empty token" isn't a valid token - it just means
 * either a space character at the beginning of the line (this
 * includes a blank line) or no more tokens remaining on the line.
 */
static int
fetch_token(netdissect_options *ndo, const u_char *pptr, u_int idx, u_int len,
    u_char *tbuf, size_t tbuflen)
{
	size_t toklen = 0;

	for (; idx < len; idx++) {
		if (!ND_TTEST_1(pptr + idx)) {
			/* ran past end of captured data */
			return (0);
		}
		if (!isascii(*(pptr + idx))) {
			/* not an ASCII character */
			return (0);
		}
		if (isspace(*(pptr + idx))) {
			/* end of token */
			break;
		}
		if (!isprint(*(pptr + idx))) {
			/* not part of a command token or response code */
			return (0);
		}
		if (toklen + 2 > tbuflen) {
			/* no room for this character and terminating '\0' */
			return (0);
		}
		tbuf[toklen] = *(pptr + idx);
		toklen++;
	}
	if (toklen == 0) {
		/* no token */
		return (0);
	}
	tbuf[toklen] = '\0';

	/*
	 * Skip past any white space after the token, until we see
	 * an end-of-line (CR or LF).
	 */
	for (; idx < len; idx++) {
		if (!ND_TTEST_1(pptr + idx)) {
			/* ran past end of captured data */
			break;
		}
		if (*(pptr + idx) == '\r' || *(pptr + idx) == '\n') {
			/* end of line */
			break;
		}
		if (!isascii(*(pptr + idx)) || !isprint(*(pptr + idx))) {
			/* not a printable ASCII character */
			break;
		}
		if (!isspace(*(pptr + idx))) {
			/* beginning of next token */
			break;
		}
	}
	return (idx);
}

/*
 * Scan a buffer looking for a line ending - LF or CR-LF.
 * Return the index of the character after the line ending or 0 if
 * we encounter a non-ASCII or non-printable character or don't find
 * the line ending.
 */
static u_int
print_txt_line(netdissect_options *ndo, const char *protoname,
    const char *prefix, const u_char *pptr, u_int idx, u_int len)
{
	u_int startidx;
	u_int linelen;

	startidx = idx;
	while (idx < len) {
		ND_TCHECK_1(pptr + idx);
		if (*(pptr+idx) == '\n') {
			/*
			 * LF without CR; end of line.
			 * Skip the LF and print the line, with the
			 * exception of the LF.
			 */
			linelen = idx - startidx;
			idx++;
			goto print;
		} else if (*(pptr+idx) == '\r') {
			/* CR - any LF? */
			if ((idx+1) >= len) {
				/* not in this packet */
				return (0);
			}
			ND_TCHECK_1(pptr + idx + 1);
			if (*(pptr+idx+1) == '\n') {
				/*
				 * CR-LF; end of line.
				 * Skip the CR-LF and print the line, with
				 * the exception of the CR-LF.
				 */
				linelen = idx - startidx;
				idx += 2;
				goto print;
			}

			/*
			 * CR followed by something else; treat this
			 * as if it were binary data, and don't print
			 * it.
			 */
			return (0);
		} else if (!isascii(*(pptr+idx)) ||
		    (!isprint(*(pptr+idx)) && *(pptr+idx) != '\t')) {
			/*
			 * Not a printable ASCII character and not a tab;
			 * treat this as if it were binary data, and
			 * don't print it.
			 */
			return (0);
		}
		idx++;
	}

	/*
	 * All printable ASCII, but no line ending after that point
	 * in the buffer; treat this as if it were truncated.
	 */
trunc:
	linelen = idx - startidx;
	ND_PRINT("%s%.*s[!%s]", prefix, (int)linelen, pptr + startidx,
	    protoname);
	return (0);

print:
	ND_PRINT("%s%.*s", prefix, (int)linelen, pptr + startidx);
	return (idx);
}

void
txtproto_print(netdissect_options *ndo, const u_char *pptr, u_int len,
    const char *protoname, const char **cmds, u_int flags)
{
	u_int idx, eol;
	u_char token[MAX_TOKEN+1];
	const char *cmd;
	int print_this = 0;
	const char *pnp;

	if (cmds != NULL) {
		/*
		 * This protocol has more than just request and
		 * response lines; see whether this looks like a
		 * request or response and, if so, print it and,
		 * in verbose mode, print everything after it.
		 *
		 * This is for HTTP-like protocols, where we
		 * want to print requests and responses, but
		 * don't want to print continuations of request
		 * or response bodies in packets that don't
		 * contain the request or response line.
		 */
		idx = fetch_token(ndo, pptr, 0, len, token, sizeof(token));
		if (idx != 0) {
			/* Is this a valid request name? */
			while ((cmd = *cmds++) != NULL) {
				if (ascii_strcasecmp((const char *)token, cmd) == 0) {
					/* Yes. */
					print_this = 1;
					break;
				}
			}

			/*
			 * No - is this a valid response code (3 digits)?
			 *
			 * Is this token the response code, or is the next
			 * token the response code?
			 */
			if (flags & RESP_CODE_SECOND_TOKEN) {
				/*
				 * Next token - get it.
				 */
				idx = fetch_token(ndo, pptr, idx, len, token,
				    sizeof(token));
			}
			if (idx != 0) {
				if (isdigit(token[0]) && isdigit(token[1]) &&
				    isdigit(token[2]) && token[3] == '\0') {
					/* Yes. */
					print_this = 1;
				}
			}
		}
	} else {
		/*
		 * Either:
		 *
		 * 1) This protocol has only request and response lines
		 *    (e.g., FTP, where all the data goes over a different
		 *    connection); assume the payload is a request or
		 *    response.
		 *
		 * or
		 *
		 * 2) This protocol is just text, so that we should
		 *    always, at minimum, print the first line and,
		 *    in verbose mode, print all lines.
		 */
		print_this = 1;
	}

	/* Capitalize the protocol name */
	for (pnp = protoname; *pnp != '\0'; pnp++)
		ND_PRINT("%c", toupper((u_char)*pnp));

	if (print_this) {
		/*
		 * In non-verbose mode, just print the protocol, followed
		 * by the first line.
		 *
		 * In verbose mode, print lines as text until we run out
		 * of characters or see something that's not a
		 * printable-ASCII line.
		 */
		if (ndo->ndo_vflag) {
			/*
			 * We're going to print all the text lines in the
			 * request or response; just print the length
			 * on the first line of the output.
			 */
			ND_PRINT(", length: %u", len);
			for (idx = 0;
			    idx < len && (eol = print_txt_line(ndo, protoname, "\n\t", pptr, idx, len)) != 0;
			    idx = eol)
				;
		} else {
			/*
			 * Just print the first text line.
			 */
			print_txt_line(ndo, protoname, ": ", pptr, 0, len);
		}
	}
}

#if (defined(__i386__) || defined(_M_IX86) || defined(__X86__) || defined(__x86_64__) || defined(_M_X64)) || \
    (defined(__arm__) || defined(_M_ARM) || defined(__aarch64__)) || \
    (defined(__m68k__) && (!defined(__mc68000__) && !defined(__mc68010__))) || \
    (defined(__ppc__) || defined(__ppc64__) || defined(_M_PPC) || defined(_ARCH_PPC) || defined(_ARCH_PPC64)) || \
    (defined(__s390__) || defined(__s390x__) || defined(__zarch__)) || \
    defined(__vax__)
/*
 * The procesor natively handles unaligned loads, so just use memcpy()
 * and memcmp(), to enable those optimizations.
 *
 * XXX - are those all the x86 tests we need?
 * XXX - do we need to worry about ARMv1 through ARMv5, which didn't
 * support unaligned loads, and, if so, do we need to worry about all
 * of them, or just some of them, e.g. ARMv5?
 * XXX - are those the only 68k tests we need not to generated
 * unaligned accesses if the target is the 68000 or 68010?
 * XXX - are there any tests we don't need, because some definitions are for
 * compilers that also predefine the GCC symbols?
 * XXX - do we need to test for both 32-bit and 64-bit versions of those
 * architectures in all cases?
 */
#else
/*
 * The processor doesn't natively handle unaligned loads,
 * and the compiler might "helpfully" optimize memcpy()
 * and memcmp(), when handed pointers that would normally
 * be properly aligned, into sequences that assume proper
 * alignment.
 *
 * Do copies and compares of possibly-unaligned data by
 * calling routines that wrap memcpy() and memcmp(), to
 * prevent that optimization.
 */
void
unaligned_memcpy(void *p, const void *q, size_t l)
{
	memcpy(p, q, l);
}

/* As with memcpy(), so with memcmp(). */
int
unaligned_memcmp(const void *p, const void *q, size_t l)
{
	return (memcmp(p, q, l));
}
#endif

