/*
 * Copyright (c) 2003, 2004 Ulrich Drepper <drepper@redhat.com>
 * Copyright (c) 2005-2015 Dmitry V. Levin <ldv@altlinux.org>
 * All rights reserved.
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

#include DEF_MPERS_TYPE(struct_sigevent)

#include <signal.h>
typedef struct sigevent struct_sigevent;

#include MPERS_DEFS

#include "xlat/sigev_value.h"

MPERS_PRINTER_DECL(void, print_sigevent)(struct tcb *tcp, const long addr)
{
	struct_sigevent sev;

	if (umove_or_printaddr(tcp, addr, &sev))
		return;

	tprints("{");
	if (sev.sigev_value.sival_ptr)
		tprintf("sigev_value={int=%d, ptr=%#lx}, ",
			sev.sigev_value.sival_int,
			(unsigned long) sev.sigev_value.sival_ptr);

	tprints("sigev_signo=");
	switch (sev.sigev_notify) {
	case SIGEV_SIGNAL:
	case SIGEV_THREAD:
	case SIGEV_THREAD_ID:
		tprints(signame(sev.sigev_signo));
		break;
	default:
		tprintf("%u", sev.sigev_signo);
	}

	tprints(", sigev_notify=");
	printxval(sigev_value, sev.sigev_notify, "SIGEV_???");

	switch (sev.sigev_notify) {
	case SIGEV_THREAD_ID:
#ifndef sigev_notify_thread_id
		/*
		 * _pad[0] is the _tid field which might not be
		 * present in the userlevel definition of the struct.
		 */
# if defined HAVE_STRUCT_SIGEVENT__SIGEV_UN__PAD
#  define sigev_notify_thread_id _sigev_un._pad[0]
# elif defined HAVE_STRUCT_SIGEVENT___PAD
#  define sigev_notify_thread_id __pad[0]
# endif
#endif

#ifdef sigev_notify_thread_id
		tprintf(", sigev_notify_thread_id=%d",
			sev.sigev_notify_thread_id);
#else
# warning unfamiliar struct sigevent => incomplete SIGEV_THREAD_ID decoding
#endif
		break;
	case SIGEV_THREAD:
		tprints(", sigev_notify_function=");
		printaddr((unsigned long) sev.sigev_notify_function);
		tprints(", sigev_notify_attributes=");
		printaddr((unsigned long) sev.sigev_notify_attributes);
		break;
	}
	tprints("}");
}
