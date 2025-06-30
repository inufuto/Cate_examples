include 'VVram.inc'

zseg 
Dp.Word0:
    defw 0

GroundHeight equ VVramHeight+TileSize

dseg
Ground_: public Ground_
    defs VVramWidth*TileSize
VVramBack_: public VVramBack_
    defs VVramWidth*VVramHeight
VVramFront_: public VVramFront_
    defs VVramWidth*VVramHeight
RowFlags_: public RowFlags_
    defs 4+1


; word VVramOffset(byte x, byte y)
cseg
VVramOffset_: public VVramOffset_
    sta <Dp.Word0+1
    clr <Dp.Word0
    lda #VVramWidth
    mul
    addd <Dp.Word0
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
        clr RowFlags_
        clr RowFlags_+1
        clr RowFlags_+2
    puls a,x,y
rts


; void SetRowFlags(byte y, byte b);
dseg
SetRowFlags_low:
    defb 0
SetRowFlags_high:
    defb 0
cseg
SetRowFlags_: public SetRowFlags_
    pshs a,b,x,y
        stb SetRowFlags_low
        clr SetRowFlags_high
        tfr a,b
        andb #7
        if ne
            do
                asl SetRowFlags_low | rol SetRowFlags_high
                decb
            while ne | wend
        endif
        
        lsra | lsra | lsra
        ldx #RowFlags_
        leax a,x

        lda ,x
        ora SetRowFlags_low
        sta ,x+
        lda ,x
        ora SetRowFlags_high
        sta ,x
    puls a,b,x,y
rts


; void RollDown();
cseg
RollDown_: public RollDown_
    pshs a,x,y
        ldx #Ground_+VVramWidth*(GroundHeight-1)
        ldy #VVramWidth*(GroundHeight-1)
        do
            leax -1,x
            lda ,x
            sta VVramWidth,x
            leay -1,y
        while ne | wend
    puls a,x,y
rts
