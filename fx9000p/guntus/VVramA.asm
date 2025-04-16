include "Vram.inc"
include "VVram.inc"

dseg
VVramBack_: public VVramBack_
    defs VVramWidth*VVramHeight
VVramFront_: public VVramFront_
    defs VVramWidth*VVramHeight


; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push af | push de | push bc
        ld c,a
        ld b,0
        ld d,b
        ld l,e | ld h,d
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        add hl,bc
    pop bc | pop de | pop af
ret


; void VVramBackToFront();
VVramBackToFront_: public VVramBackToFront_
    push hl | push de | push bc
        ld hl,VVramBack_
        ld de,VVramFront_
        ld bc,VVramWidth*VVramHeight
        ldir
    pop bc | pop de | pop hl
ret


; void ClearVVram();
ClearVVram_: public ClearVVram_
    push af | push hl | push de
        ld hl,VVramBack_
        ld de,VVramWidth*VVramHeight
        do
            ld (hl),0 | inc hl
            dec de
            ld a,e | or d
        while nz | wend
    pop de | pop hl | pop af
ret
