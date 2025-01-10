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


; void VVramBackToFront()
cseg
VVramBackToFront_: public VVramBackToFront_
    pshs a,x,y
        ldx #VVramBack_
        ldy #VVramFront_
        do
            lda ,x+
            sta ,y+
            cmpx #VVramBack_+VVramWidth*VVramHeight
        while ne | wend
    puls a,x,y
rts


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    stb ,x
    tfr x,d
    addd #1
rts