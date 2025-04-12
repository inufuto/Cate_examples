include "VVram.inc"

ext VVram_

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
