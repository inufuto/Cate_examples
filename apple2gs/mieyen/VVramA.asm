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
			lda <VVramPtr_x
			and #$00ff
			sta <ZW0

			lda <VVramPtr_y
			and #$00ff
			asl a ;*2
			asl a ;*4
			asl a ;*8
			asl a ;*16
			asl a ;*32
			clc|adc <ZW0
			clc|adc #VVram_
			sta <VVramPtr_return
		pla
    plp
rts


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
VPut_pVVram equ @zp+0
VPut_c equ @zp+2
VPut_return equ @zp+0
cseg
VPut_: public VPut_
	php
		rep #$20 | a16
		pha | phx
			sep #$20 | a8
			ldx <VPut_pVVram
			lda <VPut_c
			sta >0,x
			inx
			stx <VPut_return
		rep #$20 | a16
		plx | pla
	plp
rts
