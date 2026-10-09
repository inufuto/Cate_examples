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


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pshs x
        ldx #VVram_
        do
            clr ,x+
            cmpx #VVram_+VVramWidth*VVramHeight
        while ne | wend
    puls x
rts
