include "VVram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 8
FloorCount equ 3
ColumnWidth equ 2
FloorHeight equ 4
RowHeight equ FloorHeight/2

; ptr<byte> MapPtr(byte column, byte floor);
cseg
MapPtr_: public MapPtr_
    phsw $13
        ld $10,$1 ; floor
        biu $10 ;*2
        biu $10 ;*4
        biu $10 ;*8
        ad $10,$0 ; column
        ld $11,$sx
        ldw $12,StageMap_
        adw $10,$12
    ppsw $12
rtn


cseg
CellChars:
    defb Char_Space,Char_Space,Char_Space,Char_Space
    defb Char_Floor,Char_Floor,Char_Space,Char_Space
    defb Char_Ladder,Char_Ladder+1,Char_Ladder,Char_Ladder+1
    defb Char_Bomb,Char_Bomb+1,Char_Bomb+2,Char_Bomb+3
    defb Char_Flag_A,Char_Flag_A+1,Char_Flag_A+2,Char_Flag_A+3
    defb Char_Flag_B,Char_Flag_B+1,Char_Flag_B+2,Char_Flag_B+3
    defb Char_Flag_C,Char_Flag_C+1,Char_Flag_C+2,Char_Flag_C+3
    defb Char_Flag_D,Char_Flag_D+1,Char_Flag_D+2,Char_Flag_D+3

; void DrawFloor(ptr<byte> pVVram, ptr<byte> pMap);
cseg
DrawFloor_: public DrawFloor_
    phsm $17,8
    phsm $3,4
        ld $1,ColumnCount
        cal DrawColumns
    ppsm $0,4
    ppsm $10,8
rtn

; void DrawFloorShift(ptr<byte> pVVram, ptr<byte> pMap);
cseg
DrawFloorShift_: public DrawFloorShift_
    phsm $17,8
    phsm $3,4
        ld $0,($12) | adw $12,$sy
        phs $0
            phs $0
                bid $0 | bid $0 | bid $0 | bid $0
                cal DrawCellRight
            pps $0
            cal DrawCellRight
            ldw $16,ColumnWidth/2-VVramWidth*FloorHeight | adw $10,$16

            ld $1,ColumnCount-1
            cal DrawColumns
        pps $0
        phs $0
            bid $0 | bid $0 | bid $0 | bid $0
            cal DrawCellLeft
        pps $0
        cal DrawCellLeft
    ppsm $0,4
    ppsm $10,8
rtn

DrawColumns:
    do
        ld $0,($12) | adw $12,$sy
        phs $0
            bid $0 | bid $0 | bid $0 | bid $0
            cal DrawCell
        pps $0
        cal DrawCell
        ldw $16,ColumnWidth-VVramWidth*FloorHeight | adw $10,$16
        sb $1,$sy
    while nz | wend
rtn
CharsPtr:
    an $0,7
    biu $0 | biu $0
    ld $14,$0
    ld $15,$sx
    ldw $16,CellChars | adw $14,$16
    pre ix,$14
rtn
DrawCell:
    cal CharsPtr
    ld $2,RowHeight
    do
        pre iz,$10
        ld $3,ColumnWidth
        do
            ldi $0,(ix+$sx)
            sti $0,(iz+$sx)
            sb $3,$sy
        while nz | wend
        ldw $16,VVramWidth | adw $10,$16
        sb $2,$sy
    while nz | wend
rtn
DrawCellRight:
    cal CharsPtr
    ld $2,RowHeight
    do
        pre iz,$10
        ldi $0,(ix+$sx)
        ldi $0,(ix+$sx)
        sti $0,(iz+$sx)
        ldw $16,VVramWidth | adw $10,$16
        sb $2,$sy
    while nz | wend
rtn
DrawCellLeft:
    cal CharsPtr
    ld $2,RowHeight
    do
        pre iz,$10
        ldi $0,(ix+$sx)
        sti $0,(iz+$sx)
        ldi $0,(ix+$sx)
        ldw $16,VVramWidth | adw $10,$16
        sb $2,$sy
    while nz | wend
rtn

; void RollRight(ptr<byte> pMap);
cseg
RollRight_: public RollRight_
    phsm $2,3
        ld $2,ColumnCount-1
        pre ix,$10
        ld $1,(ix+$2)
        do
            sb $2,$sy
            ld $0,(ix+$2)
            ad $2,$sy
            st $0,(ix+$2)
            sb $2,$sy
        while nz | wend
        st $1,(ix+$2)
    ppsm $0,3
rtn


; void RollLeft(ptr<byte> pMap);
cseg
RollLeft_: public RollLeft_
    phsm $2,3
        ld $2,$sx
        pre ix,$10
        ld $1,(ix+$2)
        do
            ad $2,$sy
            ld $0,(ix+$2)
            sb $2,$sy
            st $0,(ix+$2)
            ad $2,$sy
            sbc $2,ColumnCount-1
        while nz | wend
        st $1,(ix+$2)
    ppsm $0,3
rtn
