include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern

dseg
DspPage: public DspPage
    defb 0
WrtPage: public WrtPage
    defb 0

cseg
PaletteValues:
defb	00h, 00h, 04h, 02h, 26h, 01h, 66h, 04h
defb	52h, 02h, 77h, 07h, 70h, 07h, 00h, 07h
defb	57h, 07h, 03h, 00h, 41h, 02h, 33h, 00h
defb	00h, 03h, 03h, 03h, 64h, 05h, 55h, 05h
ColorSource:
defb 64, 50h ; Ascii
defb 16, 0e0h ; Logo
defb 2, 0e0h ; Ladder
defb 2, 0a0h ; Floor
defb 4, 80h ; Block
defb 0

cseg
InitVram: public InitVram
    xor a | ld (BDRCLR),a
    call CHGCLR

    ld a,4 | call CHGMOD
    ; ld bc,1002h | call WRTVDP ; Pattern name table

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
                    call NWRVRM
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
        ld b,3
        do
            ld de,800h
            do
                exx
                    call NRDVRM
                    inc hl
                exx
                call NWRVRM
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
        ld hl,Vram_PatternName0
        ld bc,VramWidth*VramHeight
        xor a
        call BIGFIL

        ld hl,Vram_PatternName1
        ld bc,VramWidth*VramHeight
        xor a
        call BIGFIL

        ld hl,4410h | ld (DspPage),hl
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
        call NWRVRM
        set 2,h
        call NWRVRM
        res 2,h
        inc hl
    ex af,af'
ret
