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
        lda #0 | sta <pCell+1
        lda CellMapPtr_y
        asl a | rol <pCell+1 ;*2
        asl a | rol <pCell+1 ;*4
        asl a | rol <pCell+1 ;*8
        asl a | rol <pCell+1 ;*16
        asl a | rol <pCell+1 ;*32
        sta <pCell

        tya
        lsr a | lsr a
        clc|adc <pCell | sta <pCell
        lda <pCell+1 | adc #0 | sta <pCell+1
        lda <pCell | clc|adc #low CellMap_ | tay
        lda <pCell+1 | adc #high CellMap_ | tax
    pla
rts
