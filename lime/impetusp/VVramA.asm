include "VVram.inc"

ext VVramBack_, VVramFront_

; void VVramBackToFront();
cseg
VVramBackToFront_: public VVramBackToFront_
    pshs a,b,x,y
        ldx #VVramBack_
        ldy #VVramFront_
        do
            ldd ,x++
            std ,y++
            cmpx #VVramBack_+VVramWidth*VVramHeight
        while ne | wend
    puls a,b,x,y
rts
