ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push de
        ld d,0
        ex de,hl
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            add hl,hl ;*32
        ex de,hl
        ld l,a
        srl l | srl l
        ld h,0
        add hl,de
        ld de,CellMap_
        add hl,de
    pop de | pop af
ret
