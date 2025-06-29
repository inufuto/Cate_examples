ext CellMap_

ext @Temp@Byte
ext @Temp@Word

pCell equ @Temp@Word


cseg
CellPtr: ; (a,b):x
    lsra
    sta <pCell+1 | clr <pCell
    lda #8
    mul
    addd <pCell
    addd #CellMap_
    tfr d,x
rts


; byte GetCell(byte x, byte y);
cseg
GetCell_: public GetCell_
    pshs b,x
        pshs a
            bsr CellPtr
        puls a
        ldb 0,x
        anda #1
        if ne
            lsrb | lsrb | lsrb | lsrb
        endif
        andb #$0f
        tfr b,a
    puls b,x
rts


; byte SetCell(byte x, byte y, byte cell);
dseg
SetCell_@Param2: public SetCell_@Param2
SetCell_cell:
    defb 0
cseg
SetCell_: public SetCell_
    pshs a,b,x
        pshs a
            bsr CellPtr
        puls a
        ldb SetCell_cell
        anda #1
        if ne
            aslb | aslb | aslb | aslb
            lda 0,x
            anda #$0f
        else
            andb #$0f
            lda 0,x
            anda #$f0
        endif
        stb <@Temp@Byte
        ora <@Temp@Byte
        sta 0,x
    puls a,b,x
rts
