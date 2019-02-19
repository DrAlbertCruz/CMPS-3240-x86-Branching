	.file	"main.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp			# Set up the stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp		# Adjust base and stack pointers
	.cfi_def_cfa_register 6
mulsd %xmm0, %xmm1
	movl	$1, %eax		# Set up to return 1
	popq	%rbp			# Pop the stack
	.cfi_def_cfa 7, 8
	ret				# Return
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
