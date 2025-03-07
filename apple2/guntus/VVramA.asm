include "ZeroPage.inc"
include "VVram.inc"

pVVram equ ZW0
mul2 equ ZB2

dseg
VVram_: public VVram_
    defs VVramWidth*(VVramHeight+1)


; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param0: public	VVramPtr_@Param0
VVramPtr_.x_:	defs 1
VVramPtr_@Param1: public	VVramPtr_@Param1
VVramPtr_.y_:	defs 1
cseg
VVramPtr_: public	VVramPtr_
        pha
                lda VVramPtr_.y_
                asl a ;*2
                sta <mul2
                clc|adc VVramPtr_.y_ ;*3
                asl a  ;*6
                sta <pVVram | lda #0 | sta <pVVram+1
                asl <pVVram | rol <pVVram+1 ;12
                asl <pVVram | rol <pVVram+1 ;24
                lda <pVVram | clc|adc <mul2 | sta <pVVram
                lda <pVVram+1 | adc #0 | sta <pVVram+1
                lda VVramPtr_.x_ | clc | adc <pVVram | sta <pVVram
                lda <pVVram+1 | adc #0 | sta <pVVram+1
                lda <pVVram | clc|adc #low VVram_ | tay
                lda <pVVram+1 | adc #high VVram_ | tax
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
