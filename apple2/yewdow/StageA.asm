include "ZeroPage.inc"

ext CellMap_

dseg
GetCell_@Param0: public GetCell_@Param0
SetCell_@Param0: public SetCell_@Param0
Param_x:
    defb 0
GetCell_@Param1: public GetCell_@Param1
SetCell_@Param1: public SetCell_@Param1
Param_y:
    defb 0
SetCell_@Param2: public SetCell_@Param2
SetCell_cell:
    defb 0


cseg
CellOffset: ; -> x
    lda Param_x
    lsr a
    sta <ZB0
    lda Param_y
    asl a ;*2
    asl a ;*4
    asl a ;*8
    adc <ZB0
    tax
rts


; byte GetCell(byte x, byte y);
cseg
GetCell_: public GetCell_
    jsr CellOffset
    lda Param_x
    and #1
    if ne
        lda CellMap_,x
        lsr a | lsr a | lsr a | lsr a
    else
        lda CellMap_,x
        and #$0f
    endif
    tay
rts


; byte SetCell(byte x, byte y, byte cell);
SetCell_: public SetCell_
    pha
        jsr CellOffset
        lda Param_x
        and #1
        if ne
            lda SetCell_cell
            asl a | asl a | asl a | asl a
            sta <ZB0
            lda CellMap_,x
            and #$0f
            ora <ZB0
        else
            lda CellMap_,x
            and #$f0
            ora SetCell_cell
        endif
        sta CellMap_,x
    pla
rts
