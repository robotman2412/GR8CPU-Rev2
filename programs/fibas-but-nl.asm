* = $00

			load #message0		;print het eerste bericht
			store printx_msg
			load #start
			store printx_ret
			jump printx

start		load #$00			;bereid het geheugen voor
			store numx
			store numy
			load #$01
			store numz
fibs		copy A to C			;bereken het nummer
			load numy
			store numx
			load numz
			store numy
			load numx
			add numy
			store numz
			jump start, carry	;begin opnieuw als het nummer te groot is
			
			store number		;print het nummer
			load #btd
			store printx_ret
			load #message1
			store printx_msg
			load #fibs_msg1
			store btd_ret
			jump printx
			
fibs_msg1	load #fibs
			store printx_ret
			load #message2
			store printx_msg
			jump printx
			
numx		byte $00
numy		byte $00
numz		byte $00

message0	data "Fibonachi, jeej!\n\0"	;het eerste bericht, alleen aan het begin
message1	data "Het nummer is: \0"	;het tweede bericht, herhaald
message2	data "\n\0"					;het derde bericht, altijd na het tweede bericht

@include "printx.asm"					;mijn hulpprogramma om berichten uit te printen
@include "btd_includable.asm"			;mijn hulpprogramma om nummers uit te printen
