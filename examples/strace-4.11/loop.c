/*
 * Copyright (c) 2012 The Chromium OS Authors.
 * Written by Mike Frysinger <vapier@gentoo.org>.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "defs.h"
#include <linux/ioctl.h>
#include <linux/loop.h>

#include "xlat/loop_flags_options.h"
#include "xlat/loop_crypt_type_options.h"

static void
decode_loop_info(struct tcb *tcp, const long addr)
{
	struct loop_info info;

	tprints(", ");
	if (umove_or_printaddr(tcp, addr, &info))
		return;

	tprintf("{number=%d", info.lo_number);

	if (!abbrev(tcp)) {
		tprintf(", device=%#lx, inode=%lu, rdevice=%#lx",
			(unsigned long) info.lo_device,
			info.lo_inode,
			(unsigned long) info.lo_rdevice);
	}

	tprintf(", offset=%#x", info.lo_offset);

	if (!abbrev(tcp) || info.lo_encrypt_type != LO_CRYPT_NONE) {
		tprints(", encrypt_type=");
		printxval(loop_crypt_type_options, info.lo_encrypt_type,
			"LO_CRYPT_???");
		tprintf(", encrypt_key_size=%d", info.lo_encrypt_key_size);
	}

	tprints(", flags=");
	printflags(loop_flags_options, info.lo_flags, "LO_FLAGS_???");

	tprints(", name=");
	print_quoted_string(info.lo_name, LO_NAME_SIZE,
			    QUOTE_0_TERMINATED);

	if (!abbrev(tcp) || info.lo_encrypt_type != LO_CRYPT_NONE) {
		tprints(", encrypt_key=");
		print_quoted_string((void *) info.lo_encrypt_key,
				    LO_KEY_SIZE, 0);
	}

	if (!abbrev(tcp))
		tprintf(", init={%#lx, %#lx}"
			", reserved={%#x, %#x, %#x, %#x}}",
			info.lo_init[0], info.lo_init[1],
			info.reserved[0], info.reserved[1],
			info.reserved[2], info.reserved[3]);
	else
		tprints(", ...}");
}

static void
decode_loop_info64(struct tcb *tcp, const long addr)
{
	struct loop_info64 info64;

	tprints(", ");
	if (umove_or_printaddr(tcp, addr, &info64))
		return;

	if (!abbrev(tcp)) {
		tprintf("{device=%" PRIu64 ", inode=%" PRIu64 ", "
			"rdevice=%" PRIu64 ", offset=%#" PRIx64 ", "
			"sizelimit=%" PRIu64 ", number=%" PRIu32,
			(uint64_t) info64.lo_device,
			(uint64_t) info64.lo_inode,
			(uint64_t) info64.lo_rdevice,
			(uint64_t) info64.lo_offset,
			(uint64_t) info64.lo_sizelimit,
			(uint32_t) info64.lo_number);
	} else {
		tprintf("{offset=%#" PRIx64 ", number=%" PRIu32,
			(uint64_t) info64.lo_offset,
			(uint32_t) info64.lo_number);
	}

	if (!abbrev(tcp) || info64.lo_encrypt_type != LO_CRYPT_NONE) {
		tprints(", encrypt_type=");
		printxval(loop_crypt_type_options, info64.lo_encrypt_type,
			"LO_CRYPT_???");
		tprintf(", encrypt_key_size=%" PRIu32,
			info64.lo_encrypt_key_size);
	}

	tprints(", flags=");
	printflags(loop_flags_options, info64.lo_flags, "LO_FLAGS_???");

	tprints(", file_name=");
	print_quoted_string((void *) info64.lo_file_name,
			    LO_NAME_SIZE, QUOTE_0_TERMINATED);

	if (!abbrev(tcp) || info64.lo_encrypt_type != LO_CRYPT_NONE) {
		tprints(", crypt_name=");
		print_quoted_string((void *) info64.lo_crypt_name,
				    LO_NAME_SIZE, QUOTE_0_TERMINATED);
		tprints(", encrypt_key=");
		print_quoted_string((void *) info64.lo_encrypt_key,
				    LO_KEY_SIZE, 0);
	}

	if (!abbrev(tcp))
		tprintf(", init={%#" PRIx64 ", %#" PRIx64 "}}",
			(uint64_t) info64.lo_init[0],
			(uint64_t) info64.lo_init[1]);
	else
		tprints(", ...}");
}

int
loop_ioctl(struct tcb *tcp, const unsigned int code, long arg)
{
	if (!verbose(tcp))
		return RVAL_DECODED;

	switch (code) {
	case LOOP_SET_STATUS:
		decode_loop_info(tcp, arg);
		break;

	case LOOP_GET_STATUS:
		if (entering(tcp))
			return 0;
		decode_loop_info(tcp, arg);
		break;

	case LOOP_SET_STATUS64:
		decode_loop_info64(tcp, arg);
		break;

	case LOOP_GET_STATUS64:
		if (entering(tcp))
			return 0;
		decode_loop_info64(tcp, arg);
		break;

	case LOOP_CLR_FD:
#ifdef LOOP_SET_CAPACITY
	case LOOP_SET_CAPACITY:
#endif
#ifdef LOOP_CTL_GET_FREE
	/* newer loop-control stuff */
	case LOOP_CTL_GET_FREE:
#endif
		/* Takes no arguments */
		break;

	case LOOP_SET_FD:
	case LOOP_CHANGE_FD:
		tprints(", ");
		printfd(tcp, arg);
		break;

#ifdef LOOP_CTL_ADD
	/* newer loop-control stuff */
	case LOOP_CTL_ADD:
	case LOOP_CTL_REMOVE:
		tprintf(", %d", (int) arg);
		break;
#endif

	default:
		return RVAL_DECODED;
	}

	return RVAL_DECODED | 1;
}
