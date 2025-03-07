include 'ZeroPage.inc'
include 'VVram.inc'

TileWidth equ 2
GroundWidth equ VVramWidth+TileWidth

ext Background_

dseg
VVramBack_: public VVramBack_
    defs VVramWidth*VVramHeight
VVramFront_: public VVramFront_
    defs VVramWidth*VVramHeight
RowFlags_: public RowFlags_
    defs 3+1


; word VVramOffset(byte x, byte y)
dseg
VVramOffset_@Param0: public	VVramOffset_@Param0
VVramOffset_.x_:	defs 1
VVramOffset_@Param1: public	VVramOffset_@Param1
VVramOffset_.y_:	defs 1
cseg
VVramOffset_: public	VVramOffset_
	pha
        lda	VVramOffset_.y_
        asl a | asl a | asl a  ;*8
        sta <ZW0 | lda #0 | sta <ZW0+1
        asl <ZW0 | rol <ZW0+1 ;16
        asl <ZW0 | rol <ZW0+1 ;32
        lda VVramOffset_.x_ | clc | adc <ZW0 | sta <ZW0
        lda <ZW0+1 | adc #0 | sta <ZW0+1
        ldy <ZW0 | ldx <ZW0+1
	pla
rts


; void VVramBackToFront()
pBack equ ZW2
pFront equ ZW3
count equ ZB3
cseg
VVramBackToFront_: public VVramBackToFront_
    pha
        lda #low VVramBack_ | sta <pBack
        lda #high VVramBack_ | sta <pBack+1
        lda #low VVramFront_ | sta <pFront
        lda #high VVramFront_ | sta <pFront+1
        lda #VVramHeight/2 | sta <count
        do
            ldy #0
            do
                lda (<pBack),y
                sta (<pFront),y
                iny
                cpy #VVramWidth*2
            while ne | wend
            lda <pBack | clc | adc #low VVramWidth*2 | sta <pBack
            lda <pBack+1 | adc #high VVramWidth*2 | sta <pBack+1
            lda <pFront | clc | adc #low VVramWidth*2 | sta <pFront
            lda <pFront+1 | adc #high VVramWidth*2 | sta <pFront+1
            dec <count
        while ne | wend

        lda #0
        ldy #0
        do
            sta RowFlags_,y
            iny
            cpy #3
        while ne | wend
    pla
rts


; void SetRowFlags(byte y, byte b);
dseg
SetRowFlags_@Param0: public SetRowFlags_@Param0
    defb 0
SetRowFlags_@Param1: public SetRowFlags_@Param1
    defb 0
SetRowFlags_low equ ZB0
SetRowFlags_high equ ZB1
cseg
SetRowFlags_: public SetRowFlags_
    pha
        lda SetRowFlags_@Param1 | sta <SetRowFlags_low
        lda #0 | sta <SetRowFlags_high
       
        lda SetRowFlags_@Param0
        tay
        and #7
        tax
        do | while ne
            asl <SetRowFlags_low | rol <SetRowFlags_high
            dex
        wend
        
        tya
        lsr a | lsr a | lsr a
        tax
        
        lda RowFlags_,x
        ora <SetRowFlags_low
        sta RowFlags_,x
        inx
        lda RowFlags_,x
        ora <SetRowFlags_high
        sta RowFlags_,x
    pla
rts


; void GroundToVVram();
pSource equ ZW0
pDestination equ ZW1
yCount equ ZB1
cseg
GroundToVVram_: public GroundToVVram_
    pha
        lda #low Background_ | sta <pSource
        lda #high Background_ | sta <pSource+1
        lda #low VVramBack_ | sta <pDestination
        lda #high VVramBack_ | sta <pDestination+1
        lda #VVramHeight | sta <yCount
        do
            ldy #0
            do
                lda (<pSource),y
                sta (<pDestination),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pSource | clc | adc #GroundWidth | sta <pSource
            lda <pSource+1 | adc #0 | sta <pSource+1
            lda <pDestination | clc | adc #VVramWidth | sta <pDestination
            lda <pDestination+1 | adc #0 | sta <pDestination+1
            dec <yCount
        while ne | wend
    pla
rts
