include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_

Cell_Type_Floor equ 08h
Cell_Type_LiftBottom equ 18h


cseg

; ptr<byte> VVramPtr(byte x, byte y);
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
        ld c,5
        do
            ld b,16
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