include "ZeroPage.inc"
include "VVram.inc"

ext VVram_

pVVram equ ZW0
xPos equ ZB0

; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defb 0
cseg
VVramPtr_: public VVramPtr_
	pha
        sty <xPos
        lda	VVramPtr_y
        asl a | asl a | asl a  ;*8
        sta <pVVram | lda #0 | sta <pVVram+1
        asl <pVVram | rol <pVVram+1 ;16
        asl <pVVram | rol <pVVram+1 ;32
        
        lda <xPos | clc|adc <pVVram | tay
        lda <pVVram+1 | adc #0 | tax
        tya | clc|adc #low VVram_ | tay
        txa | adc #high VVram_ | tax
	pla
rts
