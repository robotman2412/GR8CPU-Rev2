		load #$01		;$02 $01
		store numz		;$22 $22
fibs	load numy		;$01 $21
		store numx		;$22 $20
		load numz		;$01 $22
		store numy		;$22 $21
		load numx		;$01 $20
		add numy		;$07 $21
		store numz		;$22 $22
		copy A, C		;$03
		jump fibs, NCA	;$19 $04
		halt			;$3f


numx = $20
numy = $21
numz = $22
