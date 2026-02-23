include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_


; ptr<byte> VVramPtr(byte x, byte y);
cseg
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
        ld l,a
        ld h,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret


; void ClearVVram();
ClearVVram_: public ClearVVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld de,VVramWidth*VVramHeight
        do
            ld (hl),0 | inc hl
            dec de
            ld a,e
            or d
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
