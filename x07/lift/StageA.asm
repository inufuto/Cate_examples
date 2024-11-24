include "VVram.inc"

ext CellMap_
ext VVram_

Cell_Type_Floor equ 08h
Cell_Type_LiftBottom equ 18h

FloorCount equ 3
ColumnCount equ 12
StageTop equ 2


; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        srl a ; /2
        ld c,a

        ld a,e
        sub StageTop
        srl a ; /2
        srl a ; /4
        ld b,a
        add a,a ;*2
        add a,b ;*3
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


Char_Space equ 00h
Char_Roof_Left equ 10h
Char_Roof_Right equ 20h
Char_Roof_Center equ 0f0h
Char_LiftBottom equ 0f0h
Char_Floor equ 0c0h

; DrawBackGround();
DrawBackGround_: public DrawBackGround_
    push af | push hl | push de | push bc
        ld hl, VVram_
        ld (hl),Char_Roof_Left | inc hl
        ld bc,(VVramWidth-2)*100h+Char_Roof_Center
        do
            ld (hl),c | inc hl
        dwnz
        ld (hl),Char_Roof_Right | inc hl
        ld b,VVramWidth
        do
            ld (hl),c | inc hl
        dwnz

        ld de, CellMap_
        ld c,3
        do
            ld b,12
            do
                push bc
                    xor a
                    ld b,3
                    do
                        ld (hl),a | inc hl
                        ld (hl),a | inc hl
                        push de
                            ld de,VVramWidth-2
                            add hl,de
                        pop de
                    dwnz

                    ld a,(de) | inc de
                    and Cell_Type_LiftBottom
                    cp Cell_Type_LiftBottom
                    if z
                        ld a,Char_LiftBottom
                    else
                        and Cell_Type_Floor
                        if nz
                            ld a,Char_Floor
                        else
                            xor a
                        endif
                    endif
                    ld (hl),a | inc hl
                    ld (hl),a | inc hl
                    ld bc,-VVramWidth*3
                    add hl,bc
                pop bc
            dwnz
            push de
                ld de,VVramWidth*3
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
