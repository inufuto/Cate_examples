include "Vram.inc"
include "VVram.inc"

dseg
VVramBack_: public VVramBack_
    defs VVramWidth*VVramHeight
VVramFront_: public VVramFront_
    defs VVramWidth*VVramHeight


; extern word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    phsw $13
        ld $10,$1
        biu $10 ;*2
        ad $10,$1 ;*3
        ld $11,$sx
        biuw $10 ;*6
        biuw $10 ;*12
        biuw $10 ;*24
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


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    phs $0
    phsw $11
        ld $0,$sx
        pre iz,VVramBack_
        ldw $10,VVramWidth*VVramHeight
        do
            sti $0,(iz+$sx)
            sbw $10,$sy
        while nz | wend
    ppsw $10
    pps $0
rtn
