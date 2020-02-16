
;controller format:
;xxxxccrr
;r: row
;c: colomn
;x: ignored

;field format:
;332211xx
;1 - 3 represent the piece.
;1 - 3 is the colomns
;xx is ignored
;consecutive bytes are rows
;00 is empty
;01 is player 1 piece
;10 is player 2 piece
;11 is invalid


			
			jump rst_field
			
tie_msg		data "Tie\n"
			
win_msg		data $00
			data " wins\n"
			
player		data $01
			
piece_data	data " 0x"
			
board_div	data "-+-+-\n"
			
field		data %00000000, %00000000, %00000000 ;the field data
field1 = field + 1
field2 = field + 2
moves		data $00
			
;temp		data $00 ;a temporary byte :D no longer
t1_temp		data $00
t2_temp		data $00
t3_temp		data $00
			
disp_field	load #dispf_loop
			store printx_ret
			load #$00
			store t2_temp
dispf_loop	load t2_temp
			
			load field, A
			copy A to C
			load #$03
			store t1_temp
			jump disp_col
dispc_loop	load #'|'
			copy A to D
disp_col	;halt
			shift R, C
			shift R, C
			and #%00000011
			load piece_data, A
			copy A to D
			dec t1_temp
			jump dispc_loop, A != B
			load #'\n'
			copy A to D
			inc t2_temp
			comp #$03
			load #board_div
			store printx_msg
			jump printx, A != B
			
			
win_check	load #$00
			copy A to C
			load #$ff
			store t2_temp
			load player
			comp #$01
			load #%01010100
			jump winc_0, A = B
			shift L
winc_0		store t3_temp
			
winc_loop	copy C to A
			load field, A
			comp t3_temp
			jump on_win, A = B
			and t2_temp
			store t2_temp
			inc C
			comp #$03
			jump winc_loop, A != B
			load t2_temp
			comp #$00
			jump on_win, A != B
			
winc_diag	load field1
			and #%00110000
			and t3_temp
			jump tie_check, A = B
			load field
			rot R
			rot R
			rot R
			rot R
			and field2
			and t3_temp
			jump on_win, A != B
			
tie_check	inc moves
			comp #$09
			jump on_tie, A > B
			
			
prc_invp	dec player
			xor #$01
			inc
			store player
			
prc_move	load player
			load piece_data, A
			copy A to D
			store win_msg
			load #'\n'
			copy A to D
			
prcm_inp	copy D to A ;read controller inputs, the controller used will temporarily halt the CPU
			copy A to C
			and #%10000000
			jump rst_field, A != B
			copy C to A
			and #%00000011
			dec
			store t1_temp
			shift R, C
			shift R, C
			load player
			store t3_temp
			load t1_temp
			load field, A
			store t2_temp
			
prcm_loop	shift R, t2_temp
			shift R, t2_temp
			shift L, t3_temp
			shift L, t3_temp
			dec C
			jump prcm_loop, A != B
			
			load t2_temp
			and #%00000011
			jump prcm_inp, A != B
			
			load t1_temp
			add #field
			store prcm_str
			load $00, A
			or t3_temp
prcm_str	store $00
prcm_str = prcm_str + 1
			jump disp_field
			
on_win		load #win_msg
			jump on_end
on_tie		load #tie_msg
on_end		store printx_msg
			load #rst_wait
			store printx_ret
			
printx		;print a String
			load $00
printx_msg = printx + 1
			copy A to D
			comp #'\n'
printx_jmp	jump $00, A = B
printx_ret = printx_jmp + 1
			inc printx_msg
			jump printx
			
rst_wait	copy D to A
rst_field	load #$00
			store field
			store field1
			store field2
			store moves
			jump disp_field
