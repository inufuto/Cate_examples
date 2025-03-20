include "vgszero.inc"
include "Vram.inc"
include "Chars.inc"

ext CellMap_,LeftX_,DotOffset_

dseg
HScroll_: public HScroll_
    defb 0

cseg
PaletteValues:
	defb	00h, 00h, 1fh, 00h, 00h, 7ch, 7bh, 6eh
	defb	0e0h, 03h, 0ffh, 03h, 0e0h, 7fh, 0ffh, 7fh
	defb	00h, 00h, 0efh, 3dh, 60h, 6eh, 6bh, 5dh
	defb	0e0h, 01h, 73h, 01h, 67h, 7fh, 0f7h, 5eh
InitVram: public InitVram
    ld hl,PaletteValues
    ld de,PaletteTable
    ld bc,16*2
    ldir

    ld a,PatternBank
    ld (BgDirectPatternMapping),a
    ld (FgDirectPatternMapping),a
    ld (SpriteDirectPatternMapping),a
ret


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearA:
    do
        ld (hl),80h | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,BgNameTable
        ld bc,32*32
        call Clear

        ld hl,FgNameTable
        ld bc,32*32
        call Clear

        ld hl,BgAttribute
        ld bc,32*32
        call ClearA

        ld hl,FgAttribute
        ld bc,32*32
        call ClearA
    pop bc | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    ld (hl),e
    inc hl
ret


; word VramOffset(byte x, byte y);
VramOffset_: public VramOffset_
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
    pop de
ret


ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
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
	defb Char_Item+0,Char_Item+1
	defb Char_Item+2,Char_Item+3
	defb Char_Floor,Char_Floor
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle,Char_Needle
	defb Char_Floor,Char_Floor

; void MapToVram();
cseg
MapToVram_: public MapToVram_
    push af | push hl | push de | push bc
        ld a,(LeftX_)
        rrca
        ld c,a
            rrca
            rrca
            and 1fh
            ld e,a | ld d,0
            ld hl,CellMap_
            add hl,de
        ld a,c
        and 3
        ld c,a
        exx
            ld hl,VramBack+VramRowSize*4
        exx
        
        ld b,FloorCount
        do
            push hl | push bc
                ld e,(hl) | inc hl

                ld a,c
                ld c,4 ; shift count
                or a
                do | while nz
                    srl e | srl e
                    dec c
                    dec a
                wend

                ld b,VramWidth/2
                do
                    ld a,e
                    push hl | push de | push bc
                        and 03h
                        ld l,a | ld h,0
                        add hl,hl ;*2
                        add hl,hl ;*4
                        add hl,hl ;*8
                        ld de,CellChars
                        add hl,de
                        ld c,FloorHeight
                        do
                            ld b,2
                            do
                                ld a,(hl) | inc hl
                                exx
                                    ld (hl),a | inc hl
                                exx
                            dwnz
                            exx
                                ld de,VramRowSize-2 | add hl,de
                            exx
                            dec c
                        while nz | wend
                        exx
                            ld de,-VramRowSize*FloorHeight+2
                            add hl,de
                        exx
                    pop bc | pop de | pop hl
                    srl e | srl e
                    dec c
                    if z
                        ld e,(hl) | inc hl
                        ld c,4 ; shift count
                    endif
                dwnz
                exx
                    ld de,VramRowSize*FloorHeight-VramWidth
                    add hl,de
                exx
                ld a,c
                cp 4
                if z
                    dec hl
                endif
            pop bc | pop hl
            ld de,MapWidth
            add hl,de
        dwnz

        call UpdateScroll_
        ld a,(HScroll_)
        ld (BgScrollX),a
    pop bc | pop de | pop hl | pop af
ret


; void UpdateScroll();
cseg
UpdateScroll_: public UpdateScroll_
    push af | push bc
        ld a,(LeftX_)
        rlca | rlca | rlca
        and 8
        ld c,a

        ld a,(DotOffset_)
        add a,c
        sub 8
        ld (HScroll_),a
    pop bc | pop af
ret
