include "VVram.inc"
include "Chars.inc"

ext CellMap_
ext VVram_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push bc
        srl a | ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        ld l,a
        ld h,0
        ld b,0
        add hl,bc
        ld bc,CellMap_
        add hl,bc
    pop bc | pop af
ret

Cell_RightWall equ 01h
Cell_BottomWall equ 02h
Cell_Dot equ 04h
Cell_Food equ 08h
ColumnCount equ 10
RowCount equ 7
ColumnWidth equ 3
RowHeight equ 3
; Char_Wall equ Char_Logo+15

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld a,Char_Wall
        ld b,ColumnWidth*ColumnCount+1
        do
            ld (hl),a | inc hl
        dwnz
        ld a,Char_Space
        ld (hl),a | inc hl

        ld de,CellMap_
        ld c,RowCount
        do
            push de
                ld de,VVramWidth
                ld a,Char_Wall
                ld b,RowHeight
                do
                    ld (hl),a
                    add hl,de
                dwnz
                ld de,1-VVramWidth*RowHeight
                add hl,de
            pop de
            
            ld b,ColumnCount/2
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        ld c,2
                        do
                            ld b,a
                            push bc
                                ld de,VVramWidth-2
                                ld c,a
                                and 0ch
                                cp Cell_Food
                                if z
                                    ld a,Char_Food
                                    jr put2c
                                endif
                                cp Cell_Dot
                                if z
                                    ld a,Char_Dot
                                    put2c:
                                    push bc
                                        ld c,2
                                        do
                                            ld b,2
                                            do
                                                ld (hl),a | inc hl
                                                inc a
                                            dwnz
                                            add hl,de
                                            dec c
                                        while nz | wend
                                    pop bc
                                    jr nextCell
                                endif
                                ld a,Char_Space
                                push bc
                                    ld c,2
                                    do
                                        ld b,2
                                        do
                                            ld (hl),a | inc hl
                                        dwnz
                                        add hl,de
                                        dec c
                                    while nz | wend
                                pop bc
                                nextCell:
                                    _deb: public _deb
                                ld de,2-VVramWidth*2
                                add hl,de

                                ld a,c
                                and Cell_RightWall
                                if nz
                                    ld a,Char_Wall
                                else
                                    ld a,Char_Space
                                endif
                                ld de,VVramWidth
                                ld b,2
                                do
                                    ld (hl),a
                                    add hl,de
                                dwnz
                                dec hl | dec hl

                                ld a,c
                                and Cell_BottomWall
                                if nz
                                    ld a,Char_Wall
                                else
                                    ld a,Char_Space
                                endif
                                ld b,2
                                do
                                    ld (hl),a | inc hl
                                dwnz
                                ld (hl),Char_Wall

                                ld de,1-VVramWidth*2
                                add hl,de
                            pop bc
                            ld a,b
                            rrca | rrca | rrca | rrca
                            dec c
                        while nz | wend
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth*2+1
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
