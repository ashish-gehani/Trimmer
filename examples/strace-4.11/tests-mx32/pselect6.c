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

/*
 * Based on test by Dr. David Alan Gilbert <dave@treblig.org>
 */
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/select.h>
#include <sys/syscall.h>
#include <sys/time.h>

#ifdef __NR_pselect6

#ifndef NSIG
# warning NSIG is not defined, using 32
# define NSIG 32
#endif

static fd_set set[3][0x1000000 / sizeof(fd_set)];

static void
handler(int signo)
{
}

int main(int ac, char **av)
{
	int fds[2];
	struct {
		struct timespec ts;
		int pad[2];
	} tm_in = {
		.ts = { .tv_sec = 0xc0de1, .tv_nsec = 0xc0de2 },
		.pad = { 0xdeadbeef, 0xbadc0ded }
	}, tm = tm_in;
	sigset_t mask;
	const struct sigaction act = { .sa_handler = handler };
	const struct itimerval itv = { .it_value.tv_usec = 111111 };

	sigemptyset(&mask);
	sigaddset(&mask, SIGHUP);
	sigaddset(&mask, SIGCHLD);

	if (pipe(fds))
		return 77;

	/*
	 * Start with a nice simple pselect.
	 */
	FD_SET(fds[0], set[0]);
	FD_SET(fds[1], set[0]);
	FD_SET(fds[0], set[1]);
	FD_SET(fds[1], set[1]);
	FD_SET(1, set[2]);
	FD_SET(2, set[2]);
	if (pselect(fds[1] + 1, set[0], set[1], set[2], NULL, NULL) != 1)
		return 77;
	printf("pselect6(%d, [%d %d], [%d %d], [1 2], NULL, {NULL, %u}) "
	       "= 1 (out [%d])\n",
	       fds[1] + 1, fds[0], fds[1],
	       fds[0], fds[1],
	       NSIG / 8, fds[1]);

	/*
	 * Another simple one, with a timeout.
	 */
	FD_SET(1, set[1]);
	FD_SET(2, set[1]);
	FD_SET(fds[0], set[1]);
	FD_SET(fds[1], set[1]);
	if (syscall(__NR_pselect6, fds[1] + 1, NULL, set[1], NULL, &tm.ts, NULL) != 3)
		return 77;
	printf("pselect6(%d, NULL, [1 2 %d %d], NULL, {%lld, %lld}, NULL)"
	       " = 3 (out [1 2 %d], left {%lld, %lld})\n",
	       fds[1] + 1, fds[0], fds[1],
	       (long long) tm_in.ts.tv_sec, (long long) tm_in.ts.tv_nsec,
	       fds[1],
	       (long long) tm.ts.tv_sec, (long long) tm.ts.tv_nsec);

	/*
	 * Now the crash case that trinity found, negative nfds
	 * but with a pointer to a large chunk of valid memory.
	 */
	FD_ZERO(set[0]);
	FD_SET(fds[1],set[0]);
	if (pselect(-1, NULL, set[0], NULL, NULL, &mask) != -1)
		return 77;
	printf("pselect6(-1, NULL, %p, NULL, NULL, {[HUP CHLD], %u}) "
	       "= -1 EINVAL (Invalid argument)\n", set[0], NSIG / 8);

	/*
	 * Another variant, with nfds exceeding FD_SETSIZE limit.
	 */
	FD_ZERO(set[0]);
	FD_SET(fds[0],set[0]);
	FD_ZERO(set[1]);
	tm.ts.tv_sec = 0;
	tm.ts.tv_nsec = 123;
	if (pselect(FD_SETSIZE + 1, set[0], set[1], NULL, &tm.ts, &mask) != 0)
		return 77;
	printf("pselect6(%d, [%d], [], NULL, {0, 123}, {[HUP CHLD], %u}) "
	       "= 0 (Timeout)\n", FD_SETSIZE + 1, fds[0], NSIG / 8);

	/*
	 * See how timeouts are decoded.
	 */
	if (sigaction(SIGALRM, &act, NULL) != 0)
		return 77;
	if (setitimer(ITIMER_REAL, &itv, NULL) != 0)
		return 77;

	tm.ts.tv_nsec = 222222222;
	if (pselect(0, NULL, NULL, NULL, &tm.ts, &mask) != -1)
		return 77;
	puts("pselect6(0, NULL, NULL, NULL, {0, 222222222}, {[HUP CHLD], 8})"
	     " = ? ERESTARTNOHAND (To be restarted if no handler)");
	puts("--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---");

	puts("+++ exited with 0 +++");
	return 0;
}

#else

int
main(void)
{
	return 77;
}

#endif
