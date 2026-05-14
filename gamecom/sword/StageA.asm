include "Vram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 12
RowCount equ 7

cseg
MapPtr: ;->rr2
    mov r0,r1
    srl r0 | srl r0
    mult rr2,ColumnCount/4
    add r3,r0
    addw rr2,StageMap_
ret


cseg
; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    pushw rr0 | pushw rr2 | pushw rr4
        call MapPtr
        mov r4,0fch
        and r1,3
        if nz
            do
                rl r4 | rl r4
                sll r5 | sll r5
                dec r1
            while nz | wend
        endif
        mov r1,@rr2
        and r1,r4
        or r1,r5
        mov @rr2,r1
    popw rr4 | popw rr2 | popw rr0
ret


cseg
; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    pushw rr2
        pushw rr0
            call MapPtr
            mov r3,@rr2
            and r1,3
            if nz
                do
                    srl r3 | srl r3
                    dec r1
                while nz | wend
            endif
        popw rr0
        mov r1,r3
        and r1,03h
    popw rr2
ret
