* = $00
		dec num
		copy A to C
		halt
num		data 70


;		load #03
;		store divider
;		load #27
;		store remainder
;		load #end
;		store div_ret
;		jump divide
;end		load remainder
;		copy A to C
;		halt

;@include "divide8bit.asm"