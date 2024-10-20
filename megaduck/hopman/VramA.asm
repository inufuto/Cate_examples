include "MegaDuck.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext CellMap_,LeftX_,DotOffset_
ext HScroll_

Mode equ LCDCF_OBJ16 or LCDCF_OBJON or LCDCF_BGON
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

        xor a,a | ld (HScroll_),a
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
        ei
        set 2,h
        di
            call WaitModeN1
            ld (hl),e
        ei
        res 2,h
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


ColumnCount equ 12*8
FloorCount equ 3
FloorHeight equ 4
CellWidth equ 2
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

cseg
CellChars:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor,Char_Floor
	; 2
	defb Char_Space,Char_Space
	defb Char_Item+0,Char_Item+2
	defb Char_Item+1,Char_Item+3
	defb Char_Floor,Char_Floor
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle,Char_Needle
	defb Char_Floor,Char_Floor

; void MapToVram();
dseg
xMod:
    defb 0
cellByte:
    defb 0
cseg
MapToVram_: public MapToVram_
    push af | push hl | push de | push bc
        ld a,(NextPage_) | ld l,a
        ld a,(NextPage_+1) | ld h,a
        ld de,VramRowSize*(StatusHeight+StageTop) | add hl,de
        ; ld de,VramRowSize-WindowWidth
        ; ld c,StageTop
        ; do
        ;     ld b,WindowWidth
        ;     do
        ;         call WaitModeN1
        ;         ld (hl),Char_Space | inc hl
        ;         dec b
        ;     while nz|wend
        ;     add hl,de
        ;     dec c
        ; while nz|wend

        ld a,(LeftX_)
        rrca | rrca | rrca | and a,1fh
        add a,low CellMap_ | ld e,a
        ld a,high CellMap_ | adc a,0 | ld d,a

        ld c,FloorCount
        do
            push de
                ld a,(LeftX_) | rrca | and a,3 | ld (xMod),a
                ld b,a
                ld a,(de) | inc de
                inc b
                do
                    dec b
                while nz
                    rrca | rrca
                wend
                ld (cellByte),a

                ld b,WindowWidth/2
                do
                    push de | push bc
                        ld a,(cellByte) | and a,3
                        rlca | rlca | rlca
                        add a,low CellChars | ld e,a
                        ld a,high CellChars | adc a,0 | ld d,a

                        ld c,FloorHeight
                        do
                            ld b,CellWidth
                            do
                                push bc
                                    ld a,(de) | inc de
                                    ld c,a
                                    call WaitModeN1
                                    ld (hl),c | inc hl
                                pop bc
                                dec b
                            while nz|wend
                            push de
                                ld de,VramRowSize-2
                                add hl,de
                            pop de
                            dec c
                        while nz|wend
                        ld de,-VramRowSize*FloorHeight+2
                        add hl,de
                    pop bc | pop de
                    ld a,(cellByte)
                    rrca | rrca
                    ld (cellByte),a

                    ld a,(xMod)
                    inc a | and a,3
                    ld (xMod),a
                    if z
                        ld a,(de) | inc de
                        ld (cellByte),a
                    endif
                    dec b
                while nz|wend
                ld de,-WindowWidth+VramRowSize*FloorHeight
                add hl,de
            pop de
            ld a,e | add a,MapWidth | ld e,a
            ld a,d | adc a,0 | ld d,a

            dec c
        while nz|wend
    pop bc | pop de | pop hl | pop af
ret


; void UpdateScroll();
cseg
UpdateScroll_: public UpdateScroll_
	push af
        ld a,(DotOffset_)
        ld (HScroll_),a
	pop af
ret
