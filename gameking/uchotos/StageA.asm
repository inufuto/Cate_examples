include "ZeroPage.inc"
include "Vram.inc"

ext StageMap_

column equ ZB0
offset equ ZB1
maskedValue equ ZB2

dseg
MapPtr_@Param1: public MapPtr_@Param1
SetCellBits_@Param1: public SetCellBits_@Param1
GetCell_@Param1: public GetCell_@Param1
Param_row:
    defb 0
SetCellBits_@Param2: public SetCellBits_@Param2
Param_cell:
    defb 1

cseg
MapOffsetA:
    sty column
    lda Param_row
    asl a ; *2
    clc|adc Param_row ;*3
    asl a ; *6
    sta offset
    lda column
    lsr a
    clc|adc offset
rts

MapOffsetX:
    jsr MapOffsetA
    tax
    lda column
    and #1
rts


; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    pha
        jsr MapOffsetA
        ldx #high StageMap_
        clc|adc #low StageMap_ | tay
        if cs
            inx
        endif
    pla
rts


; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    pha
        jsr MapOffsetX
        if ne
            lda StageMap_,x
            and #$0f
            sta maskedValue
            lda Param_cell
            asl a | asl a | asl a | asl a
        else
            lda StageMap_,x
            and #$f0
            sta maskedValue
            lda Param_cell
            and #$0f
        endif
        ora maskedValue
        sta StageMap_,x
    pla
rts


; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    pha
        jsr MapOffsetX
        if ne
            lda StageMap_,x
            lsr a | lsr a | lsr a | lsr a
        else
            lda StageMap_,x
            and #$0f
        endif
        tay
    pla
rts
