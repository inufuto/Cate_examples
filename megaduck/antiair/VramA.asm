include "MegaDuck.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext Ground_

Mode equ LCDCF_OBJ16 or LCDCF_OBJON or LCDCF_BGON ;or LCDCF_WINON
LcdOn equ Mode or LCDCF_ON
LcdOff equ Mode

dseg
ModeValue: public ModeValue
    defb 0
pCharRam:
    defw 0
cseg
ColorTable:
defb 64, 3 ; Ascii
defb 16, 2 ; Logo
defb 0
NextHl:
    ld a,l
    or a,a
    if z
        ld a,h
        cp a,high(CharRam0)+8
        if z
            ld h,high CharRam1
        endif
    endif
ret
InitVram: public InitVram
    ld a,LcdOff | ldh (LCDC),a
    ld a,0d0h | ldh (OBP0),a
    ld a,0e4h | ldh (BGP),a

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
                                    ; bit 4,c
                                    ; if nz
                                    ;     cpl
                                    ;     or a,b
                                    ;     ld b,a
                                    ;     cpl
                                    ; endif
                                    ld a,b
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
                call NextHl
                ld a,l | ld (pCharRam),a
                ld a,h | ld (pCharRam+1),a
            pop hl
            dec b
        while nz|wend
    wend

    ld a,(pCharRam) | ld l,a
    ld a,(pCharRam+1) | ld h,a
    ld de,ColorPattern
    ld bc,CharHeight*PlaneCount*(Char_End-Char_Color)
    do
        ld a,(de) | inc de
        ld (hl+),a
        call NextHl
        dec bc
        ld a,c | or a,b
    while nz|wend

    ld hl,SpriteRam
    ld de,SpritePattern
    ld bc,CharHeight*PlaneCount*4*Pattern_End
    do
        ld a,(de) | inc de
        ld (hl+),a
        dec bc
        ld a,c | or a,b
    while nz|wend

    ld a,LcdOn | ldh (LCDC),a
    ld (ModeValue),a
ret


WaitMode1:
    do
        ldh a,(STAT)
        bit 1,a
    while z|wend
ret

WaitModeN1:
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
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af
        di
            call WaitModeN1
            ld (hl),e
            ld a,h | xor a,04h | ld h,a
            call WaitModeN1
            ld (hl),e
            ld a,h | xor a,04h | ld h,a
        ei
        inc hl
    pop af
ret


; ptr<byte> CurrentPage();
cseg
CurrentPage_: public CurrentPage_
    push af | push de
        ld a,(ModeValue)
        bit LCDCF_B_BG9C00,a
        if z
            ld hl,Vram0
        else
            ld hl,Vram1
        endif
        ld de,VramRowSize*StatusHeight
        add hl,de
    pop de | pop af
ret


; ptr<byte> NextPage();
cseg
NextPage_: public NextPage_
    push af | push de
        ld a,(ModeValue)
        bit LCDCF_B_BG9C00,a
        if nz
            ld hl,Vram0
        else
            ld hl,Vram1
        endif
        ld de,VramRowSize*StatusHeight
        add hl,de
    pop de | pop af
ret


; void SwitchPage();
cseg
SwitchPage_: public SwitchPage_
    push af | push bc
        ld a,(ModeValue)
        xor a,LCDCF_BG9C00
        ld (ModeValue),a
    pop bc | pop af
ret


; ptr<byte> WriteVram(ptr<byte> pVram, byte c);
cseg
WriteVram_: public WriteVram_
    push af
        di
            call WaitModeN1
            ld (hl),e
        ei
        inc hl
    pop af
ret


Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground(ptr<byte> pVram);
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc
        ld c,WindowHeight-2
        do
            ld b,WindowWidth
            do
                call WaitModeN1
                ld (hl),Char_Space | inc hl
                dec b
            while nz|wend
            ld de,VramRowSize-WindowWidth | add hl,de
            dec c
        while nz|wend

        ld de,Ground_
        ld b,VramRowSize
        do
            ld a,(de) | inc de
            push de
                ld c,a
                and a,Ground_BombMask
                if nz
                    rrca
                    add a,Char_BlockC-2
                    jr DrawBackground_write
                endif
                ld a,c
                and a,Ground_BlockMask
                if nz
                    dec a
                    rlca
                    add a,Char_BlockA
                    DrawBackground_write:
                    ld e,a
                        call WaitModeN1
                        ld (hl),e
                    ld a,e
                    inc a
                    ld de,VramRowSize | add hl,de
                    ld e,a
                        call WaitModeN1
                        ld (hl),e
                    ld a,e
                    ld de,-VramRowSize | add hl,de
                else
                    xor a,a
                    ld e,a
                        call WaitModeN1
                        ld (hl),e
                    ld a,e
                    ld de,VramRowSize | add hl,de
                    ld e,a
                        call WaitModeN1
                        ld (hl),e
                    ld a,e
                    ld de,-VramRowSize | add hl,de
                endif
                inc hl
            pop de
            dec b
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
