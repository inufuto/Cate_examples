ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    pushw rr2
        mult rr2,24
        srl r1 | srl r1
        clr r0
        addw rr0,rr2
        addw rr0,CellMap_
    popw rr2
ret