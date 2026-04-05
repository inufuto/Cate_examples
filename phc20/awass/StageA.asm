include "VVram.inc"
include "Chars.inc"

ext StageMap_
ext Scrolling_,ScrollingFloor_
ext VVram_

ColumnCount equ 16
FloorCount equ 6
ColumnWidth equ 2
FloorHeight equ 4
RowHeight equ FloorHeight/2

; ptr<byte> MapPtr(byte column, byte floor);
cseg
MapPtr_: public MapPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        add a,a ;*16
        add a,c
        ld l,a | ld h,0
        ld bc,StageMap_
        add hl,bc
    pop bc | pop af
ret


; void DrawFloors();
cseg
DrawFloors_: public DrawFloors_
    push af | push hl | push de | push bc
        exx
            ld de,(Scrolling_)
        exx
        ld de,StageMap_
        ld hl,VVram_
        ld c,0 ; floor
        do
            ld a,c
            exx
                cp d ; ScrollingFloor
            exx
            jr nz,noShift
            exx
                ld a,e ; Scrolling_
            exx
            or a
            if nz
                            _deb: public _deb
                ld a,(de) | inc de
                push de
                    exx
                        ld c,a
                    exx
                    push af
                        rrca | rrca | rrca | rrca
                        call DrawCellRight
                    pop af
                    call DrawCellRight
                pop de
                ld a,l | add a,low(ColumnWidth/2-VVramWidth*FloorHeight) | ld l,a
                ld a,h | adc a,high(ColumnWidth/2-VVramWidth*FloorHeight) | ld h,a
                ld b,ColumnCount-1
                do
                    push bc
                        ld a,(de) | inc de
                        push de
                            push af
                                rrca | rrca | rrca | rrca
                                call DrawCell
                            pop af
                            call DrawCell
                            ld a,l | add a,low(ColumnWidth-VVramWidth*FloorHeight) | ld l,a
                            ld a,h | adc a,high(ColumnWidth-VVramWidth*FloorHeight) | ld h,a
                        pop de
                    pop bc
                dwnz
                push de
                    exx
                        ld a,c
                    exx
                    push af
                        rrca | rrca | rrca | rrca
                        call DrawCellLeft
                    pop af
                    call DrawCellLeft
                    ld a,l | add a,low(ColumnWidth/2-VVramWidth*FloorHeight) | ld l,a
                    ld a,h | adc a,high(ColumnWidth/2-VVramWidth*FloorHeight) | ld h,a
                pop de
            else
                noShift:
                ld b,ColumnCount
                do
                    push bc
                        ld a,(de) | inc de
                        push de
                            push af
                                rrca | rrca | rrca | rrca
                                call DrawCell
                            pop af
                            call DrawCell
                            ld a,l | add a,low(ColumnWidth-VVramWidth*FloorHeight) | ld l,a
                            ld a,h | adc a,high(ColumnWidth-VVramWidth*FloorHeight) | ld h,a
                        pop de
                    pop bc
                dwnz
            endif
            ld a,l | add a,low(VVramWidth*FloorHeight-ColumnWidth*ColumnCount) | ld l,a
            ld a,h | adc a,high(VVramWidth*FloorHeight-ColumnWidth*ColumnCount) | ld h,a

            inc c
            ld a,c
            cp FloorCount
        while c | wend
    pop bc | pop de | pop hl | pop af
ret
DrawCell:
    call CharsPtr
    ld b,RowHeight
    do
        ld a,(de) | inc de
        ld (hl),a | inc hl
        ld a,(de) | inc de
        ld (hl),a | inc hl
        ld a,l | add a,VVramWidth-2 | ld l,a
        ld a,h | adc a,0 | ld h,a
    dwnz
ret
DrawCellRight:
    call CharsPtr
    ld b,RowHeight
    do
        inc de | ld a,(de) | inc de
        ld (hl),a
        ld a,l | add a,VVramWidth | ld l,a
        ld a,h | adc a,0 | ld h,a
    dwnz
ret
DrawCellLeft:
    call CharsPtr
    ld b,RowHeight
    do
        ld a,(de) | inc de | inc de
        ld (hl),a
        ld a,l | add a,VVramWidth | ld l,a
        ld a,h | adc a,0 | ld h,a
    dwnz
ret
CharsPtr:
    and 07h
    add a,a ;*2
    add a,a ;*4
    add a,low(CellChars) | ld e,a
    ld a,high(CellChars) | adc a,0 | ld d,a
ret
CellChars:
    defb Char_Space,Char_Space,Char_Space,Char_Space
    defb Char_Floor,Char_Floor,Char_Space,Char_Space
    defb Char_Ladder,Char_Ladder+1,Char_Ladder,Char_Ladder+1
    defb Char_Bomb,Char_Bomb+1,Char_Bomb+2,Char_Bomb+3
    defb Char_Flag_A,Char_Flag_A+1,Char_Flag_A+2,Char_Flag_A+3
    defb Char_Flag_B,Char_Flag_B+1,Char_Flag_B+2,Char_Flag_B+3
    defb Char_Flag_C,Char_Flag_C+1,Char_Flag_C+2,Char_Flag_C+3
    defb Char_Flag_D,Char_Flag_D+1,Char_Flag_D+2,Char_Flag_D+3


; void RollRight(ptr<byte> pMap);
cseg
RollRight_: public RollRight_
    push af | push hl | push de | push bc
        ld bc,ColumnCount-1
        add hl,bc
        ld a,(hl)
        ld e,l | ld d,h
        dec hl
        lddr
        ld (de),a
    pop bc | pop de | pop hl | pop af
ret


; void RollLeft(ptr<byte> pMap);
cseg
RollLeft_: public RollLeft_
    push af | push hl | push de | push bc
        ld a,(hl)
        ld e,l | ld d,h
        inc hl
        ld bc,ColumnCount-1
        ldir
        ld (de),a
    pop bc | pop de | pop hl | pop af
ret
