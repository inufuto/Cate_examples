include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

; void VVramBackToFront();
cseg
VVramBackToFront_: public VVramBackToFront_
    push hl | push de | push bc
        ld hl,VVramBack_
        ld de,VVramFront_
        ld bc,VVramRowSize*VVramHeight
        ldir
    pop bc | pop de | pop hl
ret


cseg
VVramPtr: public VVramPtr
    push de
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            add hl,hl ;*32
        ex de,hl
        ld l,a | ld h,0
        add hl,de
        add hl,hl
        ld de,VVramFront_
        add hl,de
    pop de
ret

VPutFront: public VPutFront
    push de | push bc
        ex de,hl
            ld h,0
            add hl,hl ;*2
            ld bc,CharPattern
            add hl,bc
        ex de,hl
        ld a,(de) | inc de
        or a
        if nz
            ld (hl),a | inc hl
            ld a,(de) | inc de
            ld c,a
            and 0fh
            if z
                ld a,c | and 0f0h | ld c,a
                ld a,(hl)
                and 0fh
                or c | ld c,a
            endif
            ld (hl),c | inc hl
        else
            inc hl | inc hl
        endif
    pop bc | pop de
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
    push af | push hl | push de | push bc
        call VVramPtr
        ld d,e ; yPos
        ld a,c ; pattern
        add a,a ;*2
        add a,a ;*4
        add a,Char_End
        ld e,a

        ld c,2
        do
            ld a,d
            cp VVramHeight
            if c
                ld b,2
                do
                    call VPutFront
                    inc e
                dwnz
                ld a,l | add a,VVramRowSize-VVramStep*2 | ld l,a
                ld a,h | adc a,0 | ld h,a
            else
                inc e | inc e
                ld a,l | add a,VVramRowSize | ld l,a
                ld a,h | adc a,0 | ld h,a
            endif
            inc d
        dec c | while nz | wend
    pop bc | pop de | pop hl | pop af
ret
