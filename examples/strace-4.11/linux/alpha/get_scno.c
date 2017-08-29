/* Return codes: 1 - ok, 0 - ignore, other - error. */
static int
arch_get_scno(struct tcb *tcp)
{
	long scno = 0;

	if (upeek(tcp->pid, REG_A3, &alpha_a3) < 0)
		return -1;
	if (upeek(tcp->pid, REG_R0, &scno) < 0)
		return -1;

	/*
	 * Do some sanity checks to figure out if it's
	 * really a syscall entry
	 */
	if (!SCNO_IN_RANGE(scno)) {
		if (alpha_a3 == 0 || alpha_a3 == -1) {
			if (debug_flag)
				error_msg("stray syscall exit: r0 = %ld", scno);
			return 0;
		}
	}

	tcp->scno = scno;
	return 1;
}
