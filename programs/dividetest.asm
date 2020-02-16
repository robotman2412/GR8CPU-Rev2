
			load #5
			store remainder
			load #2
			store divider
			load #m1
			store div_ret
			jump divide
			
m1			load #msg1
			store printx_msg
			load #m2
			store printx_ret
			jump printx
			
m2			load result
			store number
			load #m3
			store btd_ret
			jump btd
			
m3			load #msg2
			store printx_msg
			load #m4
			store printx_ret
			jump printx
			
m4			load remainder
			store number
			load #m5
			store btd_ret
			jump btd
			
m5			halt

@include "btd_includable.asm"
@include "printx.asm"
@include "divide8bit.asm"

msg1		data "Result: \0"
msg2		data "\nRemainder: "