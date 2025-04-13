include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_

Cell_Type_Floor equ 08h
Cell_Type_LiftBottom equ 18h


cseg

; ptr<byte> VVramPtr(byte x, byte y);
VVramPtr_: public VVramPtr_
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
        ld bc,VVram_
        add hl,bc
    pop bc | pop af
ret
