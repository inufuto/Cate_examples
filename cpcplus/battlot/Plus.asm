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
	defb	00h, 00h, 78h, 0ch, 90h, 03h, 0fbh, 0bh
	defb	20h, 05h, 7ch, 0ch, 0d9h, 0fh, 0ffh, 0fh
	defb	44h, 04h, 0d2h, 09h, 0f0h, 00h, 0f0h, 0fh
	defb	93h, 05h, 17h, 07h, 0f5h, 09h, 0cch, 0ch


CopySprite: public CopySprite
    push bc
        di | ld bc,7fb8h | out (c),c
            ld a,(ix+Sprite_x)
            add a,a
            ld (hl),a | inc l
            ld a,0 | adc a,0
            ld (hl),a | inc l
            ld a,(ix+Sprite_y)
            ld (hl),a | inc l
            ld (hl),0 | inc l
            ld (hl),0dh | inc l
            inc l | inc l | inc l
            push hl
                ld l,(ix+Sprite_pattern)
                ld h,(ix+Sprite_pattern+1)
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
                inc d
            pop hl
        ld bc,7fa0h | out (c),c | ei
    pop bc
ret


EraseSprite: public EraseSprite
    di | ld bc,7fb8h | out (c),c
        ld a,d
        ld e,0
        do
            cp 50h
        while c
            inc l | inc l | inc l | inc l
            ld (hl),e
            inc l | inc l | inc l | inc l
            inc a
        wend
    ld bc,7fa0h | out (c),c | ei
ret
