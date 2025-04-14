include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push de
        ld d,0
        ld l,e
        ld h,d
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld e,a
        ld d,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret


ColumnCount equ 12
FloorCount equ 4
ColumnWidth equ 2
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
        ld hl,VVram_-VVramWidth*2
        exx
            ld e,-2 ; y
        exx
        ld c,FloorCount
        do
            ld b,ColumnCount
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        ld c,a
                        exx
                            ld a,e
                        exx
                        cp VVramHeight
                        if c
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
                        else
                            ld de,VVramWidth*2
                            add hl,de
                        endif
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
            exx
                inc e | inc e | inc e | inc e
            exx
            dec c
        while nz | wend

        ld bc,(ColumnWidth*ColumnCount shl 8) or Char_Floor
        do
            ld (hl),c | inc hl
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
