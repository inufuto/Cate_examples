include "VVram.inc"

ext VVramBack_, VVramFront_


; word VVramOffset(byte x, byte y)
VVramOffset_: public VVramOffset_
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
    pop de
ret


; void ClearVVramFront();
ClearVVramFront_: public ClearVVramFront_
    push af | push hl | push de | push bc
        ld hl,VVramFront_
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),0
            inc hl
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    ld (hl),e
    inc hl
ret