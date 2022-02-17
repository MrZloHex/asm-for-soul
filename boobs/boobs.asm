		extern 		print
		extern 		length
		extern 		num_to_str
		extern 		reverse
		extern 		print_number
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
