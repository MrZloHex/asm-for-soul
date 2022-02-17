		global 		div_by_10
		global 		modulo
		section 	.text
div_by_10:	push 		r8
		push 		r9
		mov 		r8, rax
		shr 		r8, 1
		mov 		r9, rax
		shr 		r9, 2
		add 		r8, r9
		mov 		r10, r8
		shr 		r8, 4
		add 		r10, r8
		mov 		r8, r10
		shr 		r8, 8
		add 		r10, r8
		mov 		r8, r10
		shr 		r8, 16
		add 		r10, r8
		shr 		r10, 3
		mov 		r8, r10
		shl 		r8, 2
		add 		r8, r10
		shl 		r8, 1
		mov 		r12, rax
		sub 		r12, r8
		cmp 		r12, 9 			; return q + (r > 9) HIGHLY RECOMEND OPTIMISE IT!!!
		jle 		_div_end
		inc 		r10 			; r10 - result of division by 10
_div_end:	mov 		rax, r10
		pop 		r8
		pop 		r9
		ret

modulo:		push 		r8
		push 		r9
		push 		rax
		call 		div_by_10
		mov 		r10, rax
		pop 		rax
		mov 		r8, r10
		shl 		r8, 3
		shl 		r10, 1
		add 		r10, r8
		sub 		rax, r10
		pop 		r9
		pop 		r8
		ret
