		extern 		print
		extern 		length
		extern 		is_alpha
		global 		_start

		section 	.text
usage:		mov 		rax, help_msg
		call 		print
		ret

count_vars: 	push 		rbx
		push 		rcx
		mov 		rbx, 0
		mov 		rcx, 0
		mov 	BYTE 	bl, [rax+rcx]
		push 		rax
		mov 		rax, rbx
		call 		is_alpha
		cmp 		rax, 1
_cnt_vars_ex:
		pop 		rcx
		pop 		rbx
		ret

prcss_expr:	push 		rax
		call 		count_vars
		pop 		rax
		ret

_start:		pop		rax
		cmp		rax, 2
		jge		_get_args
		call		usage
		jmp		exit_err
_get_args:	pop		rdx
		mov		r8, rax
		mov		r9, 1
_arg_loop:	cmp		r8, r9
		je		_arg_lp_ex
		pop		rax
		push		rax
		call		prcss_expr
		mov		rbx, rax
		pop		rax
		call		print
		inc		r9
		jmp		_arg_loop
_arg_lp_ex:	jmp		exit_ok
		jmp 		exit_ok

exit_ok:	mov		rax, 60			; Syscall number
		mov		rdi, 0			; Exit code
		syscall

exit_err:	mov		rax, 60
		mov		rdi, 1
		syscall





		section 	.bss
q_vars:		resb		1

		section 	.data
pre_input_msg: 	db		"Input logical expression: ", 0
help_msg: 	db 		"ERROR: no provided expresseion", 10, "EXAMPLE: clever A^B&C", 10, 0
