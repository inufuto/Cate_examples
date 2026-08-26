include "Direct.inc"
include "VVram.inc"

ext VVram_

pVVram equ @Temp@Word

scope
; ptr<byte> VVramPtr(byte x, byte y);
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

scope
; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    stb ,x
    tfr x,d
    addd #1
rts
