ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push bc
        mul bc,6
        xor w,w
        add wa,bc
        add wa,CellMap_
    pop bc
ret
