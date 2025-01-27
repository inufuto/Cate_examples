include "VVram.inc"

ext VVram_

ext @Temp@Word


; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
    defb 0
cseg
VVramPtr_: public VVramPtr_
    psha | pshb
        staa <@Temp@Word+1
        ldab VVramPtr_y | clra
        ldaa #VVramWidth
        mul
        addb <@Temp@Word+1 | adca #0
        addd #VVram_
        xgdx
    pulb | pula
rts
