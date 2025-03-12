include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_,LeftX_,DotOffset_

ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte
StageTop equ 4

pChar equ ZW0
pVVram equ ZW1
cellWord equ ZW2
xCount equ ZW3
yCount equ ZW3+1
shiftCount equ ZB0
xPos equ ZB1
fCount equ ZB2
cCount equ ZB3
charOffset equ ZB4
xLeft equ ZB5

zseg
mapOffset:
    defw 0
vOffset:
    defw 0


; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    pha
        stz <pChar
        lda DotOffset_
        and #3
        lsr a | ror <pChar
        sta <pChar+1
        lda <pChar | clc|adc #low CellChars0 | sta <pChar
        lda <pChar+1 | adc #high CellChars0 | sta <pChar+1

        lda LeftX_
        tax

        lsr a | lsr a | lsr a | sta <mapOffset

        ldy #0
        txa
        and #1
        if ne
            dey
        endif
        sty <xLeft

        lda #low(VVram_+VVramWidth*StageTop) | sta <pVVram
        lda #high(VVram_+VVramWidth*StageTop) | sta <pVVram+1

        lda #FloorCount | sta <fCount
        do
            lda <xLeft | sta <xPos | sta <vOffset
            lda LeftX_ | lsr a | and #3 | sta <shiftCount

            ldx <mapOffset
            lda CellMap_,x | inx | sta <cellWord
            lda CellMap_,x | inx
            stx <mapOffset
            ldx <shiftCount
            do | while ne
                lsr a | ror <cellWord
                lsr a | ror <cellWord
                dex
            wend
            sta <cellWord+1

            lda #VVramWidth/2+1 | sta <cCount
            do
                lda <cellWord | and #$0f
                asl a | asl a | asl a | sta <charOffset

                lda #FloorHeight | sta <yCount
                do
                    lda #2 | sta <xCount
                    do
                        lda <xPos
                        cmp #VVramWidth
                        if cc
                            ldy <charOffset | lda (<pChar),y
                            ldy <vOffset | sta (pVVram),y
                        endif
                        inc <charOffset
                        inc <vOffset
                        inc <xPos

                        dec <xCount
                    while ne | wend
                    dec <xPos | dec <xPos
                    lda <vOffset | clc|adc #VVramWidth-2 | sta <vOffset

                    dec <yCount
                while ne | wend
                inc <xPos | inc <xPos
                lda <vOffset | clc|adc #-VVramWidth*FloorHeight+2 | sta <vOffset

                lda <cellWord+1
                lsr a | ror <cellWord
                lsr a | ror <cellWord
                sta <cellWord+1

                lda <shiftCount
                inc a | and #3
                sta <shiftCount
                if eq
                    ldx <mapOffset
                    lda CellMap_,x | inx | sta <cellWord+1
                    stx <mapOffset
                endif
                dec <cCount
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth*4 | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            lda <shiftCount
            if eq
                dec <mapOffset
            endif
            lda <mapOffset | clc|adc #MapWidth-(VVramWidth/2+1)/ColumnsPerByte-2 | sta <mapOffset

            dec <fCount
        while ne | wend
    pla
rts

CellChars0:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
CellChars1:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space1
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight1,Char_Item_TopRight_Space1
	defb Char_Item_BottomLeft_Item_BottomRight1,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space1
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle1,Char_Needle_Space1
	defb Char_Floor_Floor0,Char_Floor_Space1
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor1
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight1,Char_Item_TopRight_Space1
	defb Char_Item_BottomLeft_Item_BottomRight1,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle1,Char_Needle_Space1
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor1
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight1,Char_Item_TopRight_Space1
	defb Char_Item_BottomLeft_Item_BottomRight1,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle1,Char_Needle_Space1
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle1
	defb Char_Space,Char_Space_Floor1
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle1
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight1,Char_Item_TopRight_Space1
	defb Char_Item_BottomLeft_Item_BottomRight1,Char_Space_Needle1
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle1,Char_Needle_Needle1
	defb Char_Floor_Floor0,Char_Floor_Floor0
CellChars2:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space2
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space2
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Space2
	defb Char_Floor_Floor0,Char_Floor_Space2
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor2
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Space2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_BottomLeft2
	defb Char_Space,Char_Space_Floor2
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_BottomLeft2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space_Item_BottomLeft2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Item_BottomLeft2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle2
	defb Char_Space,Char_Space_Floor2
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space_Needle2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Needle2
	defb Char_Floor_Floor0,Char_Floor_Floor0
CellChars3:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space3
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight3,Char_Space
	defb Char_Item_BottomLeft_Item_BottomRight3,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space3
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle3,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space3
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor3
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight3,Char_Space
	defb Char_Item_BottomLeft_Item_BottomRight3,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle3,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft3
	defb Char_Space,Char_Space_Item_BottomLeft3
	defb Char_Space,Char_Space_Floor3
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft3
	defb Char_Space,Char_Space_Item_BottomLeft3
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight3,Char_Space_Item_TopLeft3
	defb Char_Item_BottomLeft_Item_BottomRight3,Char_Space_Item_BottomLeft3
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft3
	defb Char_Needle_Needle3,Char_Space_Item_BottomLeft3
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Needle_Needle3
	defb Char_Space,Char_Space_Floor3
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Needle_Needle3
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight3,Char_Space
	defb Char_Item_BottomLeft_Item_BottomRight3,Char_Needle_Needle3
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle3,Char_Needle_Needle3
	defb Char_Floor_Floor0,Char_Floor_Floor0
