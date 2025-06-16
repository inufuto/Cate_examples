include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern

cseg
PaletteValues:
defb	00h, 00h, 04h, 02h, 70h, 00h, 66h, 04h
defb	52h, 02h, 77h, 07h, 70h, 07h, 27h, 05h
defb	00h, 00h, 03h, 00h, 30h, 00h, 33h, 00h
defb	00h, 03h, 03h, 03h, 60h, 04h, 55h, 05h
ColorSource:
defb 64, 50h ; Ascii
defb 16, 70h ; Logo
defb 8, 0f0h ; CrackedFloor
defb 1, 0f0h ; HardFloor
defb 2, 0e0h ; Ladder
defb 4, 60h ; Item
defb 0

cseg
InitVram: public InitVram
    xor a | ld (BDRCLR),a
    call CHGCLR

    ld a,4 | call CHGMOD

    ld hl,PaletteValues
    ld d,0
    ld b,16
    do
        ld a,(hl) | inc hl
        ld e,(hl) | inc hl
        ld ix,SETPLT | call EXTROM
        inc d
    dwnz

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
ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName
        ld bc,VramHeight*VramWidth
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
        ; dec h | dec h | dec h | dec h
        ; call WRTVRM
        ; inc h | inc h | inc h | inc h
        inc hl
    ex af,af'
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    ex af,af'
        ld a,e
        sub ' '
        call WRTVRM
    ex af,af'
    inc hl
ret
