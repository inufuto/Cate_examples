include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
VVramPtr_: public VVramPtr_
    push de
        ex de,hl
            dec l | dec l
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            add hl,hl ;*32
        ex de,hl
        ld l,a
        ld h,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret
