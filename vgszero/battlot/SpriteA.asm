include "vgszero.inc"
include "Vram.inc"
include "Chars.inc"

ext HScroll_
ext Sprites_

SpriteCount equ 21

cseg
UpdateSprites_: public UpdateSprites_
    push af | push hl | push de | push bc
        ld a,(HScroll_) | ld c,a

        ld de,Sprites_
        ld hl,OAM
        ld b,SpriteCount
        do
            inc de | inc de
            ld a,(de)
            dec de | dec de
            inc a
            if nz
                ld a,(de) | inc de ; y
                add a,CharHeight*1
                ld (hl),a | inc hl

                ld a,(de) | inc de ; x
                sub c
                ld (hl),a | inc hl

                ld a,(de) | inc de ; pattern
                push bc
                    add a,a ;*2
                    ld b,a
                    and 0fh
                    ld c,a
                    ld a,b
                    and 0f0h
                    add a,a ;*2
                    add a,c
                    add a,Char_End
                pop bc
                ld (hl),a | inc hl

                ld a,80h
            else
                inc de | inc de | inc de
                inc hl | inc hl | inc hl
                xor a
            endif
            ld (hl),a | inc hl ; attribute
            ld (hl),1 | inc hl ; heightMinus1 
            ld (hl),1 | inc hl ; widthMinus1
            ld (hl),PatternBank | inc hl ; bank
            inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret
