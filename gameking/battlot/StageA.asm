include "ZeroPage.inc"

ext WallMap_

; ptr<byte> WallMapPtr(byte x, byte y);
dseg
WallMapPtr_@Param1: public WallMapPtr_@Param1
WallMapPtr_y:
	defb 0
cseg
WallMapPtr_: public WallMapPtr_
    pha
        lda WallMapPtr_y
        asl a ;*2
        clc|adc WallMapPtr_y ;*3
        asl a ;*6
        sta <ZW0

        tya
        lsr a | lsr a
        clc|adc <ZW0
        clc|adc #low WallMap_ | tay
        lda #0 | adc #high WallMap_ | tax
    pla
rts
