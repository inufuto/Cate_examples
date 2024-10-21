ext WallMap_

; word WallMapPtr(byte x, byte y);
cseg
WallMapPtr_: public WallMapPtr_
    push af | push bc
        and a,not 3
        rra | rra
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        ld b,0
        add hl,bc
        ld bc,WallMap_
        add hl,bc
    pop bc | pop af
ret
