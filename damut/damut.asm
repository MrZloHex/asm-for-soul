		global 		_start


		extern 		length
		extern 		print
		extern		clrscr
		extern		home

		section   .text
_start:		
		call		clrscr
		call		home
		mov		rax, damut_msg
		call		print
		jmp		exit_ok



exit_ok:	mov		rax, 60			; Syscall number
		mov		rdi, 0			; Exit code
		syscall

exit_err:	mov		rax, 60
		mov		rdi, 1
		syscall



		section   .bss
buf:		resb 		32

		section   .data
damut_msg:  	db		"DAMUT - DONUT in ASM", 10, 0
new_line:	db		10,0
