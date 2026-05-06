include "ZeroPage.inc"

include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
VVramPtr_x equ @zp+0
VVramPtr_y equ @zp+2
VVramPtr_return equ @zp+0
cseg
VVramPtr_: public VVramPtr_
    php
        rep #$20 | a16
		pha
			lda VVramPtr_x
			and #$00ff
			sta ZW0

			lda VVramPtr_y
			and #$00ff
			asl a ;*2
			asl a ;*4
			asl a ;*8
			asl a ;*16
			asl a ;*32
			clc|adc ZW0
			clc|adc #VVram_
			sta VVramPtr_return
		pla
    plp
rts
