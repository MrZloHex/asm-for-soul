		global 		num_to_str
		global 		reverse
		extern 		length
		extern  	div_by_10
		extern 		modulo
		section 	.text
num_to_str:	push 		r8
		push 		r9
		mov 		rdx, 0
		mov 		r8, rbx
_is_val_lp:	mov 		r9, r8
		push 		rax
		mov 		rax, r9
		call 		modulo
		add 		rax, 48
		mov 		r9, rax
		pop 		rax
		mov 		[rax+rdx], r9
		inc 		rdx
		push 		rax
		mov 		rax, r8
		call 		div_by_10
		mov 		r8, rax
		pop 		rax
		cmp 		r8, 0
		jne 		_is_val_lp
		mov 	BYTE	[rax+rdx], 0
		call 		reverse_str
		pop 		r9
		pop 		r8
		ret

reverse_str:	push 		rax
		push 		rbx
		push 		rcx
		push 		rdx
		mov 		rcx, rax
		call 		length
		mov 		rbx, 0
		dec 		rax
		mov 		rdx, 0
_rever_loop:	mov 		dl, BYTE [rcx+rbx]
		mov 		dh, BYTE [rcx+rax]
		mov 	BYTE 	[rcx+rbx], dh
		mov 	BYTE 	[rcx+rax], dl
		inc 		rbx
		dec 		rax
		cmp 		rbx, rax
		jl 		_rever_loop
		pop 		rdx
		pop 		rcx
		pop 		rbx
		pop 		rax
		ret
