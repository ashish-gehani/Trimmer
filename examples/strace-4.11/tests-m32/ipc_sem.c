/*
 * Copyright (c) 2015 Dmitry V. Levin <ldv@altlinux.org>
 * Copyright (c) 2015 Andreas Schwab <schwab@suse.de>
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

#include <stdio.h>
#include <errno.h>
#include <sys/sem.h>

union semun {
	int              val;    /* Value for SETVAL */
	struct semid_ds *buf;    /* Buffer for IPC_STAT, IPC_SET */
	unsigned short  *array;  /* Array for GETALL, SETALL */
	struct seminfo  *__buf;  /* Buffer for IPC_INFO
				    (Linux-specific) */
};

int
main(void)
{
	int rc, id;
	union semun un;
	struct semid_ds ds;
	struct seminfo info;

	id = semget(IPC_PRIVATE, 1, 0600);
	if (id < 0)
		return 77;
	printf("semget\\(IPC_PRIVATE, 1, 0600\\) += %d\n", id);

	un.buf = &ds;
	if (semctl(id, 0, IPC_STAT, un))
		goto fail;
	printf("semctl\\(%d, 0, (IPC_64\\|)?IPC_STAT, \\[?%p\\]?\\) += 0\n",
	       id, &ds);

	un.__buf = &info;
	int max = semctl(0, 0, SEM_INFO, un);
	if (max < 0)
		goto fail;
	printf("semctl\\(0, 0, (IPC_64\\|)?SEM_INFO, \\[?%p\\]?\\) += %d\n",
	       &info, max);

	un.buf = &ds;
	rc = semctl(id, 0, SEM_STAT, un);
	if (rc != id) {
		/*
		 * In linux < v2.6.24-rc1 the first argument must be
		 * an index in the kernel's internal array.
		 */
		if (-1 != rc || EINVAL != errno)
			goto fail;
		printf("semctl\\(%d, 0, (IPC_64\\|)?SEM_STAT, \\[?%p\\]?\\)"
		       " += -1 EINVAL \\(Invalid argument\\)\n", id, &ds);
	} else {
		printf("semctl\\(%d, 0, (IPC_64\\|)?SEM_STAT, \\[?%p\\]?\\)"
		       " += %d\n", id, &ds, id);
	}

	rc = 0;
done:
	if (semctl(id, 0, IPC_RMID, 0) < 0)
		return 1;
	printf("semctl\\(%d, 0, (IPC_64\\|)?IPC_RMID, \\[?0\\]?\\) += 0\n", id);
	return rc;

fail:
	rc = 1;
	goto done;
}
