include 'ZeroPage.inc'

VVramWidth equ 32;
VVramHeight equ 22;

ext VVramBack_, VVramFront_, RowFlags_

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
        sta Zp.Word | lda #0 | sta Zp.Word+1
        asl Zp.Word | rol Zp.Word+1 ;16
        asl Zp.Word | rol Zp.Word+1 ;32
        lda VVramOffset_.x_ | clc | adc Zp.Word | sta Zp.Word
        lda Zp.Word+1 | adc #0 | sta Zp.Word+1
        ldy Zp.Word | ldx Zp.Word+1
	pla
rts


; void VVramBackToFront()
pBack equ Zp.TmpX0
pFront equ Zp.TmpX1
count equ Zp.Counter0
cseg
VVramBackToFront_: public VVramBackToFront_
    pha
        lda #low VVramBack_ | sta pBack
        lda #high VVramBack_ | sta pBack+1
        lda #low VVramFront_ | sta pFront
        lda #high VVramFront_ | sta pFront+1
        lda #VVramHeight/2 | sta count
        do
            ldy #0
            do
                lda (pBack),y
                sta (pFront),y
                iny
                cpy #VVramWidth*2
            while ne | wend
            lda pBack | clc | adc #low VVramWidth*2 | sta pBack
            lda pBack+1 | adc #high VVramWidth*2 | sta pBack+1
            lda pFront | clc | adc #low VVramWidth*2 | sta pFront
            lda pFront+1 | adc #high VVramWidth*2 | sta pFront+1
            dec count
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
        lda SetRowFlags_@Param1 | sta <Zp.Word+1
        lda #0 | sta <Zp.Word
        lda SetRowFlags_@Param0
        tax
            and #7
            tay
            if ne
                do
                    asl <Zp.Word+1 | rol <Zp.Word
                    dey
                while ne | wend
            endif
        txa
        lsr a | lsr a | lsr a | and #3
        tax
        lda RowFlags_,x
        ora <Zp.Word+1
        sta RowFlags_,x
        lda RowFlags_+1,x
        ora <Zp.Word
        sta RowFlags_+1,x
	pla
rts
