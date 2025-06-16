include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"
include "VVram.inc"

ext MonoPattern
ext VVram_

VramTop equ Vram+VramRowSize*0

dseg
NextPage: public NextPage
    defb 0


cseg
ColorSource:
defb 64, 0f0h ; Ascii
defb 1, 70h ; Wall
defb 4, 0f0h ; Knife
defb 88, 0f0h ; Man
defb 4, 0d0h ; Chaser
defb 4, 80h ; Disturber
defb 4, 0f0h ; Goal
defb 4, 0a0h ; Bang
defb 4, 0f0h ; M
defb 4, 0d0h ; A
defb 4, 0a0h ; Z
defb 4, 80h ; Y
defb 0
cseg
InitVram: public InitVram
    call INIGRP
    ; ld a,4
    xor a
    ld (BDRCLR),a
    call CHGCLR

    call ClearScreen_

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
        ld bc,300h
        xor a
        call FILVRM
    pop bc | pop hl | pop af
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


;   void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a
        di
            exx
                ld hl,VramTop or 4000h
                ld de,VramWidth
                ld c,a
                inc c
            exx
            ld hl,VVram_
            ld e,VVramHeight
            do
                exx
                    out (c),l
                    out (c),h
                exx
                ld b,VVramWidth
                do
                    ld a,(hl) | inc hl
                    out (c),a
                dwnz
                exx
                    add hl,de
                exx
                dec e
            while nz | wend
        ei
    pop bc | pop de | pop hl | pop af
ret
