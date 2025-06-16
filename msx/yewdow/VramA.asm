include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern

cseg
ColorSource:
    defb 64, 0f0h ; Ascii
    defb 16, 70h ; Logo
    defb 4, 90h ; Remain
    defb 4, 40h ; Wall
    defb 20, 0a0h ; Aroow
    defb 4, 0b0h ; Item_A
    defb 4, 80h ; Item_B
    defb 4, 50h ; Item_C
    defb 4, 70h ; Item_D
    defb 4, 0e0h ; Rock
    defb 0

cseg
InitVram: public InitVram
    push af | push hl | push de | push bc
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
    pop bc | pop de | pop hl | pop af
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
