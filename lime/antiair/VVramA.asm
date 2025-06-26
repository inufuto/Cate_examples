include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Ground_

ext @Temp@Byte
xCount equ @Temp@Byte

Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    pshs a,b,x,y
        ldy #VVram_
        ldd #0
        do
            std ,y++
            cmpy #VVram_+VVramWidth*(VVramHeight-1-2)
        while ne | wend

        ldx #Ground_
        lda #VVramWidth | sta <xCount
        do
            ldb ,x+
            tfr b,a | anda #Ground_BombMask
            if ne
                lsra | lsra
                deca
                adda #Char_BlockC
                bra DrawBackground_write
            endif
            tfr b,a | anda #Ground_BlockMask
            if ne
                deca
                adda #Char_BlockA
                DrawBackground_write:
                sta ,y
                inca | inca
                sta VVramWidth,y
            else
                clr ,y
                clr VVramWidth,y
            endif
            leay 1,y
            dec <xCount
        while ne | wend
    puls a,b,x,y
rts
