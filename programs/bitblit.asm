
bitblit		load #$08
			store bitblt_cnt
bitblt_loop	rot L, bitblt_data
bitblt_data = bitblt_loop + 1
			and #%00000001
			add #'0'
			copy A to D
			dec bitblt_cnt
			comp #$00
			jump bitblt_loop, A > B
			load #'\n'
			halt
bitblt_mret	jump $00
bitblt_ret = bitblt_mret + 1
	
bitblt_data byte %10010110	
bitblt_cnt	byte $00
