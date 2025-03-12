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
