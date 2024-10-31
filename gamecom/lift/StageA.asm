ext CellMap_

FloorCount equ 3
ColumnCount equ 12
StageTop equ 2

; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public CellMapPtr_
    pushw rr2
        sub r3,StageTop
        srl r3 | srl r3
        mult rr2,12
        srl r1
        clr r0
        addw rr0,rr2
        addw rr0,CellMap_
    popw rr2
ret
