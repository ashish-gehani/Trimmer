	.text
	.file	"test/Test4_2.bc"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
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
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$24, %rsp
.Ltmp3:
	.cfi_offset %rbx, -40
.Ltmp4:
	.cfi_offset %r14, -32
.Ltmp5:
	.cfi_offset %r15, -24
	xorl	%r14d, %r14d
	movl	$.L.str, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	open
	movl	%eax, %ebx
	cmpl	$-1, %ebx
	je	.LBB0_1
# BB#2:
	leaq	-39(%rbp), %r15
	movl	$__unnamed_1, %esi
	movl	$10, %edx
	movq	%r15, %rdi
	callq	memcpy
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movq	$10, -16(%rax)
	movl	$.L.str2, %edi
	xorl	%eax, %eax
	movq	%r15, %rsi
	callq	printf
	movl	$.L.str3, %edi
	movl	$10, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$10, %esi
	movl	$1, %edx
	movl	%ebx, %edi
	callq	lseek
	movl	$__unnamed_1+20, %esi
	movl	$10, %edx
	movq	%r15, %rdi
	callq	memcpy
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movq	$10, -16(%rax)
	movl	$.L.str2, %edi
	xorl	%eax, %eax
	movq	%r15, %rsi
	callq	printf
	movl	$.L.str3, %edi
	movl	$10, %esi
	xorl	%eax, %eax
	callq	printf
	movl	%ebx, %edi
	callq	close
	jmp	.LBB0_3
.LBB0_1:
	movl	$.L.str1, %edi
	callq	perror
	movl	$2, %r14d
.LBB0_3:
	movl	%r14d, %eax
	leaq	-24(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"staticFile"
	.size	.L.str, 11

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	"open"
	.size	.L.str1, 5

	.type	.L.str2,@object         # @.str2
.L.str2:
	.asciz	"buffer value %s \n"
	.size	.L.str2, 18

	.type	.L.str3,@object         # @.str3
.L.str3:
	.asciz	"bytes returned %d \n"
	.size	.L.str3, 20

	.type	__unnamed_1,@object     # @0
	.section	.rodata,"a",@progbits
	.globl	__unnamed_1
	.align	16
__unnamed_1:
	.asciz	"Pakistan has lost the series to NZ due to some substandard captaincy from Azhar ali\n"
	.size	__unnamed_1, 85


	.ident	"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"
	.section	".note.GNU-stack","",@progbits
