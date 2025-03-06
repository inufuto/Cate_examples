include "ZeroPage.inc"
include "VVram.inc"

ext VVramFront_,VVramBack_

offset equ ZW0
pBack equ ZW0
pFront equ ZW1


; word VVramOffset(byte x, byte y)
dseg
VVramOffset_@Param0: public	VVramOffset_@Param0
VVramOffset_.x_:	defs 1
VVramOffset_@Param1: public	VVramOffset_@Param1
VVramOffset_.y_:	defs 1
cseg
VVramOffset_: public	VVramOffset_
	pha
        lda	VVramOffset_.y_
        asl a | asl a | asl a  ;*8
        sta <ZW0 | lda #0 | sta <ZW0+1
        asl <ZW0 | rol <ZW0+1 ;16
        asl <ZW0 | rol <ZW0+1 ;32
        lda VVramOffset_.x_ | clc | adc <ZW0 | sta <ZW0
        lda <ZW0+1 | adc #0 | sta <ZW0+1
        ldy <ZW0 | ldx <ZW0+1
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
        ldx #VVramHeight/2
        do
            ldy #0
            do
                lda (<pBack),y
                sta (<pFront),y
                iny
                cpy #VVramWidth*2
            while ne | wend
            lda <pBack | clc | adc #low VVramWidth*2 | sta <pBack
            lda <pBack+1 | adc #high VVramWidth*2 | sta <pBack+1
            
            lda <pFront | clc | adc #low VVramWidth*2 | sta <pFront
            lda <pFront+1 | adc #high VVramWidth*2 | sta <pFront+1
            
            dex
        while ne | wend
    pla
rts
