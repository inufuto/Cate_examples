include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext SetVdpAddressHL
ext WRTVRM
ext RDVRM
ext LDIRVM
ext FILVRM
ext WRTVDP

ext MonoPattern, SpritePattern

dseg
NextPage: public NextPage
    defb 0
TerrainCharOffset: public TerrainCharOffset
    defw 0

cseg
ColorSource:
defb 29, 7 ; Ascii
defb 15, 5 ; Logo
defb 1, 7 ; Remain
defb 0
InitVram: public InitVram
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

        ld hl,Vram_PatternGenerator+2000h
        call SetVdpAddressHL
        ld hl,SpritePattern
        ld bc,PatternSize*(Char_SpriteEnd-Char_Sprite)
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
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName0
        ld bc,800h
        xor a
        call FILVRM

        ld hl,Vram_PatternName1
        ld bc,800h
        xor a
        call FILVRM

        ld hl,Vram_SpriteAttribute
        ld bc,64
        ld a,0c8h
        call FILVRM

        ld bc,0f702h | call WRTVDP
        ld a,high Vram_PatternName1 | ld (NextPage),a
        ld a,TerrainCharCount | ld (TerrainCharOffset),a
    pop bc | pop hl | pop af
ret


; word VramAddress(byte x, byte y);
VramAddress_: public VramAddress_
    push de
        ld l,e | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a | ld d,0
        add hl,de
        add hl,hl ;*64
        ld de,Vram | add hl,de
    pop de
ret


; word Put(word vram, byte c);
cseg
Put:
    di
        ex af,af'
            call SetVdpAddressHL
        ex af,af'
        out (VdpPort),a
        nop | nop
        ex af,af'
            xor a
            out (VdpPort),a
        ex af,af'
    ei
ret

Put_: public Put_
    push af
        ld a,e
        call Put
        set 5,h
            call Put
        res 5,h
    pop af
    inc hl | inc hl
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
    push af
        ld a,e
        call FromAscii_
        call Put
        set 5,h
            call Put
        res 5,h
        inc hl | inc hl
    pop af
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
                call Put
                set 5,h
                    call Put
                res 5,h
            endif
            inc hl | inc hl
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
            ld bc,0f702h | call WRTVDP
            ld a,high Vram_PatternName1 | ld (NextPage),a
            ld a,TerrainCharCount | ld (TerrainCharOffset),a
        else
            ld bc,0ff02h | call WRTVDP
            ld a,high Vram_PatternName0 | ld (NextPage),a
            xor a | ld (TerrainCharOffset),a
        endif
    pop bc | pop hl | pop af
ret


RepeatWrite: public RepeatWrite
    ex af,af'
        do
            ld a,(hl) | inc hl
            out (VdpPort),a
        dwnz
    ex af,af'
ret
