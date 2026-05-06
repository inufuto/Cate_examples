include "apple2.inc"
include "apple2gs.inc"
include "Zeropage.inc"

include "Vram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 16
RowCount equ 11

; column equ ZB0
cellValue equ ZB1
offset equ ZB2
mask equ ZB3

Param_column equ @zp+0
Param_row equ @zp+2
Param_cell equ @zp+4
returnValue equ @zp+0

cseg
a8 | i8
MapOffsetX:
    lda Param_row
    asl a ;*2
    asl a ;*4
    sta offset
    lda Param_column
    lsr a | lsr a
    clc|adc offset | tax
rts


; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            lda Param_cell | sta cellValue
            jsr MapOffsetX
            lda #$03 | sta mask

            lda Param_column
            and #3
            if ne
                tay
                do
                    asl cellValue | asl cellValue
                    asl mask | asl mask
                    dey
                while ne | wend
            endif
            
            lda mask | eor #$ff | sta mask
            lda StageMap_,x
            and mask
            ora cellValue
            sta StageMap_,x
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts


; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            jsr MapOffsetX
            lda StageMap_,x
            tax

            lda Param_column
            and #3
            if ne
                tay
                txa
                do
                    lsr a | lsr a
                    dey
                while ne | wend
                tax
            endif
            txa
            and #$03
            sta returnValue
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts
