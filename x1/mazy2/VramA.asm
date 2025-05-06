include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern
ext VVram_
ext PollVSync_


dseg
Backup:
    defs VVramWidth*VVramHeight
PatternRam: public PatternRam
    defs PatternSize*Char_End
tempPattern:
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
    ld bc,VRAM+VramWidth*VramHeight
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
        ld bc,VRAM
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
defb 16, 5 ; Logo
defb 8,7 ; Stair
defb 4,6 ; Goal
defb 16,7 ; Point
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
    ld de,ColorPattern
    push af
        neg
        add a,Char_End
        ld c,a
    pop af
    call MakePatternColor

    ld hl,PatternRam
    ld de,MonoPattern
    ld ix,ColorTable
    do
        ld b,(ix)
        inc b | dec b
    while nz
        inc ix
        ld c,(ix)
        inc ix
        do
            call MonoToColor
            inc de | inc de | inc de | inc de
            inc de | inc de | inc de | inc de
        dwnz
    wend
    ld hl,ColorPattern
    ld de,PatternRam+PatternSize*Char_Color
    ld bc,PatternSize*(Char_End-Char_Color)
    ldir
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
            ld hl,tempPattern
            call MonoToColor
            ld hl,tempPattern
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
    ld de,PatternSize
    do
        call SetPcg
        add hl,de
        inc a
        dec c
    while nz | wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld bc,Vram
        ld hl,VramWidth*VramHeight
        do
            xor a
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend

        ld bc,Attributes
        ld hl,VramWidth*VramHeight
        do
            ld a,Attribute_PCG or 7
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend

        ld bc,GVram
        ld hl,0c000h
        do
            xor a
            out (c),a
            inc bc
            dec hl
            ld a,l
            or h
        while nz | wend

        ld hl,Backup
        ld de,Backup+1
        ld bc,VVramWidth*VVramHeight-1
        ld (hl),0
        ldir
    pop bc | pop hl | pop af
ret


; word VramAddress(byte x, byte y);
VramAddress_: public VramAddress_
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
        ld bc,Vram
        add hl,bc
    pop bc | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push bc
        ld a,e
        ld c,l
        ld b,h
        out (c),a
        inc hl
    pop bc | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld hl,Backup
        ld de,VVram_
        exx
            ld bc,GVram+VramWidth*1
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do
                call PollVSync_
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    push hl | push de
                        ld l,a
                        ld h,0
                        ld e,a
                        ld d,0
                        add hl,hl ;*2
                        add hl,de ;*3
                        add hl,hl ;*6
                        add hl,hl ;*12
                        add hl,hl ;*24
                        ld de,PatternRam
                        add hl,de

                        ld d,3
                        do
                            ld e,CharHeight
                            do
                                ld a,(hl) | inc hl
                                exx
                                    out (c),a
                                    ld a,b | add a,8 | ld b,a
                                exx
                                dec e
                            while nz | wend
                            dec d
                        while nz | wend
                        exx
                            ld a,b | add a,-8*CharHeight*3 | ld b,a
                        exx
                    pop de | pop hl
                endif
                inc hl
                exx
                    inc bc
                exx
            dwnz
            exx
                ld a,c | add a,VramWidth-VVramWidth | ld c,a
                ld a,b | adc a,0 | ld b,a
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
