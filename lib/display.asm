		global 		clrscr
		global		home

		extern 		print


		section 	.text
		
clrscr:		mov		rax, clear_cmd
		call		print
		ret

home:		mov		rax, home_cmd
		call		print
		ret

		section		.data
clear_cmd:	db		0x1B, "[2J", 0
home_cmd:	db		0x1B, "[H" , 0

