include "VVram.inc"

ext VVram_
ext Map_
ext BaseX_, BaseY_
ext PollVSync_

Char_Space equ 0
Char_Wall equ 44h

MapStep equ 8

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push af | push de | push bc
        ld c,a  ; x
        ld a,e
        add a,a ; *2
        add a,e ; *3
        ld l,a
        ld h,0
        add hl,hl ; *6
        add hl,hl ; *12
        add hl,hl ; *24
        ld e,c  ; x
        ld d,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop bc | pop de | pop af
ret

; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    push af | push hl | push de | push bc
        ld a,(BaseY_)
        ld l,a
        ld h,0
        add hl,hl   ;*2
        add hl,hl   ;*4
        add hl,hl   ;*8 : map.step
        ld de,Map_
        add hl,de
        ld a,(BaseX_)
        ld b,a
        srl a
        srl a
        srl a
        ld e,a
        ld d,0
        add hl,de
        ex de,hl
        ld c,1
        ld a,b
        and 07h
        do | while nz
            sla c
            dec a
        wend
        ld hl, VVram_
        ld b, VVramHeight
        do
            call PollVSync_
            push bc
                push de
                    ld b,VVramWidth
                    do
                        ld a,(de)
                        and c
                        if nz
                            ld (hl),Char_Wall
                        else
                            ld (hl),Char_Space
                        endif
                        inc hl
                        rlc c
                        if c
                            inc de
                        endif
                    dwnz
                pop de
                ex de,hl
                ld bc, MapStep
                add hl,bc
                ex de,hl
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret