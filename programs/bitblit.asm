bitblt_cnt	byte $00

bitblit		load #$08
			store bitblt_cnt
bitblt_loop	rot L, bitblt_data
bitblt_data = bitblt_loop + 1
			and #%00000001
			add #'0'
			copy A to D
			dec bitblt_cnt
			jump bitblt_loop, A = B
			