include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"

ext VVram_

pVVram equ ZW0

; word VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defs 1
cseg
Table:
    defw VVramWidth*0,VVramWidth*1,VVramWidth*2,VVramWidth*3,VVramWidth*4,VVramWidth*5,VVramWidth*6,VVramWidth*7
    defw VVramWidth*8,VVramWidth*9,VVramWidth*10,VVramWidth*11,VVramWidth*12,VVramWidth*13,VVramWidth*14,VVramWidth*15
VVramPtr_: public VVramPtr_
	pha
        lda	VVramPtr_y
        asl a | tax
        lda Table,x | inx
        sta <pVVram
        lda Table,x
        sta <pVVram+1
        tya |clc|adc <pVVram | tay
        lda <pVVram+1 | adc #0 | tax
        tya | clc|adc #low VVram_ | tay
        txa | adc #high VVram_ | tax
	pla
rts


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        ldx #VVramHeight
        do
            ldy #0 | tya
            do
                sta (<pVVram),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1
            dex
        while ne | wend
    pla
rts