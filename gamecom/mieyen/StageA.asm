ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    pushw rr2
        srl r1
        mult rr2,4
        clr r0
        addw rr0,rr2
        addw rr0,CellMap_
    popw rr2
ret
