include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext PollVSync_
ext VVram_

PatternSize equ CharHeight*PlaneCount
SpritePatternSize equ PatternSize*4

dseg
TempPattern:
    defs PatternSize

cseg
WaitVSync_: public WaitVSync_
    push af | push bc
        ld bc,1a01h
        do
            in a,(c)
            and 80h
        while z | wend
        do
            in a,(c)
            and 80h
        while nz | wend
    pop bc | pop af
ret

FillVramExtra:
    ld bc,Vram+VramWidth*VramHeight
    ld d,20h
    do
        out (c),e
        res 4,b
        out (c),d
        set 4,b
        inc bc
        ld a,c
        or a
    while nz | wend
ret

WriteCG:
    ld d,8
    di
        call WaitVSync_
        WriteCG0:
            ld a,(hl)
            out (c),a
            inc hl
            inc bc
            nop
            inc hl
            dec hl
            ld a,13
            WriteCG1:
                dec a
            jp nz,WriteCG1
            dec d
        jp nz,WriteCG0
    ei
ret

SetPcg: public SetPcg
; a: char code
; hl: pPattern
    push af | push hl | push de | push bc
        ld e,a
        ld bc,Attributes
        ld a,Attribute_PCG or 7
        out (c),a
        ld bc,Vram
        out (c),e

        call FillVramExtra
        ld bc,1500h
        do 
            call WriteCG
            inc b
            ld a,b
            cp 18h
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


cseg
ColorTable:
defb 64, 7 ; Ascii
defb 1, 5 ; Wall
defb 4, 7 ; Goal
defb 4, 6 ; Bang
defb 4, 7 ; M
defb 4, 3 ; A
defb 4, 6 ; Z
defb 4, 2 ; Y
defb 0
InitVram: public InitVram
    call ClearScreen_
    
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
        call MakePatternMono
        add a,b
    wend
    ld c,Char_End-Char_Color
    ld de,ColorPattern
    call MakePatternColor
ret

MonoToColor:
; hl: pDestination
; de: pSource
; c: color
    push af | push bc
        ld b,3
        do 
            push de | push bc
                ld b,8
                do
                    ld a,(de) | inc de
                    push de
                        ld e,0
                        bit 0,c
                        if nz
                            or e
                            ld e,a
                        endif
                        bit 4,c
                        if nz
                            cpl
                            or e
                            ld e,a
                        endif
                        ld a,e
                        ld (hl),a | inc hl
                    pop de
                dwnz
            pop bc | pop de
            srl c
        dwnz
    pop bc | pop af
ret

MakePatternMono:
; a: char code
; de: pSource
; b: count
; c: color
    push af | push hl | push bc
        do
            ld hl,TempPattern
            call MonoToColor
            ld hl,TempPattern
            call SetPcg
            ex de,hl
                ld de,8
                add hl,de
            ex de,hl
            inc a
        dwnz
    pop bc | pop hl | pop af
ret

MakePatternColor:
    ex de,hl
    do
        call SetPcg
        ld de,PatternSize
        add hl,de
        inc a
        dec c
    while nz | wend
ret

; void ClearScreen();
cseg
FillVram:
    do
        out (c),e
        inc bc
        dec hl
        ld a,l | or h
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld bc,Vram
        ld hl,800h
        ld e,0
        call FillVram

        ld bc,Attributes
        ld hl,800h
        ld e,Attribute_PCG or 7
        call FillVram

        ld bc,4000h
        ld hl,0c000h
        ld e,0
        call FillVram

        ld bc,1800h
        ld a,12 | out (c),a
        inc c
        xor a | out (c),a
    pop bc | pop de | pop hl | pop af
ret


; word VramOffset(byte x, byte y);
VramOffset_: public VramOffset_
    push af | push bc
        ld c,a | ld b,0
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        ld l,a | ld h,0
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,hl ;*40
        add hl,bc
    pop bc | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push bc
        ld c,l | ld b,h
        out (c),e
        set 2,b
        out (c),e
        res 2,b
        inc hl
    pop bc
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        exx
            ld bc,Vram+VramRowSize*0
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(hl) | inc hl
                exx
                    out (c),a | inc bc
                exx
            dwnz
            exx
                ld a,c | add a,VramRowSize-VVramWidth | ld c,a
                ld a,b | adc a,0 | ld b,a
            exx
            dec c
            call PollVSync_
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
