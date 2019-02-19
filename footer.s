	movl	$1, %eax		# Set up to return 1
	popq	%rbp			# Pop the stack
	.cfi_def_cfa 7, 8
	ret				# Return
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
