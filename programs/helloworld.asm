* = $00

			load #bericht		;Zet de pointer voor het bericht
			store printx_msg
			load #blit			;Zet de pointer voor waar we verder gaan
			store printx_ret
			jump printx			;Laat bericht zien
blit		halt				;Stop programma

bericht		bytes "Hallo, Wereld!\n\0"	;'\n' Is voor nieuwe regel, '\0 is voor einde bericht'

@include "printx.asm"
