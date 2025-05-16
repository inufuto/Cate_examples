include "VVram.inc"

ext VVramBack_, VVramFront_

ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Word
ext @Temp@Word2

dseg
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
        ldab VVramOffset_y | clra
        aslb | rola ;*2
        aslb | rola ;*4
        aslb | rola ;*8
        aslb | rola ;*16
        aslb | rola ;*32
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
