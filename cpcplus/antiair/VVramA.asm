include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Ground_


; ; ptr<byte> VVramPtr(byte x, byte y);
; cseg
; VVramPtr_: public VVramPtr_
;     push de
;         ex de,hl
;             ld h,0
;             add hl,hl ;*2
;             add hl,hl ;*4
;             add hl,hl ;*8
;             add hl,hl ;*16
;             add hl,hl ;*32
;         ex de,hl
;         ld l,a
;         ld h,0
;         add hl,de
;         ld de,VVram_
;         add hl,de
;     pop de
; ret


Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc | push ix
        ld hl,VVram_
        ld bc,VVramWidth*(VVramHeight-2)
        do
            ld (hl),Char_Space
            inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        push hl | pop ix
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
                ld (ix),a
                inc a | inc a
                ld (ix+VVramWidth),a
            else
                xor a
                ld (ix),a
                ld (ix+VVramWidth),a
            endif
            inc ix
        dwnz
    pop ix | pop bc | pop de | pop hl | pop af
ret
