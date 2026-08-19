include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext WRTVRM
ext LDIRVM
ext RDVRM
ext FILVRM
ext WRTVDP

ext MonoPattern, ColorPattern

VramTop equ Vram+VramRowSize*StatusHeight

cseg
ColorSource:
defb 64, 0f0h ; Ascii
defb 15, 0a0h ; Logo
defb 2, 0a0h ; Ladder
defb 4, 0b0h ; Item
defb 4, 70h ; Debri
defb 4, 0f0h ; Remain
defb 0
cseg
InitVram: public InitVram
    ld hl,MonoPattern
    ld de,Vram_PatternGenerator
    ld bc,Char_End*CharHeight
    call LDIRVM

    ld hl,Vram_Color
    ld de,ColorSource
    do
        ld a,(de)
        or a
    while nz
        ld c,a
        inc de
        ld a,(de)
        inc de
        do
            ld b,8
            do
                push af
                    call WRTVRM
                pop af
                inc hl
            dwnz
            dec c
        while nz | wend
    wend

    ld de,ColorPattern
    ld hl,(Vram_PatternGenerator+CharHeight*Char_Color) and 3fffh
    ld c,Char_End-Char_Color
    do
        push hl
            ld b,CharHeight
            do
                ld a,(de) | inc de
                call WRTVRM
                inc hl
            dwnz
        pop hl
        set 5,h
            ld b,CharHeight
            do
                ld a,(de) | inc de
                call WRTVRM
                inc hl
            dwnz
        res 5,h
        dec c
    while nz | wend

    ld hl,Vram_PatternGenerator+800h
    exx
        ld hl,Vram_PatternGenerator
    exx
    ld c,2
    do
        ld b,2
        do
            ld de,800h
            do
                exx
                    call RDVRM
                    inc hl
                exx
                call WRTVRM
                inc hl
                dec de
                ld a,e
                or d
            while nz | wend
        dwnz
        ld hl,Vram_Color+800h
        exx
            ld hl,Vram_Color
        exx
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName
        ld bc,300h
        xor a
        call FILVRM
    pop bc | pop hl | pop af
ret


; word VramAddress(byte x, byte y);
VramAddress_: public VramAddress_
    push de
        ld l,e
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a | ld d,0
        add hl,de
        ld de,VramTop
        add hl,de
    pop de
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    ex af,af'
        ld a,e
        call WRTVRM
        inc hl
    ex af,af'
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    ex af,af'
        ld a,e
        sub 20h
        call WRTVRM
        inc hl
    ex af,af'
ret
