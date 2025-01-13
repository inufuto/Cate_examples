include "ZeroPage.inc"

ext CellMap_

pCell equ ZW0

; ptr<byte> CellMapPtr(byte column, byte floor);
dseg
CellMapPtr_@Param1: public CellMapPtr_@Param1
CellMapPtr_y:
	defs 1
cseg
CellMapPtr_: public CellMapPtr_
    pha
        lda CellMapPtr_y
        asl a ;*2
        asl a ;*4
        clc|adc CellMapPtr_y ;*5
        sta <pCell

        tya
        lsr a
        clc|adc <pCell
        clc|adc #low CellMap_ | tay
        lda #0 | adc #high CellMap_ | tax
    pla
rts
