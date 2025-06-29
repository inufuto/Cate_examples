include "VVram.inc"

ext VVram_
ext Background_

zseg 
Dp.Word0:
    defw 0
yCount:
    defb 0

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


; extern void BackgroundToVVram();
cseg
BackgroundToVVram_: public BackgroundToVVram_
    pshs a,b,x,y
        ldx #Background_
        ldy #VVram_
        lda #VVramHeight | sta <yCount
        do
            ldb #VVramWidth
            do
                lda ,x+
                sta ,y+
                decb
            while ne | wend
            leax BackgroundWidth-VVramWidth,x
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts
TileWidth equ 2
BackgroundWidth equ VVramWidth+TileWidth