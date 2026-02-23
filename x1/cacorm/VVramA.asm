include "VVram.inc"
include "Chars.inc"

ext VVramFront_, VVramBack_
ext CellMap_
ext LineRed_
ext PollVSync_

MapWidth equ VVramWidth/2
MapHeight equ VVramHeight/2

Cell_Wall equ 10h
Cell_Item equ 20h
Cell_Mask equ 0f0h

cseg

; word VVramOffset(byte x, byte y);
VVramOffset_: public VVramOffset_
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
    pop de
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
        ld hl,VVramBack_
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
                                    call PollVSync_
                                    ld a,(de) | inc de
                                    push af
                                        or a
                                        if nz
                                            push de
                                                ld e,a
                                                ld a,(LineRed_)
                                                or a
                                                if nz
                                                    ld a,e
                                                    add a,Char_Line_Red-Char_Line_Normal
                                                    ld e,a
                                                endif
                                                ld a,e
                                            pop de
                                        endif
                                        ld (hl),a | inc hl
                                    pop af
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
                call PollVSync_
            dwnz
            push de
                ld de,VVramWidth
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void ClearFront();
cseg
ClearFront_: public ClearFront_
    push af | push hl | push bc
        ld hl,VVramFront_
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),Char_Space
            inc hl
            ; call PollVSync_
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop hl | pop af
ret
