include 'Vram.inc'

ext VVram_, RowFlags_
ext charOffset_, dotOffset_, Ground_
ext Status_

cseg

; word VVramOffset(byte x, byte y);
VVramOffset_: public VVramOffset_
    push de
        ld l,e
        ld h,0
        ld e,a
        ld d,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        add hl,de
    pop de
ret


; void GroundToVVram();
cseg
GroundToVVram_: public GroundToVVram_
    push af | push hl | push de | push bc
        ld a,(charOffset_)
        exx
            ld e,a
        exx
        ld hl,Ground_+VVramWidth*4
        ld de,VVram_
        ld bc,VVramWidth*VVramHeight
        do
            ld a,(hl)
            inc hl
            exx
                add a,e
            exx
            ld (de),a
            inc de
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void StatusToVVram();
cseg
StatusToVVram_: public StatusToVVram_
    push af | push hl | push de | push bc
        ld hl,Status_
        ld de,VVram_
        ld bc,VVramWidth*2
        do
            ld a,(hl)
            inc hl
            or a
            if nz
                ld (de),a
            endif
            inc de
            dec bc
            ld a,c
            or b
        while nz | wend
        ld a,(RowFlags_)
        or 03h
        ld (RowFlags_),a
    pop bc | pop de | pop hl | pop af
ret
