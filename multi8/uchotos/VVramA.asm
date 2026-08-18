include "VVram.inc"

ext VVram_


; ptr<byte> VVramPtr(byte x, byte y);
VVramPtr_: public VVramPtr_
    push de
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            add hl,hl ;*32
        ex de,hl
        ld l,a | ld h,0
        add hl,de
        ld de,VVram_ | add hl,de
    pop de
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    ld (hl),e
    inc hl
ret