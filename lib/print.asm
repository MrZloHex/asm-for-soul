		global 		print
		global 		print_number
		extern 		length
		extern 	 	num_to_str

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

print_number:	call 		num_to_str
		call 		print
		ret
