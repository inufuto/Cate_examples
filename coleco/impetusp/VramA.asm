include "Vdp.inc"
include "Vram.inc"

ext MonoPattern
ext LDIRVM, WRTVRM
ext DisableNmi, EnableNmi

VramTop equ Vram+VramRowSize*2

dseg
NextPage: public NextPage
    defb 0
TerrainCharOffset: public TerrainCharOffset
    defw 0

cseg
ColorSource:
defb 29, 0f0h ; Ascii
defb 15, 70h ; Logo
defb 1, 0f0h ; Remain
defb 0
cseg
InitVram: public InitVram
    call ClearScreen_

    ld b,3
    ld de,Vram_PatternGenerator
    do
        push de | push bc
            ld hl,MonoPattern
            ld bc,Char_Color*CharHeight
            call LDIRVM
        pop bc | pop de
        ld a,d | add a,8 | ld d,a
    dwnz

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
ret

WriteR2: ; (a)
    call DisableNmi
        ld b,80h or 2
        inc c
        out (c),a
        out (c),b
        dec c
    call EnableNmi
ret

; void ClearScreen();
cseg
ClearVram:
    inc c
    out (c),l
    out (c),h
    dec c
    ld b,0
    ld hl,300h
    do
        out (c),b
        dec hl
        ld a,l | or h
    while nz | wend
ret
ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld c,VdpPort

        ld hl,4000h or Vram_PatternName0
        call ClearVram
        ld hl,4000h or Vram_PatternName1
        call ClearVram

        ld a,06h | call WriteR2
        ld a,high Vram_PatternName1 | ld (NextPage),a
        ld a,TerrainCharCount | ld (TerrainCharOffset),a
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


WriteHlA:
    call DisableNmi
        inc c
        out (c),l
        out (c),h
        dec c
        out (c),a
    call EnableNmi
ret

; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push bc
        ld c,VdpPort
        ld a,e
        set 6,h
        call WriteHlA
        set 2,h
        call WriteHlA
        res 2,h
        res 6,h
        inc hl
    pop bc | pop af
ret


; byte FromAscii(byte c);
cseg
CharTable:
    defb " -0123456789ABCEFGHIMNOPRSTUV"
FromAscii_: public FromAscii_
    push hl | push bc
        ld bc,29*256
        ld hl,CharTable
        do
            cp (hl)
            jr z,PrintC_break
            inc hl
            inc c
        dwnz
        ld c,0
        PrintC_break:
        ld a,c
    pop bc | pop hl
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    push af | push bc
        ld c,VdpPort
        ld a,e
        call FromAscii_
        set 6,h
        call WriteHlA
        set 2,h
        call WriteHlA
        res 2,h
        res 6,h
        inc hl
    pop bc | pop af
ret


ext Status_

; void StatusToVram();
StatusToVram_: public StatusToVram_
cseg
    push af | push hl | push de | push bc
        ld c,VdpPort
        ld de,Status_
        ld hl,4000h or Vram
        ld b,VramWidth*2
        do
            ld a,(de) | inc de
            or a
            if nz
                call WriteHlA
                set 2,h
                call WriteHlA
                res 2,h
            endif
            inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void SwitchVram();
SwitchVram_: public SwitchVram_
    push af | push hl | push bc
        ld c,VdpPort
        ld a,(NextPage)
        cp high Vram_PatternName0
        if z
            ld a,06h | call WriteR2
            ld a,high Vram_PatternName1 | ld (NextPage),a
            ld a,TerrainCharCount | ld (TerrainCharOffset),a
        else
            ld a,07h | call WriteR2
            ld a,high Vram_PatternName0 | ld (NextPage),a
            xor a | ld (TerrainCharOffset),a
        endif
    pop bc | pop hl | pop af
ret