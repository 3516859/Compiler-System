	.text
	.file	"main.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	leaq	.L.str(%rip), %rdi
	leaq	4(%rsp), %rsi
	xorl	%eax, %eax
	callq	__isoc99_scanf@PLT
	leaq	.L.str.1(%rip), %rbp
	movq	%rbp, %rdi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf@PLT
	movl	$1, %ebx
	movq	%rbp, %rdi
	movl	$1, %esi
	xorl	%eax, %eax
	callq	printf@PLT
	cmpl	$2, 4(%rsp)
	jl	.LBB0_3
# %bb.1:
	leaq	.L.str.1(%rip), %r14
	xorl	%eax, %eax
	movl	$1, %r15d
	.p2align	4, 0x90
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	movl	%eax, %ebp
	addl	%r15d, %ebp
	movq	%r14, %rdi
	movl	%ebp, %esi
	xorl	%eax, %eax
	callq	printf@PLT
	addl	$1, %ebx
	movl	%r15d, %eax
	movl	%ebp, %r15d
	cmpl	4(%rsp), %ebx
	jl	.LBB0_2
.LBB0_3:
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
