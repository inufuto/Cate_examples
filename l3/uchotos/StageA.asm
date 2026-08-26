include "Direct.inc"
include "VVram.inc"

ext StageMap_

ColumnCount equ 16

cseg
MapPtr: ;(a,b) -> x
    pshs a
        bsr MapPtr_
        tfr d,x
    puls a
    anda #1
rts

; ptr<byte> MapPtr(byte column, byte row);
cseg
MapPtr_: public MapPtr_
    lsra | sta @Temp@Byte
    lslb | lslb | lslb
    addb @Temp@Byte | clra
    addd #StageMap_
rts

; void SetCellBits(byte column, byte row, byte cell);
dseg
SetCellBits_@Param2: public SetCellBits_@Param2
SetCellBits_cell:
    defb 1
cseg
SetCellBits_: public SetCellBits_
    pshs a,b,x
        bsr MapPtr
        if ne
            lda ,x
            anda #$0f
            ldb SetCellBits_cell
            aslb | aslb | aslb | aslb
        else
            lda ,x
            anda #$f0
            ldb SetCellBits_cell
            andb #$0f
        endif
        stb @Temp@Byte
        ora @Temp@Byte
        sta ,x
    puls a,b,x
rts
        

; byte GetCell(byte column, byte row);
cseg
GetCell_: public GetCell_
    pshs b,x
        bsr MapPtr
        if ne
            lda ,x
            lsra | lsra | lsra | lsra
        else
            lda ,x
            anda #$0f
        endif
    puls b,x
rts