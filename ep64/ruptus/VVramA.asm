include "VVram.inc"

ext VVramBack_, VVramFront_

dseg
SpSave:
    defw 0


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    push af | push hl | push de | push bc
        ld (SpSave),sp
        ld hl,VVramBack_+VVramWidth*VVramHeight
        ld de,VVramWidth*VVramHeight/2
        ld bc,0
        di
            ld sp,hl
            do
                push bc
                dec de
                ld a,e
                or d
            while nz | wend
            ld hl,(SpSave)
            ld sp,hl
        ei
    pop bc | pop de | pop hl | pop af
ret


; word VVramOffset(byte x, byte y)
VVramOffset_: public VVramOffset_
    push af | push de
        ld d,0
        ld l,e
        ld e,a  ; x
        ld h,d
        add hl,hl ; *2
        add hl,hl ; *4
        add hl,hl ; *8
        add hl,hl ; *16
        add hl,hl ; *32
        add hl,de
    pop de | pop af
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
