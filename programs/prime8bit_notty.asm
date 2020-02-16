
			load #mdiv1
			store div_ret
			
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
			jump divide
			
mdiv1		load remainder
			comp #$00
			jump mprime, A = B
			dec divider
			dec divider
			comp divmin
			jump divloop, A >= B
			
primeprint	load prime
			copy A to C
			jump mprime
			
mprime		inc prime
			jump end, carry
			inc prime
			jump primeloop, !carry
end			halt

@include "divide8bit.asm"

prime	data $00
divmin	data $00
