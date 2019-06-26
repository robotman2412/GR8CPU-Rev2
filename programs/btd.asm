* = $00

			load #bcd
			store printx_ret
			load #message0
			store printx_msg
			jump printx
;			jump bcd

asc_start	data $30
number 		data $00
hundreds	data $00
tens		data $00

message0	data "Doing binary to decimal stuff...\n\0"
message1	data "The number is \0"
message2	data "!\n\0"

printx		;print a null-terminated String
printx_msg = printx + 1
			load $00
			comp #$00
printx_jmp	jump $00, A = B
printx_ret = printx_jmp + 1
			copy A to D
			inc printx_msg
			jump printx

bcd			;prep stuff
			load #$00
			store hundreds
			store tens
			copy D to A
			store number
			
bcd_loop	;compare hundreds
			load number
			comp #100
			jump bcd_loop1, A < B
			
			;do hundreds
			sub #100
			store number
			inc hundreds
			jump bcd_loop
			
bcd_loop1	;compare tens
			comp #10
			jump bcd_end, A < B
			
			;do tens
			sub #10
			store number
			inc tens
			jump bcd_loop
			
bcd_end		;end the program and display number
			load #bcd_end0
			store printx_ret
			load #message1
			store printx_msg
			jump printx
			
bcd_end0	load hundreds
			comp #$01
			jump bcd_end1, A < B
			add asc_start
			copy A to D
			jump bcd_end2
			
bcd_end1	load tens
			comp #$01
			jump bcd_end3, A < B
bcd_end2	load tens
			add asc_start
			copy A to D
			
bcd_end3	load asc_start
			add number
			copy A to D
			
			load #bcd_end4
			store printx_ret
			load #message2
			store printx_msg
			jump printx
			
bcd_end4	halt
			