		global 		_start
		section 	.text
is_sorted:	push 		rcx
		push 		rdx
		push 		r8
		push 		r9
		push 		r10
		mov 		rcx, 0
		dec 		rbx
		mov 		rdx, 1
		mov 		r10, 0
_is_sr_loop:	mov 		r8, [rax+r10]
		mov 		r9, [rax+r10+8]
		cmp 		r8, r9
		jle 		_pass_is_sort
		mov 		rdx, 0		
		jmp 		_end_is_sort
_pass_is_sort:	add 		r10, 8
		inc 		rcx
		cmp 		rcx, rbx
		jl 		_is_sr_loop
_end_is_sort:	mov 		rax, rdx
		pop 		r10
		pop 		r9
		pop 		r8
		pop 		rdx
		pop 		rcx
		ret

sort:		push 		rcx
		push 		rdx
		push 		r8
		push 		r9
		push 		r10
		mov 		rcx, 0
		dec 		rbx
		mov 		rdx, 1
		mov 		r10, 0
_sort_loop:	mov 		r8, [rax+r10]
		mov 		r9, [rax+r10+8]
		cmp 		r8, r9
		jle 		_pass_sort
		mov 		[rax+r10], r9
		mov 		[rax+r10+8], r8
		jmp 		_end_sort
_pass_sort:	add 		r10, 8
		inc 		rcx
		cmp 		rcx, rbx
		jl 		_sort_loop
_end_sort:	mov 		rax, rdx
		pop 		r10
		pop 		r9
		pop 		r8
		pop 		rdx
		pop 		rcx
		ret

_start:		mov 		rax, hello_msg
		call 		print
		mov 		rax, inp_arr_msg
		call 		print
		mov 		rax, hrdcd_arr
		mov 		rbx, [arr_len]
		call 		print_array

_sort:		mov 		rax, hrdcd_arr
		mov 		rbx, [arr_len]
		call 		is_sorted
		cmp 		rax, 0
		jne 		_sort_finished
		mov 		rax, hrdcd_arr
		mov 		rbx, [arr_len]
		call 		sort
		jmp 		_sort

_sort_finished:	mov 		rax, out_arr_msg
		call 		print
		mov 		rax, hrdcd_arr
		mov 		rbx, [arr_len]
		call 		print_array
		
		jmp 		exit_ok

exit_ok:	mov		rax, 60			; Syscall number
		mov		rdi, 0			; Exit code
		syscall

exit_err:	mov		rax, 60
		mov		rdi, 1
		syscall

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

print_array:	push 		r8
		push 		r15
		push 		r14
		mov 		r14, rax
		mov 		r15, rbx
		mov 		r8, 0
_print_arr:	mov 		rax, num_str
		mov 		rbx, [r14+r8]
		call 		print_number
		push		rax
		mov		rax, space
		call		print
		pop		rax
		add		r8, 8
		dec 		r15
		cmp		r15, 0
		jne		_print_arr
		mov		rax, new_line
		call		print
		pop 		r14
		pop 		r15
		pop 		r8
		ret

print_number:	call 		num_to_str
		call 		print
		ret

print:		mov		rsi, rax		; Address of string
		call		length
		mov		rdx, rax		; Length of string
		mov		rax, 1			; Syscall number
		mov		rdi, 1			; File dscrp - STDOUT
		syscall
		ret

length:		mov		rbx, rax
_len_loop:	cmp	  BYTE 	[rax], 0
		je		_len_exit
		inc		rax
		jmp		_len_loop
_len_exit:	sub		rax, rbx
		ret

		section 	.bss
num_str:	resb		4

		section 	.data
hello_msg:  	db		"Hello at BOOBle sort in assembly", 10, 0
inp_arr_msg:	db 		"Input array: ", 0
out_arr_msg:	db 		"Sorted array: ", 0
space:		db 		' ', 0
new_line:	db		10,0
hrdcd_arr:	dq 		234123, 143223, 125554, 514562, 23411, 423850, 6781923
;hrdcd_arr: 	dq 		2, 1, 3, 4, 5, 6, 7
arr_len:	dq 		7
