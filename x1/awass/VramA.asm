include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext PollVSync_
ext VVram_

PatternSize equ CharHeight*PlaneCount
SpritePatternSize equ PatternSize*4
GVramTop equ GVram+VramWidth*2

dseg
TempPattern:
    defs PatternSize
PageOffset: public PageOffset
    defb 0

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
    ld bc,Vram0+VramWidth*VramHeight
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
        ld bc,Vram0
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
defb 30, 7 ; Ascii
defb 15, 6 ; Logo
defb 2, 6 ; Ladder
defb 1, 1 ; Floor
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
        ld bc,Vram0
        ld hl,800h
        ld e,0
        call FillVram

        ld bc,Attributes
        ld hl,800h
        ld e,Attribute_PCG or 7
        call FillVram

        ld bc,GVram
        ld hl,0c000h
        ld e,0
        call FillVram

        ld bc,1800h
        ld a,12 | out (c),a
        inc c
        xor a | out (c),a
        ld a,04h | ld (PageOffset),a
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


; word PrintC(word vram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push bc
        push hl
            ld a,e
            ld bc,30*256
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
        pop hl
        ld a,c

        ld c,l | ld b,h
        out (c),a
        set 2,b
        out (c),a
        res 2,b
        inc hl
    pop bc | pop af
ret

cseg
GVramAddress:
    ld d,a ;de=xy
    ld a,e ;y
    and 0feh
    ld l,a | ld h,0
    ld c,l | ld b,h
    add hl,hl ;*4
    add hl,hl ;*8
    add hl,bc ;*10
    add hl,hl ;*20
    add hl,hl ;*40
    ld a,d ;x
    srl a
    ld c,a | ld b,0
    add hl,bc
    
    ld bc,GVramTop | add hl,bc
    ld c,l
    ld a,(PageOffset)
    add a,h | ld b,a
ret

; void EraseSprite(byte x, byte y, byte pattern);
cseg
EraseSprite_: public EraseSprite_
    push af | push hl | push de | push bc
        call GVramAddress

        ld a,2
        bit 0,d
        if nz
            inc a
        endif
        ld (EraseSprite_x+1),a
        ld d,2
        bit 0,e
        if nz
            inc d
        endif
        do
            push bc
                EraseSprite_x:
                ld e,2
                do
                    ld l,PlaneCount
                    do
                        ld h,CharHeight
                        do
                            xor a
                            out (c),a
                            ld a,b | add a,8 | ld b,a
                            dec h
                        while nz | wend
                        dec l
                    while nz | wend
                    ld a,b | add a,-8*CharHeight*PlaneCount | ld b,a
                    inc bc
                    dec e
                while nz | wend
            pop bc
            ld a,c | add a,VramWidth | ld c,a
            ld a,b | adc a,0 | ld b,a

            dec d
        while nz | wend
    pop bc | pop de | pop hl | pop af
jp PollVSync_
; ret


cseg
SpritePatternHl:
    ld b,0
    ld l,c | ld h,b
    add hl,hl ;*2
    add hl,bc ;*3
    add hl,hl ;*6
    add hl,hl ;*12
    add hl,hl ;*24
    add hl,hl ;*48
    add hl,hl ;*96
    ld bc,SpritePattern | add hl,bc
ret

; void DrawSprite(byte x, byte y, byte pattern);
DrawSprite_: public DrawSprite_
    push af | push hl | push de | push bc
        call SpritePatternHl
        push hl
            call GVramAddress
        pop hl

        bit 0,e ;y
        if z
            bit 0,d ;x
            if z
                exx
                    ld b,PlaneCount
                exx
                do
                    ld e,2
                    do
                        ld d,CharHeight
                        call copyX2
                        call nextY
                        dec e
                    while nz | wend
                    call nextPlane2
                    exx
                        dec b
                    exx
                while nz | wend
            else
                exx
                    ld b,PlaneCount
                exx
                do
                    ld e,2
                    do
                        ld d,CharHeight
                        call copyXShift2
                        call nextY
                        dec e
                    while nz | wend
                    call nextPlane2
                    exx
                        dec b
                    exx
                while nz | wend
            endif
        else
            bit 0,d ;x
            if z
                ld a,b | add a,8*CharHeight/2 | ld b,a
                ld e,PlaneCount
                do
                    ld d,CharHeight/2
                    call copyX2
                    call nextY
                    ld d,CharHeight
                    call copyX2
                    call nextY
                    ld d,CharHeight/2
                    call copyX2
                    call nextPlane2
                    dec e
                while nz | wend
            else
                ld a,b | add a,8*CharHeight/2 | ld b,a
                ld e,PlaneCount
                do
                    ld d,CharHeight/2
                    call copyXShift2
                    call nextY
                    ld d,CharHeight
                    call copyXShift2
                    call nextY
                    ld d,CharHeight/2
                    call copyXShift2
                    call nextPlane2
                    dec e
                while nz | wend
            endif
        endif
	pop bc | pop de | pop hl | pop af
jp PollVSync_
; ret
nextY:
    ld a,c | add a,low(VramWidth-800h*CharHeight) | ld c,a
    ld a,b | adc a,high(VramWidth-800h*CharHeight) | ld b,a
ret
nextPlane2:
    ld a,c | add a,low(4000h-VramWidth*2) | ld c,a
    ld a,b | adc a,high(4000h-VramWidth*2) | ld b,a
ret
copyX2:
    do
        ld a,(hl) | inc hl
        out (c),a | inc bc
        ld a,(hl) | inc hl
        out (c),a | dec bc
        ld a,b | add a,8 | ld b,a
        dec d
    while nz | wend
ret
copyXShift2:
    do
        ld a,(hl) | inc hl
        exx
            ld d,a | ld e,0
            srl d | rr e
            srl d | rr e
            srl d | rr e
            srl d | rr e
        exx
        ld a,(hl) | inc hl
        exx
            ld h,a | ld l,0
            srl h | rr l
            srl h | rr l
            srl h | rr l
            srl h | rr l
        exx
        in a,(c)
        and 0f0h
        exx
            or d
        exx
        out (c),a | inc bc
        exx
            ld a,e
            or h
        exx
        out (c),a | inc bc
        in a,(c)
        and 0fh
        exx
            or l
        exx
        out (c),a
        dec bc | dec bc
        ld a,b | add a,8 | ld b,a
        dec d
    while nz | wend
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    push af | push bc
        ld bc,1800h
        ld a,12 | out (c),a
        inc c
        ld a,(PageOffset)
        out (c),a
        xor 04h
        ld (PageOffset),a
    pop bc | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        exx
            ld a,(PageOffset)
            add a,high Vram0
            ld b,a | ld c,VramRowSize*2
        exx
        ld c,VVramHeight-2
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
