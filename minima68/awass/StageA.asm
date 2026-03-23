include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 16
FloorCount equ 6
ColumnWidth equ 2
FloorHeight equ 4
RowHeight equ FloorHeight/2
Range equ FloorHeight*FloorCount-RowHeight

scope
pMap equ @Temp@Word

; ptr<byte> MapPtr(byte column, byte floor);
MapPtr_@Param1: public MapPtr_@Param1
MapPtr_floor:
    defb 0
cseg
MapPtr_: public MapPtr_
    psha | pshb
        staa pMap+1
        ldab MapPtr_floor
        aslb ;*2
        aslb ;*4
        aslb ;*8
        aslb ;*16
        addb pMap+1
        clra
        addb #low StageMap_ | adca #high StageMap_
        staa pMap | stab pMap+1
        ldx pMap
    pulb | pula
rts
endscope


dseg
DrawFloor_@Param1: public DrawFloor_@Param1
DrawFloorShift_@Param1: public DrawFloorShift_@Param1
DrawFloor_pVVram:
    defw 0
DrawFloor_@Param2: public DrawFloor_@Param2
DrawFloorShift_@Param2: public DrawFloorShift_@Param2
RollRight_@Param0: public RollRight_@Param0
RollLeft_@Param0: public RollLeft_@Param0
DrawFloor_pMap:
Roll_pMap:
    defw 0

scope
pVVram equ @Temp@Word
pMap equ @Temp@Word2
pChars equ @Temp@Word3
cCount equ @Temp@Byte
yCount equ @Temp@Byte2
yPos equ @Temp@Byte3

; void DrawFloor(byte y, ptr<byte> pVram, ptr<byte> pMap);
cseg
DrawFloor_: public DrawFloor_
    psha | pshb
        staa yPos
        ldx DrawFloor_pVVram | stx pVVram
        ldx DrawFloor_pMap | stx pMap
        ldaa #ColumnCount | staa cCount
        do
            ldx pMap | ldaa 0,x | inx | stx pMap
            psha
                lsra | lsra | lsra | lsra
                bsr DrawCell
            pula
            bsr DrawCell

            ldaa pVVram+1 | adda #low(ColumnWidth-VramRowSize*FloorHeight) | staa pVVram+1
            ldaa pVVram | adca #high(ColumnWidth-VramRowSize*FloorHeight) | staa pVVram
            ldaa yPos | suba #FloorHeight | staa yPos
        dec cCount | while ne | wend
    pulb | pula
rts
DrawCell: ;(pVVram, a)
    bsr CharsPtr
    ldaa #RowHeight | staa yCount
    do
        ldaa yPos
        cmpa #Range
        if cs
            ldab #ColumnWidth
            do
                ldx pChars | ldaa 0,x | inx | stx pChars
                ldx pVVram | staa 0,x | inx | stx pVVram
            decb | while ne | wend
            ldaa pVVram+1 | adda #VramRowSize-ColumnWidth | staa pVVram+1
            ldaa pVVram | adca #0 | staa pVVram
        else
            ldaa pVVram+1 | adda #VramRowSize | staa pVVram+1
            ldaa pVVram | adca #0 | staa pVVram
        endif
        inc yPos
    dec yCount | while ne | wend
rts
CellChars:
    defb Char_Space,Char_Space,Char_Space,Char_Space
    defb Char_Floor,Char_Floor,Char_Space,Char_Space
    defb Char_Ladder,Char_Ladder+1,Char_Ladder,Char_Ladder+1
    defb Char_Bomb,Char_Bomb+1,Char_Bomb+2,Char_Bomb+3
    defb Char_Flag_A,Char_Flag_A+1,Char_Flag_A+2,Char_Flag_A+3
    defb Char_Flag_B,Char_Flag_B+1,Char_Flag_B+2,Char_Flag_B+3
    defb Char_Flag_C,Char_Flag_C+1,Char_Flag_C+2,Char_Flag_C+3
    defb Char_Flag_D,Char_Flag_D+1,Char_Flag_D+2,Char_Flag_D+3
CharsPtr: ;(a)->pChars
    anda #7
    asla | asla
    adda #low(CellChars) | staa pChars+1
    ldaa #high(CellChars) | adca #0 | staa pChars
rts

; void DrawFloorShift(byte y, ptr<byte> pVram, ptr<byte> pMap);
cseg
DrawFloorShift_: public DrawFloorShift_
    psha | pshb
        staa yPos
        ldx DrawFloor_pVVram | stx pVVram
        ldx DrawFloor_pMap | ldaa 0,x | inx | stx pMap
        psha
            psha
                lsra | lsra | lsra | lsra
                bsr DrawCellRight
            pula
            bsr DrawCellRight

            ldaa pVVram+1 | adda #low(ColumnWidth/2-VramRowSize*FloorHeight) | staa pVVram+1
            ldaa pVVram | adca #high(ColumnWidth/2-VramRowSize*FloorHeight) | staa pVVram
            ldaa yPos | suba #FloorHeight | staa yPos

            ldaa #ColumnCount-1 | staa cCount
            do
                ldx pMap | ldaa 0,x | inx | stx pMap
                psha
                    lsra | lsra | lsra | lsra
                    bsr DrawCell
                pula
                bsr DrawCell

                ldaa pVVram+1 | adda #low(ColumnWidth-VramRowSize*FloorHeight) | staa pVVram+1
                ldaa pVVram | adca #high(ColumnWidth-VramRowSize*FloorHeight) | staa pVVram
                ldaa yPos | suba #FloorHeight | staa yPos
            dec cCount | while ne | wend
        pula
        psha
            lsra | lsra | lsra | lsra
            bsr DrawCellLeft
        pula
        bsr DrawCellLeft
    pulb | pula
rts
DrawCellRight: ;(pVVram, a)
    bsr CharsPtr
    ldab #RowHeight
    do
        ldx pChars | inx | ldaa 0,x | inx | stx pChars
        ldx pVVram | staa 0,x

        ldaa pVVram+1 | adda #VramRowSize | staa pVVram+1
        ldaa pVVram | adca #0 | staa pVVram
        inc yPos
    decb | while ne | wend
rts
DrawCellLeft: ;(pVVram, a)
    bsr CharsPtr
    ldab #RowHeight
    do
        ldx pChars | ldaa 0,x | inx | inx | stx pChars
        ldx pVVram | staa 0,x

        ldaa pVVram+1 | adda #VramRowSize | staa pVVram+1
        ldaa pVVram | adca #0 | staa pVVram
        inc yPos
    decb | while ne | wend
rts
endscope


scope
; void RollRight(ptr<byte> pMap);
cseg
RollRight_: public RollRight_
    psha | pshb
        ldx Roll_pMap
        ldaa ColumnCount-1,x
        psha
            ldab #ColumnCount-1
            do
                ldaa ColumnCount-1-1,x
                staa ColumnCount-1,x
                dex
            decb | while ne | wend
        pula
        staa ColumnCount-1,x
    pulb | pula
rts


; void RollLeft(ptr<byte> pMap);
cseg
RollLeft_: public RollLeft_
    psha | pshb
        ldx Roll_pMap
        ldaa 0,x
        psha
            ldab #ColumnCount-1
            do
                ldaa 1,x
                staa 0,x
                inx
            decb | while ne | wend
        pula
        staa 0,x
    pulb | pula
rts
endscope