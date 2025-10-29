include "VVram.inc"

ext VVramFront_

dseg
SpSave:
    defw 0

; void ClearVVramFront();
cseg
ClearVVram:
ret
ClearVVramFront_: public ClearVVramFront_
    push af | push hl | push de | push bc
        ld hl,VVramFront_+VVramWidth*VVramHeight
        ld (SpSave),sp
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
