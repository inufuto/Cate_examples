include "VVram.inc"

ext VVramBack_, VVramFront_


; word VVramOffset(byte x, byte y)
VVramOffset_: public VVramOffset_
    push af | push bc
        ld c,a | ld b,0
        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a | ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*12
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
