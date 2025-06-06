include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Ground_

pVVram equ ZW0
pLower equ ZW1

Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        ldx #(VVramHeight-2)/2
        do
            lda #Char_Space
            ldy #0
            do
                sta (<pVVram),y | iny
                cpy #VVramWidth*2
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth*2 | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            dex
        while ne | wend

        lda <pVVram | clc|adc #VVramWidth | sta <pLower
        lda <pVVram+1 | adc #0 | sta <pLower+1
        ldy #0
        do
            lda Ground_,y
            tax
            and #Ground_BombMask
            if ne
                lsr a | lsr a
                adc #Char_BlockC-1
                jmp DrawBackground_write
            endif
            txa
            and #Ground_BlockMask
            if ne
                adc #Char_BlockA-1
                DrawBackground_write:
                sta (<pVVram),y
                adc #2
                sta (<pLower),y
            else
                lda #Char_Space
                sta (<pVVram),y
                sta (<pLower),y
            endif
            iny
            cpy #VVramWidth
        while ne | wend
    pla
rts