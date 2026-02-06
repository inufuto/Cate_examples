include "ZeroPage.inc"

ext CellMap_

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
        asl a ;*8
        sta <ZW0

        tya
        lsr a
        clc|adc <ZW0
        clc|adc #low CellMap_ | tay
        lda #0 | adc #high CellMap_ | tax
    pla
rts
