include "ZeroPage.inc"
include "VVram.inc"

ext StageMap_

ColumnCount equ 16
RowCount equ 11

pMap equ @Temp@Word

dseg
MapPtr_@Param1: public MapPtr_@Param1
MapPtr_row:
SetCellBits_@Param1: public SetCellBits_@Param1
GetCell_@Param1: public GetCell_@Param1
SetCellBits_row:
    defb 1
SetCellBits_@Param2: public SetCellBits_@Param2
SetCellBits_cell:
    defb 1

cseg
MapPtr: ;(a,b) -> (x)
    psha    
        lsra
        ldab SetCellBits_row
        aslb ;*2
        aslb ;*4
        aslb ;*8
        aba | tab
        ldx #StageMap_ | abx
    pula
    anda #1
rts

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    psha | pshb
        ldab MapPtr_row
        bsr MapPtr
    pulb | pula
rts

; void SetCellBits(byte column, byte row, byte cell);
cseg
SetCellBits_: public SetCellBits_
    psha | pshb
        bsr MapPtr
        if ne
            ldaa 0,x
            anda #$0f
            ldab SetCellBits_cell
            aslb | aslb | aslb | aslb
        else
            ldaa 0,x
            anda #$f0
            ldab SetCellBits_cell
            andb #$0f
        endif
        aba
        staa 0,x
    pulb | pula
rts
        

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    pshb
        bsr MapPtr
        if ne
            ldaa 0,x
            lsra | lsra | lsra | lsra
        else
            ldaa 0,x
            anda #$0f
        endif
    pulb
rts