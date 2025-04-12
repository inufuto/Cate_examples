include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Ground_


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push de
        ld d,0
        ld l,e
        ld h,d
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld e,a
        ld d,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret


Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld (hl),Char_Space
        ld de,VVram_+1
        ld bc,VVramWidth*(VVramHeight-2)-1
        ldir

        ld de,VVram_+VVramWidth*(VVramHeight-2)
        exx
            ld de,VVram_+VVramWidth*(VVramHeight-2)+VVramWidth
        exx
        ld hl,Ground_
        ld b,VVramWidth
        do
            ld c,(hl) | inc hl
            ld a,c | and Ground_BombMask
            if nz
                rrca | rrca
                dec a
                add a,Char_BlockC
                jr DrawBackground_write
            endif
            ld a,c | and Ground_BlockMask
            if nz
                dec a
                add a,Char_BlockA
                DrawBackground_write:
                ld (de),a
                inc a | inc a
                exx
                    ld (de),a
                exx
            else
                ld a,Char_Space
                ld (de),a
                exx
                    ld (de),a
                exx
            endif
            inc de
            exx
                inc de
            exx
        dwnz
    pop bc | pop de | pop hl | pop af
ret
