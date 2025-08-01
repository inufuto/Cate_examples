include 'BIOS.inc'
include 'Vram.inc'

Char_Ascii equ 0
Char_Logo equ 64
Char_Wall equ 80
Char_Meter equ 83
Char_MyFort equ 85
Char_EnemyFort equ 97
Char_End equ 109

ext Chars, SpritePattern

cseg
ColorSource:
    defb 64, 0f0h
    defb 16, 70h
    defb 2, 60h
    defb 1, 0e0h
    defb 2, 0b0h
    defb 12, 0f0h
    defb 12, 30h
    defb 0

; void InitVram();
cseg
InitVram_: public InitVram_
    push af | push hl | push de | push bc
        ld hl,Chars
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


; void WriteVram(word vram, byte c);
cseg
WriteVram_: public WriteVram_
    ex af,af'
        ld a,e
        call WRTVRM
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
