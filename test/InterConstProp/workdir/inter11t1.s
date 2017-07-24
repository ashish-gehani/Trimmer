	.text
	.file	"workdir/inter11t1.bc"
	.globl	branchPruned
	.align	16, 0x90
	.type	branchPruned,@function
branchPruned:                           # @branchPruned
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp2:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	(%rdi), %rax
	cmpl	$4, (%rax)
	jne	.LBB0_26
# BB#1:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$8, 4(%rax)
	jne	.LBB0_26
# BB#2:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$12, 112(%rax)
	jne	.LBB0_26
# BB#3:
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	addq	$8, %rdi
	movl	$.L.str, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB0_26
# BB#4:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movzbl	12(%rax), %eax
	cmpl	$111, %eax
	jne	.LBB0_26
# BB#5:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movzbl	17(%rax), %eax
	cmpl	$100, %eax
	jne	.LBB0_26
# BB#6:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	cmpl	$4, (%rax)
	jne	.LBB0_26
# BB#7:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	cmpl	$8, 4(%rax)
	jne	.LBB0_26
# BB#8:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	cmpl	$12, 112(%rax)
	jne	.LBB0_26
# BB#9:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdi
	addq	$8, %rdi
	movl	$.L.str, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB0_26
# BB#10:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movzbl	12(%rax), %eax
	cmpl	$111, %eax
	jne	.LBB0_26
# BB#11:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movzbl	17(%rax), %eax
	cmpl	$100, %eax
	jne	.LBB0_26
# BB#12:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpl	$4, (%rax)
	jne	.LBB0_26
# BB#13:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpl	$8, 4(%rax)
	jne	.LBB0_26
# BB#14:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpl	$12, 112(%rax)
	jne	.LBB0_26
# BB#15:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rdi
	addq	$8, %rdi
	movl	$.L.str, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB0_26
# BB#16:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzbl	12(%rax), %eax
	cmpl	$111, %eax
	jne	.LBB0_26
# BB#17:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzbl	17(%rax), %eax
	cmpl	$100, %eax
	jne	.LBB0_26
# BB#18:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	cmpl	$4, (%rax)
	jne	.LBB0_26
# BB#19:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	cmpl	$8, 4(%rax)
	jne	.LBB0_26
# BB#20:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	cmpl	$12, 112(%rax)
	jne	.LBB0_26
# BB#21:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdi
	addq	$8, %rdi
	movl	$.L.str, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB0_26
# BB#22:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzbl	12(%rax), %eax
	cmpl	$111, %eax
	jne	.LBB0_26
# BB#23:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzbl	17(%rax), %eax
	cmpl	$100, %eax
	jne	.LBB0_26
# BB#24:
	movq	-8(%rbp), %rax
	cmpq	$0, 32(%rax)
	jne	.LBB0_26
# BB#25:
	movl	$.L.str.1, %edi
	xorl	%eax, %eax
	callq	printf
.LBB0_26:
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end0:
	.size	branchPruned, .Lfunc_end0-branchPruned
	.cfi_endproc

	.globl	initialize
	.align	16, 0x90
	.type	initialize,@function
initialize:                             # @initialize
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp3:
	.cfi_def_cfa_offset 16
.Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp5:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Ltmp6:
	.cfi_offset %rbx, -24
	movq	%rdi, -16(%rbp)
	movl	$140, %edi
	callq	malloc
	movq	-16(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	$4, (%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	$8, 4(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	$12, 108(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	$12, 112(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	$12, 116(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movabsq	$8245905578810697064, %rbx # imm = 0x726F576F6C6C6568
	movq	%rbx, 8(%rax)
	movb	$0, 18(%rax)
	movw	$25708, 16(%rax)        # imm = 0x646C
	movl	$140, %edi
	callq	malloc
	movq	-16(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movl	$4, (%rax)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movl	$8, 4(%rax)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movl	$12, 108(%rax)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movl	$12, 112(%rax)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movl	$12, 116(%rax)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rbx, 8(%rax)
	movb	$0, 18(%rax)
	movw	$25708, 16(%rax)        # imm = 0x646C
	movl	$140, %edi
	callq	malloc
	movq	-16(%rbp), %rcx
	movq	%rax, 16(%rcx)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movl	$4, (%rax)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movl	$8, 4(%rax)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movl	$12, 108(%rax)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movl	$12, 112(%rax)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movl	$12, 116(%rax)
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rbx, 8(%rax)
	movb	$0, 18(%rax)
	movw	$25708, 16(%rax)        # imm = 0x646C
	movl	$140, %edi
	callq	malloc
	movq	-16(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	movl	$4, (%rax)
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	movl	$8, 4(%rax)
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	movl	$12, 108(%rax)
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	movl	$12, 112(%rax)
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	movl	$12, 116(%rax)
	movq	-16(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rbx, 8(%rax)
	movb	$0, 18(%rax)
	movw	$25708, 16(%rax)        # imm = 0x646C
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end1:
	.size	initialize, .Lfunc_end1-initialize
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp7:
	.cfi_def_cfa_offset 16
.Ltmp8:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp9:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$40, %edi
	callq	malloc
	movq	%rax, -16(%rbp)
	movq	%rax, %rdi
	callq	initialize
	movq	-16(%rbp), %rdi
	callq	branchPruned
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"helloWorld"
	.size	.L.str, 11

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"*** Branch Taken \n"
	.size	.L.str.1, 19

	.type	.L.str.2,@object        # @.str.2
	.section	.rodata,"a",@progbits
.L.str.2:
	.asciz	"helloWorld\000"
	.size	.L.str.2, 12


	.ident	"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"
	.section	".note.GNU-stack","",@progbits
