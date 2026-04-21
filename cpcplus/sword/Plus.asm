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
	defb	00h, 00h, 88h, 00h, 0f0h, 08h, 0f8h, 00h
	defb	0ah, 0fh, 0fh, 08h, 88h, 0fh, 0cch, 0ch
	defb	00h, 00h, 0fh, 00h, 0d0h, 00h, 0ffh, 00h
	defb	00h, 0fh, 0fh, 0fh, 0f0h, 0fh, 0ffh, 0fh

HideAllSprites: public HideAllSprites
    di | ld bc,7fb8h | out (c),c
        ld hl,6004h
        ld de,8
        xor a
        ld b,16
        do
            ld (hl),a
            add hl,de
        dwnz
    ld bc,7fa0h | out (c),c | ei
ret

ShowSprite: public ShowSprite ; (a,bc,de,hl)
    push af | push hl
        add a,a | add a,a | add a,a
        ld l,a | ld h,60h
        exx | di | ld bc,7fb8h | out (c),c | exx
            ld (hl),c | inc hl
            ld (hl),b | inc hl
            ld (hl),e | inc hl
            ld (hl),d | inc hl
            ld (hl),0dh
        exx | ld c,0a0h | out (c),c | ei | exx
    pop hl | pop af
    add a,40h
    ld d,a | ld e,0
    ld c,16
    do
        exx | di | ld c,0b8h | out (c),c | exx
            ld b,8
            do
                ld a,(hl) | inc hl
                ld (de),a | inc e
            dwnz
        exx | ld c,0a0h | out (c),c | ei | exx
        inc e | inc e | inc e | inc e
        inc e | inc e | inc e | inc e
        dec c
    while nz | wend
ret

HideSprite: public HideSprite
    add a,a | add a,a | add a,a
    add a,4
    ld c,a | ld b,60h
    xor a
    exx | di | ld bc,7fb8h | out (c),c | exx
        ld (bc),a
    exx | ld c,0a0h | out (c),c | ei | exx
ret
