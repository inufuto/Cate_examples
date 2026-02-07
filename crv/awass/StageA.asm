include "ZeroPage.inc"
include "Port.inc"
include "Vram.inc"
include "Chars.inc"

ext StageMap_
ext WaitVdp

ColumnCount equ 16
FloorCount equ 6
ColumnWidth equ 2
FloorHeight equ 4
RowHeight equ FloorHeight/2
YRange equ FloorHeight*FloorCount-RowHeight

dseg
MapPtr_@Param1: public MapPtr_@Param1
MapPtr_floor:
    defb 0

DrawFloor_@Param1: public DrawFloor_@Param1
DrawFloorShift_@Param1: public DrawFloorShift_@Param1
DrawFloor_vram:
    defw 0

DrawFloor_@Param2: public DrawFloor_@Param2
DrawFloorShift_@Param2: public DrawFloorShift_@Param2
DrawFloor_pMap:
    defw 0

scope
pMap equ ZW0
; ptr<byte> MapPtr(byte column, byte floor);
cseg
MapPtr_: public MapPtr_
    pha
        lda MapPtr_floor
        asl a ;*2
        asl a ;*4
        asl a ;*8
        asl a ;*16
        sta pMap

        tya
        clc|adc pMap
        clc|adc #low StageMap_ | tay
        lda #0 | adc #high StageMap_ | tax
    pla
rts
endscope


CellChars:
    defb Char_Space,Char_Space,Char_Space,Char_Space
    defb Char_Floor,Char_Floor,Char_Space,Char_Space
    defb Char_Ladder,Char_Ladder+1,Char_Ladder,Char_Ladder+1
    defb Char_Bomb,Char_Bomb+1,Char_Bomb+2,Char_Bomb+3
    defb Char_Flag_A,Char_Flag_A+1,Char_Flag_A+2,Char_Flag_A+3
    defb Char_Flag_B,Char_Flag_B+1,Char_Flag_B+2,Char_Flag_B+3
    defb Char_Flag_C,Char_Flag_C+1,Char_Flag_C+2,Char_Flag_C+3
    defb Char_Flag_D,Char_Flag_D+1,Char_Flag_D+2,Char_Flag_D+3

scope
yPos equ ZB0
cCount equ ZB1
mapOffset equ ZB2
yCount equ ZB4
xCount equ ZB5
charOffset equ ZB6
wVram equ ZW0
pMap equ ZW1
; void DrawFloor(byte y, word vram, ptr<byte> pMap);
cseg
DrawFloor_: public DrawFloor_
    pha
        sty yPos
        lda DrawFloor_vram | sta wVram
        lda DrawFloor_vram+1 | ora #$40 | sta wVram+1
        lda DrawFloor_pMap | sta pMap
        lda DrawFloor_pMap+1 | sta pMap+1
        lda #0 | sta mapOffset

        lda #ColumnCount | sta cCount
        jsr DrawColumns
    pla
rts
; void DrawFloorShift(byte y, word vram, ptr<byte> pMap);
DrawFloorShift_: public DrawFloorShift_
    pha
        sty yPos
        lda DrawFloor_vram | sta wVram
        lda DrawFloor_vram+1 | ora #$40 | sta wVram+1
        lda DrawFloor_pMap | sta pMap
        lda DrawFloor_pMap+1 | sta pMap+1
        lda #0 | sta mapOffset

        ldy mapOffset | lda (pMap),y | iny | sty mapOffset
        pha
            pha
                lsr a | lsr a | lsr a | lsr a
                jsr DrawCellRight
            pla
            jsr DrawCellRight
            lda yPos | sec|sbc #FloorHeight | sta yPos
            lda wVram | clc|adc #low(ColumnWidth/2*VramStep-VramRowSize*FloorHeight) | sta wVram
            lda wVram+1 | adc #high(ColumnWidth/2*VramStep-VramRowSize*FloorHeight) | sta wVram+1

            lda #ColumnCount-1 | sta cCount
            jsr DrawColumns
        pla
        pha
            lsr a | lsr a | lsr a | lsr a
            jsr DrawCellLeft
        pla
        jsr DrawCellLeft
    pla
