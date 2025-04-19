Sprite_x equ 0
Sprite_y equ 1
Sprite_pattern equ 2

cseg
InitPlus: public InitPlus
    ld bc,7fb8h | out (c),c
        ld de,6400h
        ld hl,PaletteValues
        ld bc,2*16
        ldir
        ld hl,PaletteValues
        ld bc,2*16
        ldir

        ld hl,4000h
        do
            ld (hl),0 | inc hl
            ld a,h
            cp 50h
        while nz | wend
    ld bc,7fa0h | out (c),c
ret
PaletteValues:
	defb	00h, 00h, 5dh, 03h, 0f0h, 00h, 0ddh, 09h
	defb	00h, 0fh, 0fh, 0fh, 0f0h, 0fh, 0ffh, 0fh
	defb	00h, 00h, 77h, 07h, 0d0h, 09h, 0b5h, 05h
	defb	00h, 07h, 09h, 05h, 0f3h, 0dh, 0bbh, 0bh


CopySprite: public CopySprite
    push bc
        ld bc,7fb8h | out (c),c
            ld a,(ix+Sprite_x)
            add a,a
            ld (hl),a | inc hl
            ld a,0 | adc a,0
            ld (hl),a | inc hl
            ld a,(ix+Sprite_y)
            ld (hl),a | inc hl
            ld (hl),0 | inc hl
            ld (hl),0dh | inc hl
            inc hl | inc hl | inc hl
            push hl
                ld l,(ix+Sprite_pattern)
                ld h,(ix+Sprite_pattern+1)
                ld c,16
                do
                    ld b,8
                    do
                        ld a,(hl) | inc hl
                        ld (de),a | inc de
                    dwnz
                    inc de | inc de | inc de | inc de
                    inc de | inc de | inc de | inc de
                    dec c
                while nz | wend
            pop hl
        ld bc,7fa0h | out (c),c
    pop bc
ret


EraseSprite: public EraseSprite
    ld bc,7fb8h | out (c),c
        do
            ld a,d
            cp 50h
        while c
            inc hl | inc hl | inc hl | inc hl
            ld (hl),00h | inc hl
            inc hl | inc hl | inc hl
            inc d
        wend
    ld bc,7fa0h | out (c),c
ret
