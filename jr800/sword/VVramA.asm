include "ZeroPage.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_

saveSp:
    defw 0


; word VVramOffset(byte x, byte y);
dseg
VVramOffset_@Param1: public VVramOffset_@Param1
VVramOffset_y:
    defb 0
cseg
VVramOffset_: public VVramOffset_
    psha | pshb
        staa <@Temp@Word+1
        ldab VVramOffset_y
        ldaa #VVramWidth | mul
        addb <@Temp@Word+1 | adca #0
        stab <@Temp@Word+1 | staa <@Temp@Word
        ldx <@Temp@Word
    pulb | pula
rts


; void VVramBackToFront()
VVramBackToFront_count equ @Temp@Byte
cseg
VVramBackToFront_: public VVramBackToFront_
    psha | pshb
        sts saveSp
        ldaa #VVramHeight
        staa <VVramBackToFront_count
        ldx #VVramBack_+VVramWidth*VVramHeight-1
        sei
            lds #VVramFront_+VVramWidth*VVramHeight-1
            do
                ldab #VVramWidth
                do
                    ldaa 0,x
                    dex
                    psha
                    decb
                while ne | wend
                dec VVramBackToFront_count
            while ne | wend
            lds saveSp
        cli
    pulb | pula
rts
