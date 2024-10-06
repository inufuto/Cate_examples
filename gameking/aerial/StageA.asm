include "ZeroPage.inc"

ext GroundBits_

GroundBitsWidth equ 7

prevByte equ ZB0
yCount equ ZB1
xCount equ ZB2
lowByte equ ZB3


; void ShiftGround();
cseg
ShiftGround_: public ShiftGround_
    pha
        ldx #GroundBitsWidth
        lda #6 | sta <yCount
        do
            lda #0 | sta <prevByte 
            lda #GroundBitsWidth | sta <xCount
            do
                lda #0 | sta <lowByte
                dex | lda GroundBits_,x
                lsr a | ror <lowByte
                lsr a | ror <lowByte
                ora <prevByte
                sta GroundBits_,x
                lda <lowByte | sta <prevByte

                dec <xCount
            while ne | wend
            txa | clc|adc #GroundBitsWidth*2 | tax

            dec <yCount
        while ne | wend
    pla
rts
