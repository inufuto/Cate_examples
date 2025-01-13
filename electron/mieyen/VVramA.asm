include "ZeroPage.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_

pVVram equ ZW0
pBack equ ZW0
pFront equ ZW1


; word VVramOffset(byte x, byte y);
dseg
VVramOffset_x:
	defb 0
VVramOffset_@Param1: public VVramOffset_@Param1
VVramOffset_y:
	defb 0
cseg
VVramOffset_: public VVramOffset_
	pha
        sty VVramOffset_x
        lda	VVramOffset_y
        asl a | asl a | asl a  ;*8
        sta <pVVram | lda #0 | sta <pVVram+1
        asl <pVVram | rol <pVVram+1 ;16
        asl <pVVram | rol <pVVram+1 ;32
        lda VVramOffset_x | clc|adc <pVVram | tay
        lda <pVVram+1 | adc #0 | tax
	pla
rts


; void VVramBackToFront()
cseg
VVramBackToFront_: public VVramBackToFront_
    pha
        lda #low VVramBack_ | sta <pBack
        lda #high VVramBack_ | sta <pBack+1
        
        lda #low VVramFront_ | sta <pFront
        lda #high VVramFront_ | sta <pFront+1
        
        ldx #VVramHeight
        do
            ldy #0
            do
                lda (<pBack),y
                sta (<pFront),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pBack | clc|adc #VVramWidth | sta <pBack
            lda <pBack+1 | adc #0 | sta <pBack+1

            lda <pFront | clc|adc #VVramWidth | sta <pFront
            lda <pFront+1 | adc #0 | sta <pFront+1

            dex
        while ne | wend
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
