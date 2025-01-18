include "Zeropage.inc"

ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
CellMapPtr_x equ @zp+0
CellMapPtr_y equ @zp+2
CellMapPtr_return equ @zp+0
cseg
CellMapPtr_: public CellMapPtr_
    php
        rep #$20 | a16
		pha
            lda <CellMapPtr_y
            asl a ;*2
            asl a ;*4
            clc|adc <CellMapPtr_y ;*5
            and #$00ff
            sta <ZW0

            lda <CellMapPtr_x
            and #$00ff
            lsr a
            clc|adc <ZW0
            clc|adc #CellMap_
            sta <CellMapPtr_return
        pla
    plp
rts
