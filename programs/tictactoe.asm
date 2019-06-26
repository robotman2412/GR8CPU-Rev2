
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
			
temp		data $00 ;a temporary byte :D
temp1		data $00
temp2		data $00
temp3		data $00
			
disp_field	load #dispf_loop
			store printx_ret
			load #$00
			store temp2
dispf_loop	load temp2
			load field, A
			store temp
			load #$03
			store temp1
			jump disp_col
dispc_loop	load #'|'
			copy A to D
disp_col	shift R, temp
			shift R, temp
			and #%00000011
			load piece_data, A
			copy A to D
			dec temp1
			jump dispc_loop, A != B
			load #'\n'
			copy A to D
			inc temp2
			comp #$03
			load #board_div
			store printx_msg
			jump printx, A != B
			
			
win_check	load #$00
			store temp
			load #$ff
			store temp2
			load player
			comp #$01
			load #%01010100
			jump winc_0, A = B
			shift L
winc_0		store temp3
			
winc_loop	load temp
			load field, A
			comp temp3
			jump on_win, A = B
			and temp2
			store temp2
			inc temp
			comp #$03
			jump winc_loop, A != B
			load temp2
			comp #$00
			jump on_win, A != B
			
winc_diag	load field1
			and #%00110000
			and temp3
			jump tie_check, A = B
			load field
			rot R
			rot R
			rot R
			rot R
			and field2
			and temp3
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
			store temp
			and #%00000011
			dec
			store temp1
			shift R, temp
			shift R, temp
			load player
			store temp3
			load temp1
			load field, A
			store temp2
			
prcm_loop	shift R, temp2
			shift R, temp2
			shift L, temp3
			shift L, temp3
			dec temp
			jump prcm_loop, A != B
			
			load temp2
			and #%00000011
			jump prcm_inp, A != B
			
			load temp1
			add #field
			store prcm_str
			load $00, A
			or temp3
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
