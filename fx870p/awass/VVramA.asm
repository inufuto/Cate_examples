include "VVram.inc"

ext VVramBack_, VVramFront_


; extern word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    phsw $13
        ld $10,$1 ;y
        biu $10 ;*2
        biu $10 ;*4
        biu $10 ;*8
        biu $10 ;*16
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
