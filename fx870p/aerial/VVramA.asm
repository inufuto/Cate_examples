include "VVram.inc"

TileWidth equ 2
GroundWidth equ VVramHeight+TileWidth

ext Background_

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


; void GroundToVVram();
cseg
GroundToVVram_: public GroundToVVram_
    phsm $2,3
        pre ix,Background_
        pre iz,VVramBack_
        ld $1,VVramHeight
        do
            ld $2,VVramWidth
            do
                ldi $0,(ix+$sx)
                sti $0,(iz+$sx)
                sb $2,$sy
            while nz | wend
            ldi $0,(ix+$sx)
            ldi $0,(ix+$sx)
            sb $1,$sy
        while nz | wend
    ppsm $0,3
rtn