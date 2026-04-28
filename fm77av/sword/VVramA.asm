include "VVram.inc"

ext VVramFront_

; word VVramOffset(byte x, byte y);
zseg
pVram:
    defw 0
cseg
VVramOffset_: public VVramOffset_
    sta pVram+1
    clr pVram
    lda #VVramWidth
    mul
    addd pVram
rts


; void ClearVVramFront();
cseg
ClearVVramFront_: public ClearVVramFront_
    pshs y
        ldy #VVramFront_
        do
            clr ,y+
            cmpy #VVramFront_+VVramWidth*VVramHeight
        while ne | wend
    puls y
rts
