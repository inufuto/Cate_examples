include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext StageMap_

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


; void DrawFloor(byte y, word vram, ptr<byte> pMap);
cseg
DrawFloor_: public DrawFloor_
    push af | push hl | push de | push bc
        exx
            ld e,a ;yPos
        exx
        set 6,d
        ld a,ColumnCount
        do
            push af
                ld a,(bc) | inc bc
                push bc
                    push af
                        rrca | rrca | rrca | rrca
                        call DrawCell
                    pop af
                    call DrawCell
                    ld a,e | add a,low(ColumnWidth-VramRowSize*FloorHeight) | ld e,a
                    ld a,d | adc a,high(ColumnWidth-VramRowSize*FloorHeight) | ld d,a
                    exx
                        dec e | dec e | dec e | dec e
                    exx
                pop bc
            pop af
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
DrawCell:
    call CharsPtr
    ld b,RowHeight
    do
        exx
            ld a,e
        exx
        cp VramHeight-StatusHeight
        if c
            di
                ld a,e | ld (VdpAddress+2),a
                ld a,d | ld (VdpAddress+2),a
                ld a,(hl) | inc hl
                ld (VdpAddress),a | nop
                ld a,(hl) | inc hl
                ld (VdpAddress),a
            ei
        else
            inc hl | inc hl
        endif
        ld a,e | add a,VramRowSize | ld e,a
        ld a,d | adc a,0 | ld d,a
        exx
            inc e
        exx
    dwnz
ret
CharsPtr:
    and 07h
    add a,a ;*2
    add a,a ;*4
    ld l,a | ld h,0
    ld bc,CellChars | add hl,bc
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


; void DrawFloorShift(byte y, word vram, ptr<byte> pMap);
cseg
DrawFloorShift_: public DrawFloorShift_
    push af | push hl | push de | push bc
        exx
            ld e,a ;yPos
        exx
        set 6,d

        ld a,(bc) | inc bc
        exx
            ld d,a
        exx
        push bc
            push af
                rrca | rrca | rrca | rrca
                call DrawCellRight
            pop af
            call DrawCellRight
            ld a,e | add a,low(ColumnWidth/2-VramRowSize*FloorHeight) | ld e,a
            ld a,d | adc a,high(ColumnWidth/2-VramRowSize*FloorHeight) | ld d,a
            exx
                dec e | dec e | dec e | dec e
            exx
        pop bc
        ld a,ColumnCount-1
        do
            push af
                ld a,(bc) | inc bc
                push bc
                    push af
                        rrca | rrca | rrca | rrca
                        call DrawCell
                    pop af
                    call DrawCell
                    ld a,e | add a,low(ColumnWidth-VramRowSize*FloorHeight) | ld e,a
                    ld a,d | adc a,high(ColumnWidth-VramRowSize*FloorHeight) | ld d,a
                    exx
                        dec e | dec e | dec e | dec e
                    exx
                pop bc
            pop af
            dec a
        while nz | wend
        exx
            ld a,d
        exx
        push af
            rrca | rrca | rrca | rrca
            call DrawCellLeft
        pop af
        call DrawCellLeft
        ld a,e | add a,low(ColumnWidth/2-VramRowSize*FloorHeight) | ld e,a
        ld a,d | adc a,high(ColumnWidth/2-VramRowSize*FloorHeight) | ld d,a
        exx
            dec e | dec e | dec e | dec e
        exx
    pop bc | pop de | pop hl | pop af
ret
DrawCellRight:
    call CharsPtr
    ld b,RowHeight
    do
        exx
            ld a,e
        exx
        cp VramHeight-StatusHeight
        if c
            di
                ld a,e | ld (VdpAddress+2),a
                ld a,d | ld (VdpAddress+2),a
                inc hl
                ld a,(hl) | inc hl
                ld (VdpAddress),a
            ei
        else
            inc hl | inc hl
        endif
        ld a,e | add a,VramRowSize | ld e,a
        ld a,d | adc a,0 | ld d,a
        exx
            inc e
        exx
    dwnz
ret
DrawCellLeft:
    call CharsPtr
    ld b,RowHeight
    do
        exx
            ld a,e
        exx
        cp VramHeight-StatusHeight
        if c
            di
                ld a,e | ld (VdpAddress+2),a
                ld a,d | ld (VdpAddress+2),a
                ld a,(hl) | inc hl
                ld (VdpAddress),a
                inc hl
            ei
        else
            inc hl | inc hl
        endif
        ld a,e | add a,VramRowSize | ld e,a
        ld a,d | adc a,0 | ld d,a
        exx
            inc e
        exx
    dwnz
ret


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
