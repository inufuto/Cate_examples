include "VVram.inc"

ext PollVSync_

dseg
TVVram_: public TVVram_
    defs TVVramWidth*VVramHeight
GVVram_: public GVVram_
    defs GVVramWidth*(VVramHeight+2)
RowFlags_: public RowFlags_
    defs 4

cseg
Clear:
    do
        ld (hl),0 | inc hl
        call PollVSync_
        dec bc
        ld a,c
        or b
    while nz | wend
ret

; void ClearTVVram();
cseg
ClearTVVram_: public ClearTVVram_
    push af | push hl | push bc
        ld hl,TVVram_
        ld bc,TVVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; void ClearGVVram();
cseg
ClearGVVram_: public ClearGVVram_
    push af | push hl | push bc
        ld hl,GVVram_
        ld bc,GVVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; ptr<byte> VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push de
        ex de,hl
            ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            add hl,hl ; *8
            add hl,hl ; *16
            add hl,hl ; *32
            add hl,hl ; *64
        ex de,hl
        ld l,a
        ld h,0
        add hl,de
    pop de
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
        
        call PollVSync_
    pop bc | pop de | pop hl | pop af
ret
