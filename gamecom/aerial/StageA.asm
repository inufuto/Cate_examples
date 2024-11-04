ext GroundBits_

GroundBitsWidth equ 7
GroundBitsHeight equ 6

; void ShiftGround();
cseg
ShiftGround_: public ShiftGround_
    push r0 | pushw rr2 | pushw rr4 | pushw rr8
        movw rr8,GroundBits_+GroundBitsWidth
        mov r2,GroundBitsHeight
        do
            clr r0 ; prevByte
            mov r3,GroundBitsWidth
            do
                clr r5 ; lowByte
                mov r4,-(rr8)
                srl r4 | rrc r5
                srl r4 | rrc r5
                or r4,r0
                mov @rr8,r4
                mov r0,r5

                dec r3
            while nz|wend
            addw rr8,GroundBitsWidth*2

            dec r2
        while nz|wend
    popw rr8 | popw rr4 | popw rr2 | pop r0
ret
