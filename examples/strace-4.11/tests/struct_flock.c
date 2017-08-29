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

#include <errno.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include "flock.h"

#define FILE_LEN 4096
#define EINVAL_STR "-1 EINVAL (Invalid argument)"

# define TEST_SYSCALL_STR stringify(TEST_SYSCALL_NAME)
# define stringify(arg) stringify_(arg)
# define stringify_(arg) #arg

#define TEST_SYSCALL_NR nrify(TEST_SYSCALL_NAME)
#define nrify(arg) nrify_(arg)
#define nrify_(arg) __NR_ ## arg

#define TEST_FLOCK_EINVAL(cmd) test_flock_einval(cmd, #cmd)

static void
test_flock_einval(const int cmd, const char *name)
{
	struct_kernel_flock fl = {
		.l_type = F_RDLCK,
		.l_start = (off_t) 0xdefaced1facefeed,
		.l_len = (off_t) 0xdefaced2cafef00d
	};
	syscall(TEST_SYSCALL_NR, 0, cmd, &fl);
	printf("%s(0, %s, {l_type=F_RDLCK, l_whence=SEEK_SET"
	       ", l_start=%jd, l_len=%jd}) = %s\n", TEST_SYSCALL_STR, name,
	       (intmax_t) fl.l_start, (intmax_t) fl.l_len, EINVAL_STR);
}

static void
test_flock(void)
{
	TEST_FLOCK_EINVAL(F_SETLK);
	TEST_FLOCK_EINVAL(F_SETLKW);

	struct_kernel_flock fl = {
		.l_type = F_RDLCK,
		.l_len = FILE_LEN
	};
	int rc = syscall(TEST_SYSCALL_NR, 0, F_SETLK, &fl);
	printf("%s(0, F_SETLK, {l_type=F_RDLCK, l_whence=SEEK_SET"
	       ", l_start=0, l_len=%d}) = %s\n",
	       TEST_SYSCALL_STR, FILE_LEN, rc ? EINVAL_STR : "0");
	if (rc)
		return;

	syscall(TEST_SYSCALL_NR, 0, F_GETLK, &fl);
	printf("%s(0, F_GETLK, {l_type=F_UNLCK, l_whence=SEEK_SET"
	       ", l_start=0, l_len=%d, l_pid=0}) = 0\n",
	       TEST_SYSCALL_STR, FILE_LEN);

	syscall(TEST_SYSCALL_NR, 0, F_SETLK, &fl);
	printf("%s(0, F_SETLK, {l_type=F_UNLCK, l_whence=SEEK_SET"
	       ", l_start=0, l_len=%d}) = 0\n",
	       TEST_SYSCALL_STR, FILE_LEN);
}

static int
create_sample(void)
{
	char fname[] = TEST_SYSCALL_STR "_XXXXXX";

	(void) close(0);
	return mkstemp(fname) || unlink(fname) || ftruncate(0, FILE_LEN) ? 77 : 0;
}
