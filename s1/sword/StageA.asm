include "ZeroPage.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 16
RowCount equ 11

shiftCount equ @Temp@Byte
cellValue equ @Temp@Byte2
mask equ @Temp@Byte3

dseg
SetCellBits_@Param2: public SetCellBits_@Param2
SetCellBits_cell:
    defb 1

cseg
MapPtr:
    pshs a
        lda #ColumnCount/4
        mul
        addd #StageMap_
        tfr d,x
    puls a
    pshs a
        lsra | lsra
        leax a,x
    puls a
    anda #3
rts


; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    pshs a,b,x
        bsr MapPtr
        sta shiftCount
        lda SetCellBits_cell
        ldb #$03
        tst shiftCount
        do | while ne
            asla | asla
            aslb | aslb
            dec shiftCount
        wend
        sta cellValue
        comb
        stb mask
        lda ,x
        anda mask
        ora cellValue
        sta ,x
    puls a,b,x
rts


; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    pshs b,x
        bsr MapPtr
        ldb ,x
        tsta
        do | while ne
            lsrb | lsrb
            deca
        wend
        tfr b,a
        anda #3
    puls b,x
rts