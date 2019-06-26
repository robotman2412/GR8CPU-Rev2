printx		;print a null-terminated String
			load $00
printx_msg = printx + 1
			comp #$00
printx_jmp	jump $00, A = B
printx_ret = printx_jmp + 1
			copy A to D
			inc printx_msg
			jump printx