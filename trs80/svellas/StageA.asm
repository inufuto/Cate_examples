ext PanelMap_

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        ld l,a | ld h,0
        ld b,0
        add hl,bc
        ld bc,PanelMap_
        add hl,bc
    pop bc | pop af
ret
