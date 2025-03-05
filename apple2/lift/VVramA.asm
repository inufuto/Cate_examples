include "ZeroPage.inc"
include "VVram.inc"
include "CHars.inc"

ext VVram_
ext CellMap_

Cell_Type_Floor equ 08h
Cell_Type_LiftBottom equ 18h


pSource equ ZW2
pDestination equ ZW3

sourceOffset equ ZB0
destinationOffset equ ZB1
floorCounter equ ZB3
columnCounter equ ZB4


; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param0: public	VVramPtr_@Param0
VVramPtr_.x_:	defs 1
VVramPtr_@Param1: public	VVramPtr_@Param1
VVramPtr_.y_:	defs 1
cseg
VVramPtr_: public	VVramPtr_
	pha
        lda	VVramPtr_.y_
        asl a | asl a | asl a  ;*8
        sta <ZW0 | lda #0 | sta <ZW0+1
        asl <ZW0 | rol <ZW0+1 ;16
        asl <ZW0 | rol <ZW0+1 ;32
        lda VVramPtr_.x_ | clc | adc <ZW0 | sta <ZW0
        lda <ZW0+1 | adc #0 | sta <ZW0+1
        lda <ZW0 | clc|adc #low VVram_ | tay
        lda <ZW0+1 | adc #high VVram_ | tax
	pla
rts


; DrawBackGround();
cseg
DrawBackGround_: public DrawBackGround_
    pha
        lda #low VVram_ | sta <pDestination
        lda #high VVram_ | sta <pDestination+1
        ldy #0

        lda #Char_Roof_Left | sta (<pDestination),y | iny
        lda #Char_Roof_Center
        ldx #VVramWidth-2
        do
            sta (<pDestination),y | iny
            dex
        while ne | wend
        lda #Char_Roof_Right | sta (<pDestination),y | iny

        lda #Char_Roof_Center
        ldx #VVramWidth
        do
            sta (<pDestination),y | iny
            dex
        while ne | wend

        lda #low CellMap_ | sta <pSource
        lda #high CellMap_ | sta <pSource+1
        lda #0 | sta <sourceOffset
        lda #low (VVram_+VVramWidth*2) | sta <pDestination
        lda #high (VVram_+VVramWidth*2) | sta <pDestination+1
        lda #5 | sta <floorCounter
        do
            lda #0 | sta <destinationOffset
            lda #16 | sta <columnCounter
            do
                ldy <destinationOffset
                ldx #3
                do
                    lda #Char_Space
                    sta (<pDestination),y | iny
                    sta (<pDestination),y
                    tya | clc|adc #VVramWidth-2+1 | tay
                    dex
                while ne | wend
                sty <destinationOffset

                ldy <sourceOffset
                lda (<pSource),y | iny
                sty <sourceOffset
                and #Cell_Type_LiftBottom
                cmp #Cell_Type_LiftBottom
                if eq
                    lda #Char_LiftBottom
                else
                    and #Cell_Type_Floor
                    if ne
                        lda #Char_Floor
                    else
                        lda #Char_Space
                    endif
                endif
                ldy <destinationOffset
                sta (<pDestination),y | iny
                sta (<pDestination),y

                tya | clc|adc #-VVramWidth*3+1 | sta <destinationOffset
                dec <columnCounter
            while ne | wend
                        _deb: public _deb
            lda <pDestination | clc|adc #low (VVramWidth*4) | sta <pDestination
            lda <pDestination+1 | adc #high (VVramWidth*4) | sta <pDestination+1
            dec <floorCounter
        while ne | wend
    pla
rts