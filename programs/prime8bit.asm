
			load #mdiv1
			store div_ret
			load #btd
			store printx_ret
			load #mprime1
			store btd_ret
			
start		load #$03
			store prime
			jump primeprint
			
primeloop	load prime
			sub #2
			store divider
			load #3
			store divmin
			
divloop		load prime
			store remainder
			copy A to C
			jump divide
			
mdiv1		load remainder
			comp #$00
			jump mprime2, A = B
			dec divider
			dec divider
			comp divmin
			jump divloop, A >= B
primeprint	load prime
			store number
			load #msg
			store printx_msg
			jump printx
			
mprime1		load #'\n'
			copy A to D
			
mprime2		inc prime
			jump end, carry
			inc prime
			jump primeloop, !carry
end			halt

@include "btd_includable.asm"
@include "printx.asm"
@include "divide8bit.asm"

msg		data "Prime: \0"
prime	data $00
divmin	data $00
