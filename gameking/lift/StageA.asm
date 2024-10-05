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
        dec a | dec a
        lsr a | lsr a ; /4
        sta <ZW0
        asl a ;*2
        clc|adc <ZW0 ;*3
        asl a ;*6
        asl a ;*12
        sta <ZW0

        tya
        lsr a
        clc|adc <ZW0
        clc|adc #low CellMap_ | tay
        lda #0 | adc #high CellMap_ | tax
    pla
rts
