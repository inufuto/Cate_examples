ext CellMap_

; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        ld b,0
        add hl,bc
        ld bc,CellMap_
        add hl,bc
    pop bc | pop af
ret
