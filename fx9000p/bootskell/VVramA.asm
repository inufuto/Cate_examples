include "Vram.inc"
include "VVram.inc"

ext VVramFront_, VVramBack_
ext CellMap_


; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push af | push bc
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld b,0
        add hl,bc
    pop bc | pop af
ret


