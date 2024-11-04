ext CellMap_

cseg
CellPtr:
    pushw rr0
        srl r1
        mult rr2,6
        clr r0
        addw rr2,rr0
        addw rr2,CellMap_
    popw rr0
ret


; byte GetCell(byte x, byte y);
cseg
GetCell_: public GetCell_
    pushw rr2
        call CellPtr
        btst r1,01h
        mov r1,@rr2
        if nz
            srl r1 | srl r1 | srl r1 | srl r1
        endif
        and r1,0fh
    popw rr2
ret


; byte SetCell(byte x, byte y, byte cell);
SetCell_: public SetCell_
    push r1 | pushw rr2 | push r5
        call CellPtr
        btst r1,01h
        if nz
            sll r5 | sll r5 | sll r5 | sll r5
            mov r1,@rr2
            and r1,0fh
        else
            and r5,0fh
            mov r1,@rr2
            and r1,0f0h
        endif
        or r1,r5
        mov @rr2,r1
    pop r5 | popw rr2 | pop r1
ret
