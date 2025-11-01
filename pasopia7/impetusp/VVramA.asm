include "VVram.inc"

ext VVramBack_, VVramFront_

; void VVramBackToFront();
cseg
VVramBackToFront_: public VVramBackToFront_
    push hl | push de | push bc
        ld hl,VVramBack_
        ld de,VVramFront_
        ld bc,VVramWidth*VVramHeight
        ldir
    pop bc | pop de | pop hl
ret
