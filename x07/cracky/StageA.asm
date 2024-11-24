include "VVram.inc"

ext CellMap_, VVram_

ColumnCount equ 12
FloorCount equ 4
ColumnsPerByte equ 2
FloorHeight equ 4

Cell_Space equ 0
Cell_LowerMask equ 3
Cell_CrackedFloor equ 1
Cell_HardFloor equ 3
Cell_LadderDown equ 2
Cell_UpperMask equ 0ch
Cell_BrokenFloor equ 4
Cell_LadderUp equ 8
Cell_Item equ 0ch

Char_Space equ 0
Char_ItemLT equ 60h
Char_ItemRT equ 90h
Char_ItemLB equ 90h
Char_ItemRB equ 60h
Char_HoleL equ 80h 
Char_HoleR equ 00h
Char_HardFloor equ 0f0h
Char_LadderL equ 0e0h
Char_LadderR equ 0d0h
Char_CrackL equ 0e0h
Char_CrackR equ 70h


; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        srl a
        ld c,a
        ld a,e
        add a,a ;*2
        add a,e ;*3
        add a,a ;*6
        ld l,a
        ld h,0
        ld b,0
        add hl,bc
        ld bc,CellMap_
        add hl,bc
    pop bc | pop af
ret


; void MapToVVram();
cseg
MapToVVram_Row:
    ld (hl),e | inc hl
    ld (hl),d
    ld a,l | add a,VVramWidth-1 | ld l,a
    ld a,h | adc a,0 | ld h,a
ret    
MapToVVram_Rows:
    do
        call MapToVVram_Row
    dwnz
ret
MapToVVram_: public MapToVVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld de,CellMap_
        ld c,FloorCount
        do
            ld b,ColumnCount/ColumnsPerByte
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        ld c,a
                        ld b,ColumnsPerByte
                        do
                            push bc
                                ld a,c
                                and Cell_UpperMask
                                cp Cell_BrokenFloor
                                if z
                                    ld de,Char_Space shl 8 or Char_Space
                                    ld b,3
                                    call MapToVVram_Rows
                                    ld de,Char_HoleR shl 8 or Char_HoleL
                                    call MapToVVram_Row
                                    jp nextColumn
                                endif
                                cp Cell_Item
                                if z
                                    ld de,Char_Space shl 8 or Char_Space
                                    call MapToVVram_Row
                                    ld de,Char_ItemRT shl 8 or Char_ItemLT
                                    call MapToVVram_Row
                                    ld de,Char_ItemRB shl 8 or Char_ItemLB
                                    call MapToVVram_Row
                                    ld de,Char_HardFloor shl 8 or Char_HardFloor
                                    call MapToVVram_Row
                                    jp nextColumn
                                endif
                                cp Cell_LadderUp
                                if z
                                    ld de,Char_LadderR shl 8 or Char_LadderL
                                    ld b,3
                                    call MapToVVram_Rows
                                    ld a,c
                                    and Cell_LowerMask
                                    cp Cell_LadderDown
                                    if nz
                                        ld de,Char_HardFloor shl 8 or Char_HardFloor
                                    endif
                                    call MapToVVram_Row
                                    jp nextColumn
                                endif
                                ld de,Char_Space shl 8 or Char_Space
                                ld b,2
                                call MapToVVram_Rows
                                
                                ld a,c
                                and Cell_LowerMask
                                cp Cell_LadderDown
                                if z
                                    ld de,Char_LadderR shl 8 or Char_LadderL
                                    ld b,2
                                    call MapToVVram_Rows
                                    jp nextColumn
                                endif
                                ld de,Char_Space shl 8 or Char_Space
                                call MapToVVram_Row

                                ld a,c
                                and Cell_LowerMask
                                cp Cell_CrackedFloor
                                if z
                                    ld de,Char_CrackR shl 8 or Char_CrackL
                                else
                                    cp Cell_HardFloor
                                    if z
                                        ld de,Char_HardFloor shl 8 or Char_HardFloor
                                    endif
                                endif
                                call MapToVVram_Row

                                nextColumn:
                                ld de,-VVramWidth*FloorHeight+2
                                add hl,de
                            pop bc
                            srl c | srl c | srl c | srl c
                        dwnz
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth*(FloorHeight-1)
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
