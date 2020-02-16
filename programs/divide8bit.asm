remainder	data $00
divider		data $00
result		data $00

max			data $00

divide		load #$00
			store result
			store max
			
maxfl		inc max
			rot L, divider
			jump maxfl, !carry
			rot R, divider
			jump sdivl
			
divl		shift R, divider
			shift L, result
sdivl		load remainder
			comp divider
			jump mdiv0, A < B
			sub divider
			store remainder
			inc result
mdiv0		dec max
			comp #0
			jump divl, A > B
div_mret	jump $00
div_ret = div_mret + 1
