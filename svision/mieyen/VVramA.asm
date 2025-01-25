include "ZeroPage.inc"
include "VVram.inc"

ext VVram_

pVVram equ ZW0

; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public	VVramPtr_@Param1
VVramPtr_y:
	defs 1
cseg
VVramPtr_: public	VVramPtr_
	pha
		sty <pVVram
		lda	VVramPtr_y
		asl a ;*2
		clc|adc VVramPtr_y ;*3
		asl a  ;*6
		stz <pVVram+1
		asl a | rol <pVVram+1 ;*12
		asl a | rol <pVVram+1 ;*24
		clc|adc <pVVram | sta <pVVram
		lda <pVVram+1 | adc #0 | sta <pVVram+1
		lda <pVVram | clc|adc #low VVram_ | tay
		lda <pVVram+1 | adc #high VVram_ | tax
	pla
rts


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
dseg
VPut_@Param1: public VPut_@Param1
VPut_c:
	defb 0
cseg
VPut_: public VPut_
    sty <pVVram | stx <pVVram+1
    ldy #0
    lda VPut_c
    sta (<pVVram),y
    ldy <pVVram
    iny
    if eq
        inx
    endif
rts
