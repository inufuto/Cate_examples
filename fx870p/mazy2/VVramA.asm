include "VVram.inc"

ext VVramBack_, VVramFront_


; extern word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    phsw $13
        ld $10,$1 ;y
        biu $10 ;*2
        ad $10,$1 ;*3
        ld $11,$10
        biu $10 ;*6
        ad $10,$11 ;*9
        biu $10 ;*18
        ad $10,$1 ;*19
        ld $11,$sx
        ld $12,$0
        ld $13,$sx
        adw $10,$12
    ppsw $12
rtn


; void VVramBackToFront()
cseg
VVramBackToFront_: public VVramBackToFront_
    phs $0
    phsw $11
        pre ix,VVramBack_
        pre iz,VVramFront_
        ldw $10,VVramWidth*VVramHeight
        do
            ldi $0,(ix+$sx)
            sti $0,(iz+$sx)
            sbw $10,$sy
        while nz | wend
    ppsw $10
    pps $0
rtn


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    pre ix,$10
    sti $1,(ix+$sx)
    gre ix,$10
rtn
