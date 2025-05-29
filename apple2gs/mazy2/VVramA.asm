include "ZeroPage.inc"

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
