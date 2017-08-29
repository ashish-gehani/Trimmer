/* Return codes: 1 - ok, 0 - ignore, other - error. */
static int
arch_get_scno(struct tcb *tcp)
{
	long scno = 0;

	switch (aarch64_io.iov_len) {
		case sizeof(aarch64_regs):
			/* We are in 64-bit mode */
			scno = aarch64_regs.regs[8];
			update_personality(tcp, 0);
			break;
		case sizeof(arm_regs):
			/* We are in 32-bit mode */
			/* Note: we don't support OABI, unlike 32-bit ARM build */
			scno = arm_regs.ARM_r7;
			scno = shuffle_scno(scno);
			update_personality(tcp, 1);
			break;
	}

	tcp->scno = scno;
	return 1;
}
