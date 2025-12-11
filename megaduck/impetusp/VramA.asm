include "MegaDuck.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern

Mode equ LCDCF_OBJ16 or LCDCF_OBJON or LCDCF_BGON
LcdOn equ Mode or LCDCF_ON
LcdOff equ Mode

dseg
ModeValue: public ModeValue
    defb 0
NextPage: public NextPage
    defb 0
TerrainCharOffset: public TerrainCharOffset
    defb 0
pCharRam:
    defw 0
cseg
ColorTable:
defb 64, 3 ; Ascii
defb 16, 2 ; Logo
defb 8, 2 ; Panel
defb 0
InitVram: public InitVram
    ; ld a,LcdOff | ldh (LCDC),a
    ld a,0d0h | ldh (OBP0),a
    ld a,0e4h | ldh (BGP),a
    ld a,LcdOn | ldh (LCDC),a
    ld (ModeValue),a

    ld a,low CharRam0 | ld (pCharRam),a
    ld a,high CharRam0 | ld (pCharRam+1),a
    ld de,MonoPattern
    ld hl,ColorTable
    do
        ld a,(hl+)
        or a,a
    while nz
        ld b,a
        ld a,(hl+) | ld c,a
        do
            push hl
                ld a,(pCharRam) | ld l,a
                ld a,(pCharRam+1) | ld h,a
                push bc
                    ld b,CharHeight
                    do
                        push bc
                            ld b,PlaneCount
                            do
                                push bc
                                    ld a,(de)
                                    ld b,0
                                    bit 0,c
                                    if nz
                                        or a,b
                                        ld b,a
                                    endif
                                    ld a,b
                                    push af
                                        call WaitModeN1
                                    pop af
                                    ld (hl+),a
                                pop bc
                                srl c
                                dec b
                            while nz|wend
                        pop bc
                        inc de
                        dec b
                    while nz|wend
                pop bc
                ld a,l
                or a,a
                if z
                    ld a,h
                    cp a,high(CharRam0)+8
                    if z
                        ld h,high CharRam1
                    endif
                endif
                ld a,l | ld (pCharRam),a
                ld a,h | ld (pCharRam+1),a
            pop hl
            dec b
        while nz|wend
    wend

    ; ld a,(pCharRam) | ld l,a
    ; ld a,(pCharRam+1) | ld h,a
    ; ld de,ColorPattern
    ; ld bc,CharHeight*PlaneCount*(Char_End-Char_Color)
    ; do
    ;     ld a,(de) | inc de
        ; push af
        ;     call WaitModeN1
        ; pop af
    ;     ld (hl+),a
    ;     ld a,l
    ;     or a,a
    ;     if z
    ;         ld a,h
    ;         cp a,high(CharRam0)+8
    ;         if z
    ;             ld h,high CharRam1
    ;         endif
    ;     endif
    ;     dec bc
    ;     ld a,c | or a,b
    ; while nz|wend

    ld hl,SpriteRam
    ld de,SpritePattern
    ld bc,CharHeight*PlaneCount*4*Pattern_End
    do
        ld a,(de) | inc de
        push af
            call WaitModeN1
        pop af
        ld (hl+),a
        dec bc
        ld a,c | or a,b
    while nz|wend
ret


WaitMode1:
    do
        ldh a,(STAT)
        bit 1,a
    while z|wend
ret

WaitModeN1: public WaitModeN1
    do
        ldh a,(STAT)
        bit 1,a
    while nz|wend
ret

WaitMode3:
    ; push af
        do
            ldh a,(STAT)
            and a,3
            cp a,1
        while nz|wend
    ; pop af
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        call WaitMode3
        ld hl,Vram0
        ld c,VramHeight*2
        do
            ld b,VramWidth
            do
                call WaitModeN1
                ld (hl),0 | inc hl
                dec b
            while nz|wend
            dec c
        while nz|wend
        ld a,LcdOn | ld (ModeValue),a

        ld a,high Vram1 | ld (NextPage),a
        ld a,TerrainCharCount | ld (TerrainCharOffset),a
    pop bc | pop hl | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af
        di
            call WaitModeN1
            ld (hl),e
            ld a,h | xor a,04h | ld h,a
        ei
        di
            call WaitModeN1
            ld (hl),e
            ld a,h | xor a,04h | ld h,a
        ei
        inc hl
    pop af
ret


; byte FromAscii(byte c);
cseg
CharTable:
    defb " -0123456789:ABCEFGHIMNORSTUV"
FromAscii_: public FromAscii_
    push hl | push bc
        ld bc,29*256
        ld hl,CharTable
        do
            cp a,(hl)
            jr z,PrintC_break
            inc hl
            inc c
        dec b | while nz | wend
        ld c,0
        PrintC_break:
        ld a,c
    pop bc | pop hl
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    push af | push de
        ld a,e
        call FromAscii_
        ld e,a
        call Put_
    pop de | pop af
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    push af
        ld a,(ModeValue)
        xor a,LCDCF_BG9C00
        ld (ModeValue),a
        bit LCDCF_B_BG9C00,a
        if z
            ld a,TerrainCharCount | ld (TerrainCharOffset),a
            ld a,high Vram1
        else
            xor a,a | ld (TerrainCharOffset),a
            ld a,high Vram0
        endif
        ld (NextPage),a
    pop af
ret


ext Status_

; void StatusToVram();
cseg
StatusToVram_: public StatusToVram_
    push af | push hl | push de | push bc
        ld a,(NextPage) | ld h,a
        ld l,0
        ld de,Status_
        ld c,StatusHeight
        do
            ld b,WindowWidth
            do
                push bc
                    ld a,(de) | inc de
                    or a,a
                    if nz
                        ld c,a
                        call WaitModeN1
                        ld (hl),c
                    endif
                    inc hl
                pop bc
            dec b | while nz | wend
            ld a,l | add a,VramRowSize-WindowWidth | ld l,a
        dec c | while nz | wend
    pop bc | pop de | pop hl | pop af
ret
