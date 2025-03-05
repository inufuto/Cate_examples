include "ZeroPage.inc"
include "VVram.inc"

ext VVramBack_,VVramFront_,RowFlags_

offset equ ZW0
pBack equ ZW0
pFront equ ZW1
count equ ZB0
lowFlags equ ZB0
highFlags equ ZB1


; word VVramOffset(byte x, byte y)
dseg
VVramOffset_@Param0: public	VVramOffset_@Param0
VVramOffset_x:
	defs 1
VVramOffset_@Param1: public	VVramOffset_@Param1
VVramOffset_y:
	defs 1
cseg
VVramOffset_: public	VVramOffset_
	pha
        lda	VVramOffset_y
        asl a | asl a | asl a  ;*8
        sta <offset | lda #0 | sta <offset+1
        asl <offset | rol <offset+1 ;16
        asl <offset | rol <offset+1 ;32
        lda VVramOffset_x | clc | adc <offset | sta <offset
        lda <offset+1 | adc #0 | sta <offset+1
        ldy <offset | ldx <offset+1
	pla
rts


; void ClearVVramBack();
cseg
ClearVVramBack_: public ClearVVramBack_
    pha
        lda #low VVramBack_ | sta <pBack
        lda #high VVramBack_ | sta <pBack+1
        lda #0
        ldx #VVramHeight/8
        do
            ldy #0
            do
                sta (<pBack),y | iny
            while ne | wend
            inc <pBack+1
            dex
        while ne | wend
    pla
rts


; void VVramBackToFront()
cseg
VVramBackToFront_: public VVramBackToFront_
    pha
        lda #low VVramBack_ | sta <pBack
        lda #high VVramBack_ | sta <pBack+1
        lda #low VVramFront_ | sta <pFront
        lda #high VVramFront_ | sta <pFront+1
        lda #VVramHeight/8 | sta <count
        do
            ldy #0
            do
                lda (<pBack),y
                sta (<pFront),y
                iny
            while ne | wend
            inc <pBack+1
            inc <pFront+1
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
cseg
SetRowFlags_: public SetRowFlags_
    pha
        lda SetRowFlags_@Param1 | sta <lowFlags
        lda #0 | sta <highFlags
       
        lda SetRowFlags_@Param0
        tay
        and #7
        tax
        do | while ne
            asl <lowFlags | rol <highFlags
            dex
        wend
        
        tya
        lsr a | lsr a | lsr a
        tax
        
        lda RowFlags_,x
        ora <lowFlags
        sta RowFlags_,x
        inx
        lda RowFlags_,x
        ora <highFlags
        sta RowFlags_,x
    pla
rts


; void ClearRowFlags();
cseg
ClearRowFlags_: public ClearRowFlags_
    pha
        lda #0 | tax
        do
            sta RowFlags_,x | inx
            cpx #4
        while ne | wend
    pla
rts
