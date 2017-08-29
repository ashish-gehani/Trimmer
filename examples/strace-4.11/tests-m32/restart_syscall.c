/*
 * Copyright (c) 2015 Dmitry V. Levin <ldv@altlinux.org>
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

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdio.h>
#include <stdint.h>
#include <signal.h>
#include <time.h>
#include <sys/time.h>

int
main(void)
{
#if defined __x86_64__ && defined __ILP32__
	/*
	 * x32 is broken from the beginning:
	 * https://lkml.org/lkml/2015/11/30/790
	 */
	return 77;
#else
	const sigset_t set = {};
	const struct sigaction act = { .sa_handler = SIG_IGN };
	const struct itimerval itv = { .it_value.tv_usec = 111111 };
	struct timespec req = { .tv_nsec = 222222222 }, rem;

	if (sigaction(SIGALRM, &act, NULL))
		return 77;
	if (sigprocmask(SIG_SETMASK, &set, NULL))
		return 77;
	if (setitimer(ITIMER_REAL, &itv, NULL))
		return 77;
	if (nanosleep(&req, &rem))
		return 0;

	printf("nanosleep\\(\\{%jd, %jd\\}, \\{%jd, %jd\\}\\)"
	       " = \\? ERESTART_RESTARTBLOCK \\(Interrupted by signal\\)\n",
	       (intmax_t) req.tv_sec, (intmax_t) req.tv_nsec,
	       (intmax_t) rem.tv_sec, (intmax_t) rem.tv_nsec);
	puts("--- SIGALRM \\{si_signo=SIGALRM, si_code=SI_KERNEL\\} ---");
#ifdef __arm__
/* old kernels used to overwrite ARM_r0 with -EINTR */
# define ALTERNATIVE_NANOSLEEP_REQ "0xfffffffc|"
#else
# define ALTERNATIVE_NANOSLEEP_REQ ""
#endif
	printf("(nanosleep\\((%s\\{%jd, %jd\\}), %p|restart_syscall\\(<\\.\\.\\."
	       " resuming interrupted nanosleep \\.\\.\\.>)\\) = 0\n",
	       ALTERNATIVE_NANOSLEEP_REQ,
	       (intmax_t) req.tv_sec, (intmax_t) req.tv_nsec, &rem);

	puts("\\+\\+\\+ exited with 0 \\+\\+\\+");
	return 0;
#endif
}
