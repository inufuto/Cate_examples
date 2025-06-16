include 'BIOS.inc'
include 'Vram.inc'
include 'Chars.inc'

ext Chars, SpritePattern, BackgroundChars, FortPattern
ext Background_, CharOffset_, DotOffset_
ext FortDotOffset_, FortCharOffset_

BackgroundWidth equ VramWidth+2
BackgroundCharCount equ (Char_Background_End - Char_Background) / 2
FortCharCount equ (Char_End - Char_Fort) / 2

cseg
ColorSource:
    defb 8, 0f0h
    defb 4, 0a0h
    defb 8, 70h
    defb 0

; void InitVram();
cseg
InitVram_: public InitVram_
    push af | push hl | push de | push bc
        ld hl,Chars
        ld de,Vram_PatternGenerator
        ld bc,(Char_Background-0)*CharHeight
        call LDIRVM

        ld hl,Vram_Color
        ld de,ColorSource
        do
            ld a,(de)
            or a
        while nz
            inc de
            ld b,a
            ld a,(de)
            inc de
            do
                call WRTVRM
                inc hl
            dwnz
        wend

        ld hl,SpritePattern
        ld de,Vram_SpriteGenerator
        ld bc,CharHeight*PatternCount
        call LDIRVM
    pop bc | pop de | pop hl | pop af
ret


; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push de | push bc
        ld hl,Vram_PatternName
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM
    pop bc | pop de | pop af
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


; void Put(word vram, byte c);
cseg
Put_: public Put_
    ex af,af'
        ld a,e
        call WRTVRM
    ex af,af'
    inc hl
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


; void BackgroundToVram();
cseg
BackgroundToVram_: public BackgroundToVram_
    push af | push hl | push de | push bc
        ld a,(CharOffset_)
        ld d,a
        ld a,(VdpOutPort)
        ld c,a
        ld hl,Vram+VramRowSize*2+4000h
        inc c
        di
            out (c),l
            out (c),h
        ei
        dec c
        exx
            ld hl,Background_
            ld de,BackgroundWidth-VramWidth
        exx
        ld e,VramHeight-2
        do
            ld b,VramWidth
            do
                exx
                    ld a,(hl) | inc hl
                exx
                cp Char_Background
                if nc
                    add a,d
                endif
                out (c),a
            dwnz
            exx
                add hl,de
            exx
            dec e
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void RollChar();
cseg
RollChar_: public RollChar_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a

        ld a,(CharOffset_)
        add a,Char_Background
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        set 6,h
        inc c
        di
            out (c),l
            out (c),h
        ei
        dec c
        exx
            ld a,(DotOffset_)
            ld c,a
            ld hl,BackgroundChars
        exx
        ld b,BackgroundCharCount*CharHeight
        do
            exx
                ld e,(hl) | inc hl
                ld d,(hl) | inc hl
                ld a,c
                or a
                do
                while nz
                    sla d | rl e
                    dec a
                wend
                ld a,e
            exx
            out (c),a
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void SetFortChars();
cseg
SetFortChars_: public SetFortChars_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort)
        ld c,a

        ld a,(FortCharOffset_)
        add a,Char_Fort
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        set 6,h
        inc c
        di
            out (c),l
            out (c),h
        ei
        dec c
        exx
            ld a,(FortDotOffset_)
            ld c,a
            ld hl,FortPattern+CharHeight
            ld b,FortCharCount*CharHeight-CharHeight
        exx
        ld hl,FortPattern
        ld b,FortCharCount*CharHeight
        do
            ld a,(hl) | inc hl
            exx
                ld e,a
                ld d,(hl) | inc hl
                ld a,c
                or a
                do
                while nz
                    sla d | rl e
                    dec a
                wend
                ld a,e
                dec b
                if z
                    ld hl,Chars
                endif
            exx
            out (c),a
        dwnz
    pop bc | pop de | pop hl | pop af
ret
