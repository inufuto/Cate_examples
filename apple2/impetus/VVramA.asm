include 'ZeroPage.inc'
include 'VVram.inc'

GroundHeight equ VVramHeight+TileSize
ext Status_


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


; void RollDown();
RollDown_pSource equ ZW0
RollDown_pDestination equ ZW1
RollDown_yCount equ ZB1
GroundBottom equ Ground_+VVramWidth*(GroundHeight-1)
cseg
RollDown_: public RollDown_
    pha
        lda #low GroundBottom | sta <RollDown_pDestination
        lda #high GroundBottom | sta <RollDown_pDestination+1
        lda #GroundHeight-1 | sta <RollDown_yCount
        do
            lda <RollDown_pDestination | sec|sbc #VVramWidth | sta <RollDown_pSource
            lda <RollDown_pDestination+1 | sbc #0 | sta <RollDown_pSource+1
            ldy #VVramWidth
            do
                dey
                lda (<RollDown_pSource),y
                sta (<RollDown_pDestination),y
                cpy #0
            while ne | wend
            lda <RollDown_pSource | sta <RollDown_pDestination
            lda <RollDown_pSource+1 | sta <RollDown_pDestination+1
            dec <RollDown_yCount
        while ne | wend
    pla
rts


; void StatusToVVram();
StatusToVVram_pStatus equ ZW0
StatusToVVram_pVVram equ ZW1
cseg
StatusToVVram_: public StatusToVVram_
    pha
        lda #low Status_ | sta <StatusToVVram_pStatus
        lda #high Status_ | sta <StatusToVVram_pStatus+1
        lda #low VVramFront_ | sta <StatusToVVram_pVVram
        lda #high VVramFront_ | sta <StatusToVVram_pVVram+1
        ldy #0
        do
            lda (StatusToVVram_pStatus),y
            cmp #0
            if ne
                sta (StatusToVVram_pVVram),y
            endif
            iny
            cpy #VVramWidth*2
        while ne | wend
    pla
rts
