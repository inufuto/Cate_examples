include "ZeroPage.inc"

ext PanelMap_

pPanel equ ZW0

; ptr<byte> MapPtr(byte column, byte floor);
dseg
MapPtr_@Param1: public MapPtr_@Param1
MapPtr_y:
	defs 1
cseg
MapPtr_: public MapPtr_
    pha
        lda MapPtr_y
        asl a ;*2
        asl a ;*4
        asl a ;*8
        sta pPanel

        tya
        clc|adc pPanel
        clc|adc #low PanelMap_ | tay
        lda #0 | adc #high PanelMap_ | tax
    pla
rts
