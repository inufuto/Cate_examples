ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push de
        ld d,a
            ld a,e
            add a,a ;*2
            add a,e ;*3
            ld l,a | ld h,0
            add hl,hl ;*6
            add hl,hl ;*12
            add hl,hl ;*24
        ld e,d
        srl e | srl e
        ld d,0
        add hl,de
        ld de,CellMap_
        add hl,de
    pop de | pop af
ret
