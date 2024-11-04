include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext GroundBits_, DotOffset_

Ground_Flat equ 0
Ground_Up equ 1
Ground_Down equ 2
Ground_Space equ 3

GroundBitsWidth equ 7
GroundBitsHeight equ 6

; void GroundToVVram();
cseg
GroundChars:
    defb Char_Ground ; 0: Ground_Flat,Ground_Flat
    defb Char_GroundUpUp ; 1: Ground_Up,Ground_Flat
    defb 1 ; 2: Ground_Down,Ground_Flat
    defb 1 ; 3: Ground_Space,Ground_Flat
    defb 1 ; 4: Ground_Flat,Ground_Up
    defb 1 ; 5: Ground_Up,Ground_Up
    defb Char_GroundDownUp ; 6: Ground_Down,Ground_Up
    defb Char_GroundUp ; 7: Ground_Space,Ground_Up
    defb Char_GroundDownDown ; 8: Ground_Flat,Ground_Down
    defb Char_GroundUpDown ; 9: Ground_Up,Ground_Down
    defb 1 ; 10: Ground_Down,Ground_Down
    defb 1 ; 11: Ground_Space,Ground_Down
    defb 1 ; 12: Ground_Flat,Ground_Space
    defb 1 ; 13: Ground_Up,Ground_Space
    defb Char_GroundDown ; 14: Ground_Down,Ground_Space
    defb Char_Space ; 15: Ground_Space,Ground_Space
GroundToVVram_: public GroundToVVram_
    pushw rr0 | pushw rr2 | pushw rr4 | push r6 | pushw rr8 | pushw rr10
        clr r1
        movw rr10,VVram
        movw rr2,VVramWidth*(VVramHeight-2-GroundBitsHeight)
        do
            mov (rr10)+,r1
            decw rr2
        while nz|wend

        movw rr8,GroundBits_
        mov r2,GroundBitsHeight
        do
            mov r3,VVramWidth/4
            do
                mov r4,(rr8)+ ; leftByte
                mov r5,@rr8 ; rightByte
                mov r6,4
                do
                    mov r1,r4
                    and r1,0fh
                    if z
                        mov r1,Char_Ground
                        br t,GroundToVram_write
                    endif
                    cmp r1,0fh
                    if z
                        mov r1,Char_Space
                        br t,GroundToVram_write
                    endif
                    clr r0
                    addw rr0,GroundChars
                    mov r1,@rr0
                    add r1,@DotOffset_
                    GroundToVram_write:
                    mov (rr10)+,r1

                    srl r5 | rrc r4
                    srl r5 | rrc r4

                    dec r6
                while nz|wend
                dec r3
            while nz|wend
            incw rr8

            dec r2
        while nz|wend

        mov r1,Char_Ground
        movw rr2,VVramWidth*2
        do
            mov (rr10)+,r1
            decw rr2
        while nz|wend
    popw rr10 | popw rr8 | pop r6 | popw rr4 | popw rr2 | popw rr0
ret
