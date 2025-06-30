include "VVram.inc"

ext VVram_

zseg 
Dp.Word0:
    defw 0

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    sta <Dp.Word0+1
    clr <Dp.Word0
    lda #VVramWidth
    mul
    addd <Dp.Word0
    addd #VVram_
rts


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pshs x,y
        ldx #VVram_
        ldy #VVramWidth*VVramHeight
        do
            clr 0,x
            leax 1,x        
            leay -1,y
        while ne | wend
    puls x,y
rts
