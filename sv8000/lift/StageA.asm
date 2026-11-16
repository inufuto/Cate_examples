include "Vram.inc"
include "Chars.inc"

ext Put_
ext CellMap_

Cell_Type_Floor equ 08h
Cell_Type_LiftBottom equ 18h


; DrawBackGround();
DrawBackGround_: public DrawBackGround_
    push af | push hl | push de | push bc
        ld hl,Vram+VramRowSize*StatusHeight
        ld e,Char_Roof_Left | call Put_
        ld e,Char_Roof_Center
        ld b,VramWidth-2
        do
            call Put_
        dwnz
        ld e,Char_Roof_Right | call Put_

        ld de,VramRowSize-VramWidth | add hl,de
        ld e,Char_Roof_Center
        ld b,VramWidth
        do
            call Put_
        dwnz

        ld de,VramRowSize-VramWidth | add hl,de
        ld de, CellMap_
        ld c,5
        do
            ld b,16
            do
                push bc
                    xor a
                    ld b,3
                    do
                        push de
                            ld e,Char_Space
                            call Put_
                            call Put_
                            ld de,VramRowSize-2 | add hl,de
                        pop de
                    dwnz

                    ld a,(de) | inc de
                    push de
                        and Cell_Type_LiftBottom
                        cp Cell_Type_LiftBottom
                        if z
                            ld e,Char_LiftBottom
                        else
                            and Cell_Type_Floor
                            if nz
                                ld e,Char_Floor
                            else
                                ld e,Char_Space
                            endif
                        endif
                        call Put_
                        call Put_
                        ld de,-VramRowSize*3 | add hl,de
                    pop de
                pop bc
            dwnz
            push de
                ld de,VramRowSize*4-VramWidth | add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret