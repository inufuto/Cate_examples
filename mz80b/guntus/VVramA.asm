include "VVram.inc"

dseg
VVramFront_: public VVramFront_
    defs VVramWidth*VVramHeight
VVramBack_: public VVramBack_
    defs VVramWidth*VVramHeight
RowFlags_: public RowFlags_
    defs 4
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
    push hl | push de | push bc
        ld hl,VVramBack_
        ld de,VVramFront_
        ld bc,VVramWidth*VVramHeight
        ldir

        xor a
        ld hl,RowFlags_
        ld b,4
        do
            ld (hl),a
            inc hl
        dwnz
    pop bc | pop de | pop hl
ret


; void SetRowFlags(byte y, byte b);
cseg
SetRowFlags_: public SetRowFlags_
    push af | push hl | push de | push bc
        ld d,0
        ld c,a
        and 7
        if nz
            ex de,hl
                ld b,a
                do
                    add hl,hl
                dwnz
            ex de,hl
        endif
        ld a,c
        rrca | rrca | rrca | and 3
        ld c,a
        ld b,0
        ld hl,RowFlags_
        add hl,bc
        ld a,(hl)
        or e
        ld (hl),a
        inc hl
        ld a,(hl)
        or d
        ld (hl),a
    pop bc | pop de | pop hl | pop af
ret
