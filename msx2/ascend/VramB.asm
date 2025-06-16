include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext pStage_, StageMap_, topRow_, yMod_
ext DrawBlocks_
ext DspPage,WrtPage

VisibleFloorCount equ (WindowHeight+FloorHeight-1)/FloorHeight+1
FloorHeight equ 4
ColumnCount equ 16
MapWidth equ ColumnCount/4

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3

; void MapToVram();
cseg
Repeat: public Repeat
    push af | push bc
        ld a,(VdpOutPort) | ld c,a
        do
            exx
                ld a,e
                inc e
            exx
            cp WindowHeight
            if c
                di
                    inc c
                    ld a,l | out (c),a
                    ld a,h | out (c),a
                    dec c
                    out (c),d
                    push af | pop af
                    out (c),e
                ei
            endif
            push de
                ld de,VramRowSize
                add hl,de
            pop de
        dwnz
    pop bc | pop af
ret

MapToVram_: public MapToVram_
    push af | push hl | push de | push bc | push ix | push iy
        ld iy,(pStage_)
        ld a,(topRow_)
        exx
            ld d,a ; row
        exx
        or a
        if p
            ld ix,StageMap_
            add a,a ;*2
            add a,a ;*4
            ld e,a
            ld d,0
            add ix,de ; pMap
        else
            ld ix,StageMap_-MapWidth
        endif
        ld a,(WrtPage) | ld h,a
        ld l,low VramTop
        exx
            ld a,(yMod_)
            or a
            if nz
                neg
            endif
            ld e,a
        exx
        ld de,-VramRowSize
        do
            or a
        while m
            add hl,de
            inc a
        wend
        ld c,VisibleFloorCount
        do
            ld b,MapWidth
            do
                push bc
                    exx
                        ld a,d ; row
                        or a
                        if p
                            ld h,(ix) ; here
                            inc a
                            cp (iy+0)
                            if c
                                ld l,(ix+MapWidth) ; lower
                            else
                                ld l,0
                            endif
                        else
                            ld h,0 ; here
                            ld l,(ix+MapWidth) ; lower
                        endif
                    exx
                    inc ix
                    ld c,4
                    do
                        exx
                            ld a,h ; here
                        exx
                        and 3
                        or a ; CellType_Space
                        if z
                            ld de,(Char_Space shl 8) or Char_Space
                            ld b,1
                            call Repeat
                            exx
                                ld a,l ; lower
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
                                    ld a,l ; lower
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
                                        ld a,l ; lower
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
                        ld de,-VramRowSize*4+2
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
            ld de,VramRowSize*(4-1)
            add hl,de
            exx
                inc d
                inc e | inc e | inc e | inc e
            exx
            dec c
        while nz | wend

        call DrawBlocks_

        ld a,(WrtPage)
        and 04h
        if z
            ld hl,4410h
        else
            ld hl,4011h
        endif
        ld (DspPage),hl
    pop iy | pop ix | pop bc | pop de | pop hl | pop af
ret
