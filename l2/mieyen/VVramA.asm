include "VVram.inc"

ext VVram_

ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Word
ext @Temp@Word2

; word VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
    defb 0
cseg
VVramPtr_: public VVramPtr_
    psha | pshb
        staa <@Temp@Word+1
        ldab VVramPtr_y | clra
        aslb | rola ;*2
        aslb | rola ;*4
        aslb | rola ;*8
        aslb | rola ;*16
        aslb | rola ;*32
        addb <@Temp@Word+1 | adca #0
        addb #low VVram_ | adca #high VVram_
        stab <@Temp@Word+1 | staa <@Temp@Word
        ldx <@Temp@Word
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
