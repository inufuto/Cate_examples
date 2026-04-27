include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext StageMap_

ColumnCount equ 16
RowCount equ 11

pMap equ @Temp@Word
shiftCount equ @Temp@Byte2
mask equ @Temp@Byte3
cellValue equ @Temp@Byte4

dseg
SetCellBits_@Param1: public SetCellBits_@Param1
GetCell_@Param1: public GetCell_@Param1
SetCellBits_row:
    defb 1
SetCellBits_@Param2: public SetCellBits_@Param2
SetCellBits_cell:
    defb 1

cseg
MapPtr:
    psha    
        lsra | lsra
        ldab SetCellBits_row
        aslb ;*2
        aslb ;*4
        aba | clrb
        adda #low StageMap_ | staa pMap+1
        adcb #high StageMap_ | stab pMap
        ldx pMap
    pula
    anda #3
rts

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    psha | pshb
        bsr MapPtr
        staa shiftCount
        ldaa SetCellBits_cell
        ldab #$03
        tst shiftCount
        do | while ne
            asla | asla
            aslb | aslb
            dec shiftCount
        wend
        staa cellValue
        comb
        stab mask
        ldaa 0,x
        anda mask
        oraa cellValue
        staa 0,x
    pulb | pula
rts
        

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    pshb
                ldab SetCellBits_row
                if ne
                    _deb: public _deb
                    nop
                endif
        bsr MapPtr
        ldab 0,x
        tsta
        do | while ne
            lsrb | lsrb
            deca
        wend
        tba
        anda #3
    pulb
rts