include "Vram.inc"
include "Chars.inc"

ext CellMap_
ext VAdd_

StatusHeight equ 2
StageHeight equ 22

Cell_Space equ 0
Cell_LowerMask equ 3
Cell_CrackedFloor equ 1
Cell_HardFloor equ 3
Cell_LadderDown equ 2
Cell_UpperMask equ 0ch
Cell_BrokenFloor equ 4
Cell_LadderUp equ 8
Cell_Item equ 0ch


; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        srl a
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld l,a
        ld h,0
        ld b,0
        add hl,bc
        ld bc,CellMap_
        add hl,bc
    pop bc | pop af
ret


; word DrawCell(word vram, byte b, byte y);
cseg
DrawCell_: public DrawCell_
    push af | push hl | push de | push bc
        ld a,c
        sub StatusHeight
        exx
            ld e,a
        exx
        ld c,e

        ld a,c
        and Cell_UpperMask
        cp Cell_BrokenFloor
        if z
            ld de,Char_Space shl 8 or Char_Space
            ld b,3
            call DrawCell_Rows
            ld de,(Char_CrackedFloor+7) shl 8 or (Char_CrackedFloor+6)
            call DrawCell_Row
            jp DrawCell_exit
        endif
        cp Cell_Item
        if z
            ld de,Char_Space shl 8 or Char_Space
            call DrawCell_Row
            ld de,(Char_Item+1) shl 8 or (Char_Item+0)
            call DrawCell_Row
            ld de,(Char_Item+3) shl 8 or (Char_Item+2)
            call DrawCell_Row
            ld de,Char_HardFloor shl 8 or Char_HardFloor
            call DrawCell_Row
            jp DrawCell_exit
        endif
        cp Cell_LadderUp
        if z
            ld de,Char_Ladder_Right shl 8 or Char_Ladder_Left
            ld b,3
            call DrawCell_Rows
            ld a,c
            and Cell_LowerMask
            cp Cell_LadderDown
            if nz
                ld de,Char_HardFloor shl 8 or Char_HardFloor
            endif
            call DrawCell_Row
            jp DrawCell_exit
        endif
        ld de,Char_Space shl 8 or Char_Space
        ld b,2
        call DrawCell_Rows

        ld a,c
        and Cell_LowerMask
        cp Cell_LadderDown
        if z
            ld de,Char_Ladder_Right shl 8 or Char_Ladder_Left
            ld b,2
            call DrawCell_Rows
            jp DrawCell_exit
        endif
        ld de,Char_Space shl 8 or Char_Space
        call DrawCell_Row

        ld a,c
        and Cell_LowerMask
        cp Cell_CrackedFloor
        if z
            ld de,(Char_CrackedFloor+1) shl 8 or (Char_CrackedFloor+0)
        else
            cp Cell_HardFloor
            if z
                ld de,Char_HardFloor shl 8 or Char_HardFloor
            endif
        endif
        call DrawCell_Row
        
        DrawCell_exit:
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret
DrawCell_Row:
    exx
        ld a,e
    exx

    cp StageHeight
    if c
        call VAdd_
        ld a,e | ld e,d
        call VAdd_
        ld e,a
        
        ld a,l | add a,VramRowSize-2 | ld l,a
        ld a,h | adc a,0 | ld h,a
    else
        ld a,l | add a,VramRowSize | ld l,a
        ld a,h | adc a,0 | ld h,a
    endif

    exx
        inc e
    exx
ret    
DrawCell_Rows:
    do
        call DrawCell_Row
    dwnz
ret
