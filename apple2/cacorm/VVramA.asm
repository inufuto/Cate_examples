include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_
ext LineCharOffset_

MapWidth equ VVramWidth/2
MapHeight equ VVramHeight/2

Cell_Wall equ 10h
Cell_Item equ 20h
Cell_Mask equ 0f0h

pVVram equ ZW0

rowCount equ ZB0
columnCount equ ZB1
mapOffset equ ZB2
yCount equ ZB3
xCount equ ZB4

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
        sta <pVVram | lda #0 | sta <pVVram+1
        asl <pVVram | rol <pVVram+1 ;16
        asl <pVVram | rol <pVVram+1 ;32
        lda VVramPtr_.x_ | clc | adc <pVVram | sta <pVVram
        lda <pVVram+1 | adc #0 | sta <pVVram+1
        lda <pVVram | clc|adc #low VVram_ | tay
        lda <pVVram+1 | adc #high VVram_ | tax
	pla
rts


; void MapToVVram();
cseg
LineChars:
    defb Char_Space, Char_Space, Char_Space, Char_Space ; none
    defb Char_Line_Bottom, Char_Space, Char_Line_Top, Char_Space ; left
    defb Char_Space, Char_Line_Bottom, Char_Space, Char_Line_Top ; right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_Top, Char_Line_Top ; left right
    defb Char_Line_Right, Char_Line_Left, Char_Space, Char_Space ; top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_Top, Char_Space ; top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Space, Char_Line_Top ; top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_Top, Char_Line_Top ; top left right
    defb Char_Space, Char_Space, Char_Line_Right, Char_Line_Left ; bottom
    defb Char_Line_Bottom, Char_Space, Char_Line_RightTop, Char_Line_Left ; bottom left
    defb Char_Space, Char_Line_Bottom, Char_Line_Right, Char_Line_LeftTop ; bottom right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom left right
    defb Char_Line_Right, Char_Line_Left, Char_Line_Right, Char_Line_Left ; bottom top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_RightTop, Char_Line_Left ; bottom top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Line_Right, Char_Line_LeftTop ; bottom top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom top left right

MapToVVram_: public MapToVVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        ldx #0 | stx <mapOffset
        lda #MapHeight | sta <rowCount
        do
            ldy #0
            lda #MapWidth | sta <columnCount
            do
                                                _deb: public _deb
                ldx <mapOffset | lda CellMap_,x | inx | stx <mapOffset
                cmp #Cell_Wall
                if eq
                    lda #Char_Block
                    jmp byChar
                endif
                cmp #Cell_Item
                if eq
                    lda #Char_Item
                    byChar:
                    ldx #2 | stx <yCount
                    do
                        ldx #2
                        do
                            sta (pVVram),y | iny
                            clc|adc #1
                            dex 
                        while ne | wend
                        pha
                            tya | clc|adc #VVramWidth-2 | tay
                        pla
                        dec <yCount
                    while ne | wend
                    jmp nextCell
                endif
                and #$0f
                asl a | asl a
                tax
                lda #2 | sta <yCount
                do
                    lda #2 | sta <xCount
                    do
                        lda LineChars,x | inx
                        cmp #Char_Space
                        if ne
                            clc|adc LineCharOffset_
                        endif
                        sta (pVVram),y | iny
                        dec <xCount
                    while ne | wend
                    tya | clc|adc #VVramWidth-2 | tay
                    dec <yCount
                while ne | wend
                nextCell:
                tya | clc|adc #2-VVramWidth*2 | tay
                dec <columnCount
            while ne | wend
            lda <pVVram | clc|adc #low VVramWidth*2 | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth*2 | sta <pVVram+1
            dec <rowCount
        while ne | wend                
    pla
rts
