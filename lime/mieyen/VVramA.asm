include "VVram.inc"

ext VVram_
ext @Temp@Word

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    sta <@Temp@Word+1
    clr <@Temp@Word
    lda #VVramWidth
    mul
    addd <@Temp@Word
    addd #VVram_
rts


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    stb ,x
    tfr x,d
    addd #1
rts