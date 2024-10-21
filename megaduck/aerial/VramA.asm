include "MegaDuck.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext HScroll_

Mode equ LCDCF_OBJ16 or LCDCF_OBJON or LCDCF_BGON ;or LCDCF_WINON
LcdOn equ Mode or LCDCF_ON
LcdOff equ Mode

dseg
ModeValue: public ModeValue
    defb 0
CurrentPage_: public CurrentPage_
    defw 0
NextPage_: public NextPage_
    defw 0
pCharRam:
    defw 0
cseg
ColorTable:
defb 64, 3 ; Ascii
defb 16, 2 ; Logo
defb 3, 2 ; Ground
defb 0
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

    ld a,(pCharRam) | ld l,a
    ld a,(pCharRam+1) | ld h,a
    ld de,ColorPattern
    ld bc,CharHeight*PlaneCount*(Char_End-Char_Color)
    do
        ld a,(de) | inc de
        ld (hl+),a
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

    xor a,a | ld (CurrentPage_),a | ld (NextPage_),a
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

        ld a,high Vram0
        ld (CurrentPage_+1),a
        xor a,04h
        ld (NextPage_+1),a
    pop bc | pop hl | pop af
ret


; word VramOffset(byte x, byte y);
cseg
VramOffset_: public VramOffset_
    push de
        ld l,e | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a | ld d,0
        add hl,de
    pop de
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


; void SwitchPage();
cseg
SwitchPage_: public SwitchPage_
    push af
        ld a,(ModeValue)
        xor a,LCDCF_BG9C00
        ld (ModeValue),a
        bit LCDCF_B_BG9C00,a
        if z
            ld a,high Vram0
        else
            ld a,high Vram1
        endif
        ld (CurrentPage_+1),a
        xor a,04h
        ld (NextPage_+1),a
    pop af
ret


; word WriteVram(word vram, byte c);
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


ext dotOffset_, topY_, yMod_

; void UpdateOffset();
cseg
UpdateOffset_: public UpdateOffset_
	push af | push de
        ld a,(dotOffset_)
        and a,7
        ld (HScroll_),a
	pop de | pop af
ret


ext Ground_

GroundWidth equ 20+2
GroundHeight equ 5
Bottom equ 18-2-2
Top equ Bottom-GroundHeight

; void GroundToVram();
cseg
GroundToVram_: public GroundToVram_
    push af | push hl | push de | push bc
        ld a,(NextPage_) | ld l,a
        ld a,(NextPage_+1) | ld h,a
        ld de,VramRowSize*StatusHeight | add hl,de
        ld de,VramRowSize-GroundWidth
        ld c,Top
        do
            ld b,GroundWidth
            do
                di
                    call WaitModeN1
                    ld (hl),Char_Space
                ei
                inc hl
                dec b
            while nz|wend
            add hl,de
            dec c
        while nz|wend

        ld de,Ground_
        ld c,GroundHeight
        do
            ld b,GroundWidth
            do
                ld a,(de) | inc de
                di
                    push af
                        call WaitModeN1
                    pop af
                    ld (hl),a
                ei
                inc hl
                dec b
            while nz|wend
            push de
                ld de,VramRowSize-GroundWidth | add hl,de
            pop de
            dec c
        while nz|wend

        ld de,VramRowSize-GroundWidth
        ld c,2
        do
            ld b,GroundWidth
            do
                di
                    call WaitModeN1
                    ld (hl),Char_Ground
                ei
                inc hl
                dec b
            while nz|wend
            add hl,de
            dec c
        while nz|wend
    pop bc | pop de | pop hl | pop af
    call SwitchPage_
ret


ext FortPattern
ext FortDotOffset_, FortCharOffset_

; void SetFortChars();
cseg
SetFortChars_: public SetFortChars_
    push af | push hl | push de | push bc
        ld a,(FortDotOffset_)
        add a,a
        ld h,a | ld l,0
        ld de,FortPattern | add hl,de

        ld a,(FortCharOffset_)
        or a,a
        if nz
            ld de,CharRam1+CharHeight*2*8*4
        else
            ld de,CharRam1
        endif
        ld bc,8*4*CharHeight*2
        do
            di
                call WaitModeN1
                ld a,(hl+)
                ld (de),a
            ei
            inc de
            dec bc
            ld a,c | or a,b
        while nz|wend
    pop bc | pop de | pop hl | pop af
ret