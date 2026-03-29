include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext WRTVRM, LDIRVM, FILVRM, SetVdpAddressDE, SetVdpAddressHL

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

cseg
InitVram: public InitVram
    push af | push hl | push de | push bc
        ld b,3
        ld de,Vram_PatternGenerator
        exx
            ld hl,Vram_Color
        exx
        do
            push bc
                ld hl,Chars
                ld bc,Char_End*CharHeight
                call LDIRVM
                ex de,hl
                    ld bc,800h
                    add hl,bc
                ex de,hl
                exx
                    push hl
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
                    pop hl
                    ld bc,800h
                    add hl,bc
                exx
            pop bc
        dwnz
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

        ld hl,Vram_SpriteAttribute
        ld bc,4*32
        ld a,0d0h
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
