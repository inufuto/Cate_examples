include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext FortDotOffset_
ext VVram_

scope
pVVram equ ZW0
yPos equ ZB0
char equ ZB1
yCount equ ZB2
; void DrawFort(byte x, byte y);
dseg
DrawFort_@Param1: public DrawFort_@Param1
DrawFort_y:
    defb 0
cseg
DrawFort_: public DrawFort_
    pha
        lda DrawFort_y
        clc|adc #8 | sta yPos
        stz pVVram+1
        asl a | rol pVVram+1 ;*2
        asl a | rol pVVram+1 ;*4
        adc yPos | if cs | inc pVVram+1 | endif ;*5
        asl a | rol pVVram+1 ;*10
        asl a | rol pVVram+1 ;*20
        sta pVVram
        tya ;x
        clc|adc pVVram | sta pVVram
        if cs | inc pVVram+1 | endif
        lda pVVram | clc|adc #low (VVram_-VVramWidth*8) | sta pVVram
        lda pVVram+1 | adc #high (VVram_-VVramWidth*8) | sta pVVram+1

        lda DrawFort_y | sta yPos

        lda FortDotOffset_
        if eq
            lda #Char_Fort0
            ldx #6
        else
            lda #Char_Fort1
            ldx #7
        endif
        sta char

        stx yCount
        do
            lda yPos
            cmp #VVramHeight
            if cc
                lda char
                ldy #0
                do
                    sta (pVVram),y | iny
                    inc a
                    cpy #6
                while ne | wend
                sta char
            else
                lda char
                clc|adc #6
                sta char
            endif
            lda pVVram | clc|adc #VVramWidth | sta pVVram
            if cs | inc pVVram+1 | endif
            inc yPos
        dec yCount | while ne | wend
    pla
rts
endscope
