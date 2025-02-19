include "BIOS.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern

cseg
InitVram: public InitVram
    xor a | ld (BDRCLR),a
    call CHGCLR

    ld a,5 | call CHGMOD
    ld bc,0a08h | call WRTVDP
    ld bc,0009h | call WRTVDP

    ld hl,PaletteValues
    ld d,0
    ld b,16
    do
        ld a,(hl) | inc hl
        ld e,(hl) | inc hl
        ld ix,SETPLT | call EXTROM
        inc d
    dwnz

    ld bc,010eh | call WRTVDP
    xor a
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld c,(hl)
        inc hl
        do
            call MakePatternMono
            inc a
        dwnz
        add a,b
    wend

    ld de,ColorPattern
    do
        call MakePatternColor
        inc a
        cp Char_End
    while c | wend

    xor a
    ld de,SpritePattern
    do
        call MakeSpritePattern
        inc a
        cp Pattern_End
    while c | wend
ret

ToCharPatternAddress: ; a->hl
    push de
        ld l,a
        and 1fh
        add a,a ;*2    
        add a,a ;*4
        ld e,a | ld d,0
        ld a,l
        and 0e0h
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        add hl,de
        ld de,CharVram | add hl,de
    pop de
ret

MakePatternMono:
    push af | push hl | push bc
        call ToCharPatternAddress
        ld a,c
        exx
            ld d,a
            and 0fh
            ld e,a
            srl d | srl d | srl d | srl d
        exx
        ld c,CharHeight
        do
            ld a,(de) | inc de
            push de
                ld e,a
                ld b,VramStep
                do
                    ld d,2
                    do
                        exx
                            sla c | sla c | sla c | sla c
                        exx
                        sla e
                        if c
                            exx
                                ld a,c
                                or e
                                ld c,a
                            exx
                        else
                            exx
                                ld a,c
                                or d
                                ld c,a
                            exx
                        endif
                        dec d
                    while nz | wend
                    exx
                        ld a,c
                    exx
                    call NWRVRM | inc hl
                dwnz
                ld de,VramWidth-VramStep
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret

MakePatternColor:
    push af | push hl | push bc
        call ToCharPatternAddress
        ld c,CharHeight
        do
            ld b,VramStep
            do
                ld a,(de) | inc de
                call NWRVRM | inc hl
            dwnz
            push de
                ld de,VramWidth-VramStep
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret

MakeSpritePattern:
    push af | push hl | push bc
        call ToSpritePatternAddress
        ld c,CharHeight*2
        do
            ld b,VramStep*2
            do
                ld a,(de) | inc de
                call NWRVRM | inc hl
            dwnz
            push de
                ld de,VramWidth-VramStep*2
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret

ToSpritePatternAddress: ; a->hl
    push de
        ld l,a
        and 0fh
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld e,a | ld d,0
        ld a,l
        and 0f0h
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        add hl,hl ;*64
        add hl,hl ;*128
        add hl,de
        ld de,SpriteVram | add hl,de
    pop de
ret

PaletteValues:
defb	00h, 00h, 07h, 00h, 70h, 00h, 77h, 03h
defb	00h, 07h, 06h, 06h, 70h, 07h, 77h, 07h
defb	00h, 00h, 63h, 05h, 61h, 00h, 52h, 03h
defb	55h, 06h, 03h, 03h, 72h, 04h, 44h, 04h
ColorTable:
defb 64, 07h ; Ascii
defb 16, 05h ; Logo
defb 2, 06h ; Barrier
defb 0
