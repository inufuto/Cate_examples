include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext SetVdpAddressHL
ext WRTVRM
ext RDVRM
ext FILVRM
ext WRTVDP

ext MonoPattern,ColorPattern

dseg
VScroll_: public VScroll_
    defb 0
HScroll_: public HScroll_
    defb 0

cseg
ColorSource:
defb 64,7 ; Ascii
defb 16,5 ; Logo
defb 0
InitVram: public InitVram
    xor a | ld (VScroll_),a

    ld de,MonoPattern
    di
        ld hl,Vram_PatternGenerator
        call SetVdpAddressHL

        ld hl,MonoPattern
        ld de,ColorSource
        do
            ld a,(de) | inc de
            or a
        while nz
            ld b,a
            ld a,(de) | inc de
            exx
                ld e,a
            exx
            push de
                do
                    ld c,CharHeight
                    do
                        ld e,(hl) | inc hl
                        exx
                            ld a,e
                        exx
                        ld d,a
                        push bc
                            ld b,PlaneCount
                            do
                                bit 0,d
                                if nz
                                    ld a,e
                                else
                                    xor a
                                endif
                                out (VdpPort),a
                                srl d
                            dwnz
                        pop bc
                        dec c
                    while nz | wend
                dwnz
            pop de
        wend

        ld hl,ColorPattern
        ld bc,CharHeight*PlaneCount*(Char_End-Char_Color)
        do
            ld a,(hl) | inc hl
            out (VdpPort),a
            dec bc
            ld a,c | or b
        while nz | wend
    ei
ret


; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName
        ld bc,VramHeight*VramRowSize
        xor a
        call FILVRM

        ld hl,Vram_SpriteAttribute
        ld bc,64
        ld a,0c8h
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
        add hl,hl ;*64
        add a,a
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
    push af
        di
            ld a,l | out (VdpPort+1),a
            ld a,h | or 40h | out (VdpPort+1),a
            ld a,e
            out (VdpPort),a
            nop | nop | nop
            xor a
            out (VdpPort),a
        ei
    pop af
    inc hl | inc hl
ret
