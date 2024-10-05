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
        clc|adc CellMapPtr_y ;*3
        stz <pCell+1
        asl a | rol <pCell+1 ;*6
        asl a | rol <pCell+1 ;*12
        asl a | rol <pCell+1 ;*24
        sta <pCell

        tya
        lsr a | lsr a
        clc|adc <pCell | sta <pCell
        lda <pCell+1 | adc #0 | sta <pCell+1

        lda <pCell | clc|adc #low CellMap_ | tay
        lda <pCell+1 | adc #high CellMap_ | tax
    pla
rts
