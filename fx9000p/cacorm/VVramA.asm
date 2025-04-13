include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_
ext LineRed_

MapWidth equ VVramWidth/2
MapHeight equ VVramHeight/2

Cell_Wall equ 10h
Cell_Item equ 20h
Cell_Mask equ 0f0h


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push af | push bc
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld b,0
        add hl,bc
        ld bc,VVram_
        add hl,bc
    pop bc | pop af
ret


; void MapToVVram();
cseg
LineChars:
    defb Char_Space, Char_Space, Char_Space, Char_Space ; none
    defb Char_Line_Bottom, Char_Space, Char_Line_Top, Char_Space ; left
    defb Char_Space, Char_Line_Bottom, Char_Space, Char_Line_Top ; right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_Top, Char_Line_Top ; left right
    defb Char_Line_Right, Char_Line_Left, Char_Space, Char_Space ; top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_Top, Char_Space ; top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Space, Char_Line_Top ; top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_Top, Char_Line_Top ; top left right
    defb Char_Space, Char_Space, Char_Line_Right, Char_Line_Left ; bottom
    defb Char_Line_Bottom, Char_Space, Char_Line_RightTop, Char_Line_Left ; bottom left
    defb Char_Space, Char_Line_Bottom, Char_Line_Right, Char_Line_LeftTop ; bottom right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom left right
    defb Char_Line_Right, Char_Line_Left, Char_Line_Right, Char_Line_Left ; bottom top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_RightTop, Char_Line_Left ; bottom top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Line_Right, Char_Line_LeftTop ; bottom top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom top left right

MapToVVram_: public MapToVVram_
    push af | push hl | push de | push bc
        exx
            ld a,(LineRed_)
            or a
            if nz
                ld e,Char_Line_Bold-Char_Line_Normal
            else
                ld e,0
            endif
        exx
        ld hl,VVram_
        ld de,CellMap_
        ld c,MapHeight
        do
            ld b,MapWidth
            do
                push bc
                    ld a,(de) | inc de
                    cp Cell_Wall
                    if z
                        ld a,Char_Block
                        jr byChar
                    endif
                    cp Cell_Item
                    if z
                        ld a,Char_Item
                        byChar:
                        push bc
                            ld c,2
                            do
                                ld b,2
                                do
                                    ld (hl),a | inc hl
                                    inc a
                                dwnz
                                push de
                                    ld de,VVramWidth-2
                                    add hl,de
                                pop de
                                dec c
                            while nz | wend
                        pop bc
                        jr nextCell
                    endif
                    and 0fh
                    add a,a
                    add a,a
                    push de
                        add a,low LineChars
                        ld e,a
                        ld a,high LineChars
                        adc a,0
                        ld d,a
                        push bc
                            ld c,2
                            do
                                ld b,2
                                do
                                    ld a,(de) | inc de
                                    or a
                                    if nz
                                        exx
                                            add a,e
                                        exx
                                    endif
                                    ld (hl),a | inc hl
                                dwnz
                                push de
                                    ld de,VVramWidth-2
                                    add hl,de
                                pop de
                                dec c
                            while nz | wend
                        pop bc
                    pop de
                    nextCell:
                    push de
                        ld de,2-VVramWidth*2
                        add hl,de
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        ld c,a

        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        ld b,0
        add hl,bc
        ld bc,CellMap_
        add hl,bc
    pop bc | pop af
ret
