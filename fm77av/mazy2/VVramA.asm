include "VVram.inc"

ext VVramBack_, VVramFront_
ext @Temp@Word

; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    sta <@Temp@Word+1
    clr <@Temp@Word
    lda #VVramWidth
    mul
    addd <@Temp@Word
rts


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pshs x
        ldx #VVramFront_
        do
            clr ,x+
            cmpx #VVramFront_+VVramWidth*VVramHeight
        while ne | wend
    puls x
rts


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    stb ,x
    tfr x,d
    addd #1
rts