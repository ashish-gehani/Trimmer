static void
get_error(struct tcb *tcp, const bool check_errno)
{
	if (check_errno && mips_REG_A3) {
		tcp->u_rval = -1;
		tcp->u_error = mips_REG_V0;
	} else {
		tcp->u_rval = mips_REG_V0;
#ifdef LINUX_MIPSN32
		/* tcp->u_rval contains a truncated value */
		tcp->u_lrval = mips_REG_V0;
#endif
	}
}
