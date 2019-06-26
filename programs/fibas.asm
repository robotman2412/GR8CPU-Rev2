* = $00

			load #message0
			store printx_msg
			load #start
			store printx_ret
			jump printx

start		load #$00
			store numx
			store numy
			load #$01
			store numz
fibs		copy A to C
			load numy
			store numx
			load numz
			store numy
			load numx
			add numy
			store numz
			jump start, carry
			
			store number
			load #btd
			store printx_ret
			load #message1
			store printx_msg
			load #fibs_msg1
			store btd_ret
			jump printx
			
fibs_msg1	load #fibs
			store printx_ret
			load #message2
			store printx_msg
			jump printx
			
numx		byte $00
numy		byte $00
numz		byte $00

message0	data "Fibonachi, yay!\n\0"
message1	data "The number is \0"
message2	data "\n\0"

@include "printx.asm"
@include "btd_includable.asm"