rts
DrawColumns:
    do
        ldy mapOffset | lda (pMap),y | iny | sty mapOffset
        pha
            lsr a | lsr a | lsr a | lsr a
            jsr DrawCell
        pla
        jsr DrawCell
        lda yPos | sec|sbc #FloorHeight | sta yPos
        lda wVram | clc|adc #low(ColumnWidth*VramStep-VramRowSize*FloorHeight) | sta wVram
        lda wVram+1 | adc #high(ColumnWidth*VramStep-VramRowSize*FloorHeight) | sta wVram+1
        dec cCount
    while ne | wend
rts
DrawC:
    sei
        pha
            lda <wVram | sta VdpWritePort+1
            lda <wVram+1 | sta VdpWritePort+1
        pla
        sta VdpWritePort
        jsr WaitVdp
    cli
rts
DrawCell:
    and #7
    asl a | asl a
    sta charOffset
    lda #RowHeight | sta yCount
    do
        lda yPos
        cmp #YRange
        if cc
            lda #ColumnWidth | sta xCount
            do
                ldx charOffset | lda CellChars,x | inx | stx charOffset
                jsr DrawC
                lda wVram | clc|adc #low(VramStep) | sta wVram
                lda wVram+1 | adc #high(VramStep) | sta wVram+1
                dec xCount
            while ne | wend
            lda wVram | clc|adc #low(VramRowSize-ColumnWidth*VramStep) | sta wVram
            lda wVram+1 | adc #high(VramRowSize-ColumnWidth*VramStep) | sta wVram+1
        else
            inc charOffset | inc charOffset
            lda wVram | clc|adc #low(VramRowSize) | sta wVram
            lda wVram+1 | adc #high(VramRowSize) | sta wVram+1
        endif
        inc yPos
        dec yCount
    while ne | wend
rts
DrawCellRight:
    and #7
    asl a | asl a
    sta charOffset
    lda #RowHeight | sta yCount
    do
        lda yPos
        cmp #YRange
        if cc
            ldx charOffset | inx | lda CellChars,x | inx | stx charOffset
            jsr DrawC
        else
            inc charOffset | inc charOffset
        endif
        lda wVram | clc|adc #low(VramRowSize) | sta wVram
        lda wVram+1 | adc #high(VramRowSize) | sta wVram+1
        inc yPos
        dec yCount
    while ne | wend
rts
DrawCellLeft:
    and #7
    asl a | asl a
    sta charOffset
    lda #RowHeight | sta yCount
    do
        lda yPos
        cmp #YRange
        if cc
            ldx charOffset | lda CellChars,x | inx | inx | stx charOffset
            jsr DrawC
        else
            inc charOffset | inc charOffset
        endif
        lda wVram | clc|adc #low(VramRowSize) | sta wVram
        lda wVram+1 | adc #high(VramRowSize) | sta wVram+1
        inc yPos
        dec yCount
    while ne | wend
rts
endscope


scope
pMap equ ZW0
; void RollRight(ptr<byte> pMap);
cseg
RollRight_: public RollRight_
    pha
        sty pMap | stx pMap+1
        ldy #ColumnCount-1
        lda (pMap),y
        pha
            do
                dey
                lda (pMap),y
                iny
                sta (pMap),y
                dey
            while ne | wend
        pla
        sta (pMap),y
    pla
rts


; void RollLeft(ptr<byte> pMap);
cseg
RollLeft_: public RollLeft_
    pha
        sty pMap | stx pMap+1
        ldy #0
        lda (pMap),y
        pha
            do
                iny
                lda (pMap),y
                dey
                sta (pMap),y
                iny
                cpy #ColumnCount-1
            while ne | wend
        pla
        sta (pMap),y
    pla
rts
endscope
