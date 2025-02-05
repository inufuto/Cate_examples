include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push de
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            add hl,hl ;*32
        ex de,hl
        ld l,a
        ld h,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret

ColumnCount equ 16
FloorCount equ 6
FloorHeight equ 4

Cell_Down equ 1
Cell_Up equ 2
Cell_Block equ 8
Cell_Ceiling equ 4
Cell_Item equ 4

; void DrawBackground();
cseg
FloorChars:
    defb Char_Floor, Char_Floor, Char_Space, Char_Space
LadderChars:
    defb Char_Ladder+0, Char_Ladder+1, Char_Ladder+0, Char_Ladder+1
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc
        ld de,CellMap_
        ld hl,VVram_
        ld c,FloorCount
        do
            ld b,ColumnCount
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        ld c,a
                        ld a,c | and Cell_Block
                        if nz
                            ld a,Char_Block
                            call VPut2C
                            jr lower
                        endif
                        ld a,c | and Cell_Ceiling
                        if nz
                            ld de,FloorChars
                            call VPut2S
                            jr lower
                        endif
                        ld a,c | and Cell_Down or Cell_Up
                        if nz
                            ld de,LadderChars
                            call VPut2S
                            jr lower
                        endif
                        call VErase2
                        lower:
                        srl c | srl c | srl c | srl c

                        ld a,c | and Cell_Block
                        if nz
                            ld a,Char_Block
                            call VPut2C
                            jr next
                        endif
                        ld a,c | and Cell_Item
                        if nz
                            ld a,Char_Item
                            call VPut2C
                            jr next
                        endif
                        ld a,c | and Cell_Down or Cell_Up
                        if nz
                            ld de,LadderChars
                            call VPut2S
                            jr next
                        endif
                        call VErase2
                        next:

                        ld de,2-VVramWidth*4
                        add hl,de
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth*(4-1)
                add hl,de
            pop de
            dec c
        while nz | wend
        ld a,Char_Floor
        ld b,VVramWidth
        do
            ld (hl),a | inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret
VPut2C:
    push de | push bc
        ld c,2
        do
            ld b,2
            do
                ld (hl),a | inc hl
                inc a
            dwnz
            ld de,VVramWidth-2
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de
ret
VPut2S:
    push bc
        ld c,2
        do
            ld b,2
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push de
                ld de,VVramWidth-2
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc
ret
VErase2:
    push de | push bc
        xor a
        ld c,2
        do
            ld b,2
            do
                ld (hl),a | inc hl
            dwnz
            ld de,VVramWidth-2
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de
ret
