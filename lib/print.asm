		global 		print
		extern 		length

		section 	.text
		
print:		push 		rsi
		push 		rdx
		push 		rdi
		mov		rsi, rax		; Address of string
		call		length
		mov		rdx, rax		; Length of string
		mov		rax, 1			; Syscall number
		mov		rdi, 1			; File dscrp - STDOUT
		syscall
		pop 		rdi
		pop 		rdx
		pop 		rsi
		ret
