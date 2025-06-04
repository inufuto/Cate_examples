include "VVram.inc"

ext VVramBack_, VVramFront_


; word VVramOffset(byte x, byte y)
VVramOffset_: public VVramOffset_
    push af | push de | push bc
        ld c,a | ld b,0
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        ld l,a | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,de ;*25
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


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    ld (hl),e
    inc hl
ret