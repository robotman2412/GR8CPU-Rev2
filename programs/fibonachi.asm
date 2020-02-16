start	load #$00
		store numx
		store numy
		inc
		store numz
fibs	copy A to C
		load numy
		store numx
		load numz
		store numy
		load numx
		add numy
		store numz
		jump fibs, !carry
		jump start

numx	data $00
numy	data $00
numz	data $00
