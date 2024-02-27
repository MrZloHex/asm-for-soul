		global 		_start


		extern 		length
		extern 		print
		extern		clrscr
		extern		home

		section   .text
_start:		
		; call		clrscr
		; call		home
		; mov		rax, damut_msg
		; call		print
		; mov		rax, illumination
		; call		print
		; mov		rax, new_line
		; call		print
render_loop:	call		render
		movaps		xmm0, [sine]
		movaps		xmm1, [cosine]
		; movaps		xmm0, [rotation_offset]
		; movaps		xmm1, [rotation_delta]
		; addps		xmm0, xmm1
		; movaps		[rotation_offset], xmm0
		; jmp		render_loop
		jmp		exit_ok

render:		call		calc_sc_ab
		; THETA LOOP
		mov		rax, theta
		mov		rbx, 8
		call		sin_cos
		; PHI LOOP
		mov		rax, phi
		mov		rbx, 12
		call		sin_cos
		
		ret

calc_sc_ab:	; Calculate sina sinb cosa cosb
		mov		rax, A
		mov		rbx, 0
		call		sin_cos
		mov		rax, B
		mov		rbx, 4
		call		sin_cos
		ret


sin_cos:	; RAX - address of var ; RBX - offset of sine and cosine var
		push		rcx
		mov		rcx, rbx
		add		rbx, sine
		add 		rcx, cosine
		fld		dword [rax]
		fsin
		fst		dword [rbx]
		fld		dword [rax]
		fcos
		fst		dword [rcx]
		pop		rcx
		ret





exit_ok:	mov		rax, 60			; Syscall number
		mov		rdi, 0			; Exit code
		syscall

exit_err:	mov		rax, 60
		mov		rdi, 1
		syscall


render_frame:	
		ret


; 		section   .bss
; sine:
; 	sinA:	resd		1
; 	sinB:	resd		1
; 	sinThe:	resd		1
; 	sinPhi:	resd		1
; cosine:
; 	cosA:	resd		1
; 	cosB:	resd		1
; 	cosThe:	resd		1
; 	cosPhi:	resd		1


		section   .data
sine:
	sinA:	dd		0
	sinB:	dd		0
	sinThe:	dd		0
	sinPhi:	dd		0
cosine:
	cosA:	dd		0
	cosB:	dd		0
	cosThe:	dd		0
	cosPhi:	dd		0

angles:
	theta:	dd		0.00
	phi:	dd		0.00
		dq		0.00
angles_delta:
	deltaT:	dd		0.01
	deltaP:	dd		0.01
		dq		0.00

rotation_offset:
	A:	dd		1.00
	B:	dd		1.00
		dq		0.00
rotation_delta:
	deltaA:	dd		1.006
	deltaB:	dd		2.004
		dq		0.00
	

damut_msg:  	db		"DAMUT - DONUT in ASM", 10, 0
illumination:	db		".,-~:;=!*#$@", 0
new_line:	db		10,0
screen:
	width:	db		80
	height: db		40

pi:		dq		3.141592653589793238462
		dq		0.00


