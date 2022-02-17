		global 		length

		section 	.text

length:		push 		rbx
		mov		rbx, rax
_len_loop:	cmp	  	BYTE 	[rax], 0
		je		_len_exit
		inc		rax
		jmp		_len_loop
_len_exit:	sub		rax, rbx
		pop 		rbx
		ret
