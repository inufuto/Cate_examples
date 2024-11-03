include "VVram.inc"
include "Chars.inc"

ext BaseX_, BaseY_, Map_

MapStep equ 8


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    pushw rr2
        mult rr2,VVramWidth
        clr r0
        addw rr0,rr2
        addw rr0,VVram
    popw rr2
ret


; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    pushw rr0 | pushw rr2 | pushw rr8 | pushw rr10
					_deb: public _deb
        mov r1,@BaseY_
        mult rr0,8
        addw rr0,Map_
        movw rr8,rr0
        mov r1,@BaseX_
        mov r3,r1
        srl r1 | srl r1 | srl r1
        clr r0
        addw rr8,rr0
        
        mov r2,1
        and r3,7
        do | while nz
            sll r2
            dec r3
        wend

        movw rr10,VVram
        mov r3,VVramHeight
        do
            pushw rr2 | pushw rr8
                mov r3,VVramWidth
                mov r0,(rr8)+
                do
                    mov r1,r0
                    and r1,r2
                    if nz
                        mov r1,Char_Wall
                    else
                        mov r1,Char_Space
                    endif
                    mov (rr10)+,r1
                    rl r2
                    if c
                        mov r0,(rr8)+
                    endif
                    dec r3
                while nz|wend
            popw rr8 | popw rr2
            addw rr8,MapStep

            dec r3
        while nz|wend
    popw rr10 | popw rr8 | popw rr2 | popw rr0
ret
