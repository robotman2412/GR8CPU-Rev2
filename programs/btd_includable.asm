
asc_start	data $30
number 		data $00
hundreds	data $00
tens		data $00

btd			;prep stuff
			load #$00
			store hundreds
			store tens
			
btd_loop	;compare hundreds
			load number
			comp #100
			jump btd_loop1, A < B
			
			;do hundreds
			sub #100
			store number
			inc hundreds
			jump btd_loop
			
btd_loop1	;compare tens
			comp #10
			jump btd_end, A < B
			
			;do tens
			sub #10
			store number
			inc tens
			jump btd_loop
			
btd_end		;end the program and display number
			load hundreds
			comp #$01
			jump btd_end1, A < B
			add asc_start
			copy A to D
			jump btd_end2
			
btd_end1	load tens
			comp #$01
			jump btd_end3, A < B
btd_end2	load tens
			add asc_start
			copy A to D
			
btd_end3	load asc_start
			add number
			copy A to D
			
btd_jmp		jump $00
btd_ret = btd_jmp + 1
			