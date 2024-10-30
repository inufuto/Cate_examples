include "VVram.inc"
include "Chars.inc"

ext Ground_

dseg
BackgroundChanged_: public BackgroundChanged_
    defb 0

Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    pushw rr0 | pushw rr2 | pushw rr8 | pushw rr10
        movw rr8,VVram
        clr r1
        movw rr2,VVramWidth*(WindowHeight-2)
        do
            mov (rr8)+,r1
            decw rr2
        while ne|wend

        movw rr10,Ground_
        mov r3,VVramWidth
        do
            mov r1,(rr10)+
            mov r2,r1
            and r1,Ground_BombMask
            if nz
                srl r1 | srl r1
                dec r1
                add r1,Char_BlockC
                br t,DrawBackground_write
            endif
            mov r1,r2
            and r1,Ground_BlockMask
            if nz
                dec r1
                add r1,Char_BlockA
                DrawBackground_write:
                mov @rr8,r1
                add r1,2
                mov VVramWidth(rr8),r1
            else
                clr r1
                mov @rr8,r1
                mov VVramWidth(rr8),r1
            endif
            incw rr8
            dec r3
        while ne|wend
    popw rr10 | popw rr8 | popw rr2 | popw rr0
ret
