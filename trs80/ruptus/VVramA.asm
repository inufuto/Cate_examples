include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_


; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push af | push bc
        ld c,a | ld b,0
        ld a,e
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,bc
    pop bc | pop af
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
    push af | push hl | push de | push bc
        ld hl,VVramBack_
        ld de,VVramWidth*VVramHeight
        do
            ld (hl),0 | inc hl
            dec de
            ld a,e
            or d
        while nz | wend
        ; ld (ClearVVram_.sp+1),sp
        ; ld hl,VVramBack_+VVramWidth*VVramHeight*2
        ; ld de,VVramWidth*VVramHeight
        ; ld bc,0
        ; di
        ;     ld sp,hl
        ;     do
        ;         push bc
        ;         dec de
        ;         ld a,e
        ;         or d
        ;     while nz | wend
        ;     ClearVVram_.sp:
        ;     ld hl,0
        ;     ld sp,hl
        ; ei
    pop bc | pop de | pop hl | pop af
ret
