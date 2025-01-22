include "VVram.inc"

ext VVram_


; ptr<byte> VVramPtr(byte x, byte y);
VVramPtr_: public VVramPtr_
    push af | push de
        ld l,a
        ex de,hl
            ld a,l
            add a,a ;*2
            add a,l ;*3
            ld l,a
            ld h,0
            add hl,hl ;*6
            add hl,hl ;*12
            add hl,hl ;*24
        ex de,hl
        ld h,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de | pop af
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    ld (hl),e
    inc hl
ret