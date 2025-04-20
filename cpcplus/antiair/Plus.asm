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
	defb	00h, 00h, 0fh, 00h, 0f0h, 00h, 0ffh, 00h
	defb	00h, 0fh, 0fh, 0fh, 0f0h, 0fh, 0ffh, 0fh
	defb	00h, 00h, 0fh, 05h, 0fbh, 00h, 0bbh, 00h
	defb	0bh, 0fh, 0bh, 0bh, 0f0h, 0bh, 0bbh, 0bh


CopySprite: public CopySprite
    push bc
        ld a,(ix+Sprite_x)
        add a,a
        di | ld bc,7fb8h | out (c),c
            ld (hl),a | inc l
            ld a,0 | adc a,0
            ld (hl),a | inc l
            ld a,(ix+Sprite_y)
            ld (hl),a | inc l
            ld (hl),0 | inc l
            ld (hl),0dh | inc l
        ld bc,7fa0h | out (c),c | ei
        inc l | inc l | inc l
        push hl
            ld l,(ix+Sprite_pattern)
            ld h,(ix+Sprite_pattern+1)
            di | ld bc,7fb8h | out (c),c
                ld c,16
                do
                    ld b,8
                    do
                        ld a,(hl) | inc hl
                        ld (de),a | inc e
                    dwnz
                    inc e | inc e | inc e | inc e
                    inc e | inc e | inc e | inc e
                    dec c
                while nz | wend
            ld bc,7fa0h | out (c),c | ei
            inc d
        pop hl
    pop bc
ret


EraseSprite: public EraseSprite
    ld bc,7fb8h
    ld a,d
    ld de,0a000h
    do
        cp 50h
    while c
        inc l | inc l | inc l | inc l
        di | out (c),c
            ld (hl),e
        out (c),d | ei
        inc l | inc l | inc l | inc l
        inc a
    wend
ret
