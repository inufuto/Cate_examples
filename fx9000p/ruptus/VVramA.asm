include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_

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


; void VVramBackToFront();
VVramBackToFront_: public VVramBackToFront_
    push af | push hl | push de | push bc
        ld hl,VVramFront_
        ld de,VVramBack_
        ld bc,VVramWidth*VVramHeight
        do
            ld a,(de) | inc de
            ld (hl),a | inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
