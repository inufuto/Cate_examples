include "VVram.inc"
include "Chars.inc"

ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        add a,a ;*10
        ld l,a | ld h,0
        ld b,0
        add hl,bc
        ld bc,CellMap_
        add hl,bc
    pop bc | pop af
ret


ext VVram_

ColumnCount equ 10
RowCount equ 7
CellSize equ 3
Bit_RightWall equ 0
Bit_BottomWall equ 1
Bit_LeftWall equ 4
Bit_TopWall equ 5
Cell_TypeMask equ 0ch

; void MapToVVram();
cseg
Chars:
    defb Char_Space, Char_Space, Char_Space, Char_Space
    defb  Char_StairUp, Char_StairUp + 1, Char_StairUp + 2, Char_StairUp + 3
    defb  Char_StairDown, Char_StairDown + 1, Char_StairDown + 2, Char_StairDown + 3
    defb  Char_Goal, Char_Goal + 1, Char_Goal + 2, Char_Goal + 3
WallA:
    or a
    if p
        ld a,Char_Space
    else
        ld a,Char_Wall
    endif
ret
LeftEnd:
    ld a,(de)
    call WallA
    ld de,VVramWidth
    ld b,CellSize
    do
        ld (hl),a
        add hl,de
    dwnz
ret
MapToVVram_: public MapToVVram_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld bc,((1+CellSize*ColumnCount) shl 8) or Char_Space
        do
            ld (hl),c | inc hl
        dwnz
        ld de,-(1+CellSize*ColumnCount) | add hl,de

        ld de,CellMap_
        ld c,RowCount
        do
            push de
                ld de,VVramWidth
                ld b,1+CellSize
                do
                    ld (hl),Char_Space
                    add hl,de
                dwnz
                ld de,-VVramWidth*(CellSize+1) | add hl,de
            pop de
            ld b,ColumnCount
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        or a
                        if m
                            ld (hl),Char_Wall | inc hl
                            bit Bit_TopWall,a
                            if nz
                                ld c,Char_Wall
                            else
                                ld c,Char_Space
                            endif
                            ld b,CellSize-1
                            do
                                ld (hl),c | inc hl
                            dwnz
                            ld (hl),Char_Wall
                            ld de,VVramWidth-CellSize | add hl,de
                            bit Bit_LeftWall,a
                            if nz
                                ld c,Char_Wall
                            else
                                ld c,Char_Space
                            endif
                            ld de,VVramWidth
                            ld b,CellSize-1
                            do
                                ld (hl),c
                                add hl,de
                            dwnz
                            ld de,1-VVramWidth*(CellSize-1) | add hl,de
                            push af
                                and Cell_TypeMask
                                ex de,hl
                                    push de
                                        ld l,a | ld h,0
                                        ld de,Chars | add hl,de
                                    pop de
                                ex de,hl
                                ld b,CellSize-1
                                do
                                    ld a,(de) | inc de
                                    ld (hl),a | inc hl
                                    ld a,(de) | inc de
                                    ld (hl),a
                                    push de
                                        ld de,VVramWidth-1 | add hl,de
                                    pop de
                                dwnz
                                ld de,CellSize-1-VVramWidth*(CellSize-1) | add hl,de
                            pop af
                            bit Bit_RightWall,a
                            if nz
                                ld c,Char_Wall
                            else
                                ld c,Char_Space
                            endif
                            ld de,VVramWidth
                            ld b,CellSize-1
                            do
                                ld (hl),c
                                add hl,de
                            dwnz
                            ld de,-CellSize | add hl,de
                            ld (hl),Char_Wall | inc hl
                            bit Bit_BottomWall,a
                            if nz
                                ld c,Char_Wall
                            else
                                ld c,Char_Space
                            endif
                            ld b,CellSize-1
                            do
                                ld (hl),c | inc hl
                            dwnz
                            ld (hl),Char_Wall
                            ld de,-VVramWidth*CellSize | add hl,de
                        else
                                            _deb: public _deb
                            ld de,VVramWidth+1 | add hl,de
                            ld de,VVramWidth-CellSize
                            ld c,CellSize
                            do
                                ld b,CellSize
                                do
                                    ld (hl),Char_Space | inc hl
                                dwnz
                                add hl,de
                                dec c
                            while nz | wend
                            ld de,CellSize-1-VVramWidth*(CellSize+1) | add hl,de
                        endif
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth*CellSize-(CellSize*ColumnCount) | add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
