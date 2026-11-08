include "ZeroPage.inc"
include "Vram.inc"

ext StageMap_

ColumnCount equ 12
RowCount equ 7

column equ ZB0
cellValue equ ZB1
offset equ ZB2
mask equ ZB3

dseg
SetCellBits_@Param1: public SetCellBits_@Param1
GetCell_@Param1: public GetCell_@Param1
SetCellBits_row:
    defb 1
SetCellBits_@Param2: public SetCellBits_@Param2
SetCellBits_cell:
    defb 1

cseg
MapOffsetX:
    sty column
    lda SetCellBits_row
    asl a ; *2
    clc|adc SetCellBits_row ;*3
    sta offset
    lda column
    lsr a | lsr a
    clc|adc offset | tax
    lda column
    and #3
    tay
rts


; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    pha
        jsr MapOffsetX
        lda SetCellBits_cell | sta cellValue
        lda #$03 | sta mask
        cpy #0
        do | while ne
            asl cellValue | asl cellValue
            asl mask | asl mask
            dey
        wend
        lda mask | eor #$ff | sta mask
        lda StageMap_,x
        and mask
        ora cellValue
        sta StageMap_,x
    pla
rts


; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    pha
        jsr MapOffsetX
        lda StageMap_,x
        cpy #0
        do | while ne
            lsr a | lsr a
            dey
        wend
        and #$03
        tay
    pla
rts