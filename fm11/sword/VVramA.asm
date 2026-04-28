include "ZeroPage.inc"
include "VVram.inc"

ext VVram_

scope
; ptr<byte> VVramPtr(byte x, byte y);
pVVram equ @Temp@Word
cseg
VVramPtr_: public VVramPtr_
    sta <pVVram+1
    clr <pVVram
    lda #VVramWidth
    mul
    addd <pVVram
    addd #VVram_
rts
endscope
