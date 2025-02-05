include "VVram.inc"

dseg
VVramFront_: public VVramFront_
    defs VVramWidth*VVramHeight
VVramBack_: public VVramBack_
    defs VVramWidth*VVramHeight
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


; ptr<byte> VVramOffset(byte x, byte y);
cseg
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


; void VVramBackToFront();
VVramBackToFront_: public VVramBackToFront_
    push af | push hl | push de | push bc
        ld hl,VVramBack_
        ld de,VVramFront_
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(hl) | inc hl
                ld (de),a | inc de
            dwnz
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
