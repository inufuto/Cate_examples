ext CellMap_

; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public CellMapPtr_
    pushw rr2
        mult rr2,12
        clr r0
        addw rr0,rr2
        addw rr0,CellMap_
    popw rr2
ret
