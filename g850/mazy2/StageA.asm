ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld l,a | ld h,0
        ld b,0
        add hl,bc
        ld bc,CellMap_
        add hl,bc
    pop bc | pop af
ret
