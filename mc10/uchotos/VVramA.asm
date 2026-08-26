include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

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
        staa @Temp@Word+1
        ldaa VVramOffset_y
        ldab #VVramWidth
        mul
        addb @Temp@Word+1 | adca #0
        std @Temp@Word | ldx @Temp@Word
    pulb | pula
rts


; void VVramBackToFront()
VVramBackToFront_count equ @Temp@Byte
cseg
VVramBackToFront_: public VVramBackToFront_
    psha | pshb
        sts saveSp
        ldx #VVramBack_+VVramWidth*VVramHeight
        sei
            lds #VVramFront_+VVramWidth*VVramHeight-1
            do
                dex
                ldaa 0,x
                psha
                cpx #VVramBack_
            while ne | wend
            lds saveSp
        cli
    pulb | pula
rts


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
dseg
VPut_@Param0: public VPut_@Param0
VPut_pVVram:
    defw 0
VPut_@Param1: public VPut_@Param1
VPut_c:
    defb 0
cseg
VPut_: public VPut_
    psha
        ldx VPut_pVVram
        ldaa VPut_c
        staa 0,x
        inx
    pula
rts
