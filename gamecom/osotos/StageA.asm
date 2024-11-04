ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    pushw rr2
        and r3,0feh
        mult rr2,6
        clr r0
        addw rr0,rr2
        addw rr0,CellMap_
    popw rr2
ret
