include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext WRTVRM
ext LDIRVM
ext RDVRM
ext FILVRM
ext WRTVDP

ext CharPattern

VramTop equ Vram+VramRowSize*2

cseg
ColorSource:
defb 64, 0f4h ; Ascii
defb 16, 74h ; Logo
defb 16, 74h ; Wall
defb 4, 0a4h ; Dot
defb 4, 0b4h ; Food
defb 4, 0f4h ; Remain
defb 0
cseg
InitVram: public InitVram
    ld hl,CharPattern
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

    ld bc,0407h | call WRTVDP
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
        ld e,a
        ld d,0
        add hl,de
        ld de,Vram
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


; byte ReadVram(word vram);
cseg
ReadVram_: public ReadVram_
    call RDVRM
ret
