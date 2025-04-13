include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext pStage_, StageMap_, topRow_, yMod_

WindowHeight equ VVramHeight
FloorHeight equ 4
ColumnCount equ 12
VisibleFloorCount equ (WindowHeight+FloorHeight-1)/FloorHeight+1
MapWidth equ ColumnCount/4

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3


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


cseg
Repeat:
    do
        exx
            ld a,e
            inc e
        exx
        cp VVramHeight
        if c
            ld (hl),d | inc hl
            ld (hl),e | dec hl
        endif
        push de
            ld de,VVramWidth
            add hl,de
        pop de
    dwnz
ret


; MapToBackGround();
cseg
MapToBackGround_: public MapToBackGround_
    push af | push hl | push de | push bc | push ix | push iy
        ld iy,(pStage_)
        ld a,(topRow_)
        exx
            ld d,a
        exx
        or a
        if p
            ld e,a
            add a,a ;*2
            add a,e ;*3
            ld e,a
            ld d,0
            ld ix,StageMap_
            add ix,de
        else
            ld ix,StageMap_-3
        endif
        exx
            ld a,(yMod_)
            or a
            if nz
                neg
            endif
            ld e,a
        exx
        ld hl,VVram_
        ld de,-VVramWidth
        do
            or a
        while m
            add hl,de
            inc a
        wend
        ld c,VisibleFloorCount+1
        do
            ld b,MapWidth
            do
                push bc
                    exx
                        ld a,d
                        or a
                        if p
                            ld h,(ix)
                            inc a
                            cp (iy+0)
                            if c
                                ld l,(ix+MapWidth)
                            else
                                ld l,0
                            endif
                        else
                            ld h,0
                            ld l,(ix+MapWidth)
                        endif
                    exx
                    inc ix
                    ld c,4
                    do
                        exx
                            ld a,h
                        exx
                        and 3
                        or a
                        if z
                            ld de,(Char_Space shl 8) or Char_Space
                            ld b,1
                            call Repeat
                            exx
                                ld a,l
                            exx
                            and 3
                            cp CellType_Ladder
                            if z
                                ld de,(Char_Ladder_Left shl 8) or Char_Ladder_Right
                                ld b,3
                                call Repeat
                            else
                                push af
                                    ld b,2
                                    call Repeat
                                pop af
                                cp CellType_Wall
                                if z
                                    ld de,(Char_Wall shl 8) or Char_Floor
                                else
                                    ld de,(Char_Floor shl 8) or Char_Floor
                                endif
                                ld b,1
                                call Repeat
                            endif
                        else
                            cp CellType_Ladder
                            if z
                                ld de,(Char_Ladder_Left shl 8) or Char_Ladder_Right
                                ld b,3
                                call Repeat
                                exx
                                    ld a,l
                                exx
                                and 3
                                cp CellType_Ladder
                                if z
                                    ld de,(Char_Ladder_Left shl 8) or Char_Ladder_Right
                                else
                                    cp CellType_Wall
                                    if z
                                        ld de,(Char_Wall shl 8) or Char_Floor
                                    else
                                        ld de,(Char_Floor shl 8) or Char_Floor
                                    endif
                                endif
                                ld b,1
                                call Repeat
                            else
                                cp CellType_Wall
                                if z
                                    ld de,(Char_Wall shl 8) or Char_Space
                                    ld b,3
                                    call Repeat
                                    exx
                                        ld a,l
                                    exx
                                    and 3
                                    cp CellType_Wall
                                    if z
                                        ld de,(Char_Wall shl 8) or Char_Floor
                                    else
                                        ld de,(Char_Floor shl 8) or Char_Floor
                                    endif
                                    ld b,1
                                    call Repeat
                                else
                                    ld de,(Char_Space shl 8) or Char_Space
                                    ld b,4
                                    call Repeat
                                endif
                            endif
                        endif
                        ld de,-VVramWidth*4+2
                        add hl,de
                        exx
                            srl h | srl h
                            srl l | srl l
                            dec e | dec e | dec e | dec e
                        exx
                        dec c
                    while nz | wend
                pop bc
            dwnz
            ld de,VVramWidth*(4-1)
            add hl,de
            exx
                inc d
                inc e | inc e | inc e | inc e
            exx
            dec c
        while nz | wend
    pop iy | pop ix | pop bc | pop de | pop hl | pop af
ret
