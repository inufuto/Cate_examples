include "ZeroPage.inc"
include "VVram.inc"
include "Vram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_,LeftX_

ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

pVVram equ ZW0
xLeft equ ZW1
cellOffset equ ZW1+1

xPos equ ZB0
fCount equ ZB1
cCount equ ZB2
yCount equ ZB3
xCount equ ZB4
cellByte equ ZB5
xMod equ ZB6


; ptr<byte> VVramPtr(byte x, byte y)
dseg
VVramPtr_@Param0: public VVramPtr_@Param0
VVramPtr_x:
	defs 1
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defs 1
cseg
VVramPtr_: public VVramPtr_
	pha
        lda #0 | sta <pVVram+1
        lda	VVramPtr_y
        asl a | asl a | asl a  ;*8
        asl a | rol <pVVram+1 ;16
        asl a | rol <pVVram+1 ;32
        clc|adc VVramPtr_x | sta <pVVram
        lda <pVVram+1 | adc #0 | sta <pVVram+1
        lda <pVVram | clc|adc #low VVram_ | tay
        lda <pVVram+1 | adc #high VVram_ | tax
	pla
rts


CellChars:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor,Char_Floor
	; 2
	defb Char_Space,Char_Space
	defb Char_Item+0,Char_Item+1
	defb Char_Item+2,Char_Item+3
	defb Char_Floor,Char_Floor
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle,Char_Needle
	defb Char_Floor,Char_Floor
; void MapToVVram();
MapToVVram_: public MapToVVram_
    pha
        lda #0
        ldx #0
        do
            sta VVram_,x | inx
            cpx #VVramWidth*StageTop
        while ne | wend

        lda #low (VVram_+VVramWidth*StageTop) | sta <pVVram
        lda #high (VVram_+VVramWidth*StageTop) | sta <pVVram+1
        ldy #0
        lda LeftX_
        and #1
        if ne
           dey
        endif
        sty <xLeft

        lda LeftX_
        lsr a | lsr a | lsr a
        sta <cellOffset

        lda #FloorCount | sta <fCount
        do
            lda <xLeft | sta <xPos | tay
            lda LeftX_ | lsr a | and #3 | sta <xMod

            ldx <cellOffset
            lda CellMap_,x | inx
            stx <cellOffset
            ldx <xMod
            do | while ne
                lsr a | lsr a
                dex
            wend
            sta <cellByte

            lda #VVramWidth/2+1 | sta <cCount
            do
                lda <cellByte | and #3
                asl a | asl a | asl a ;*8
                tax

                lda #4 | sta <yCount
                do
                    lda #2 | sta <xCount
                    do
                        lda <xPos
                        cmp #VVramWidth
                        if cc
                            lda CellChars,x
                            sta (<pVVram),y
                        endif
                        inx
                        iny
                        inc <xPos
                        dec <xCount
                    while ne | wend
                    tya | clc|adc #VVramWidth-2 | tay

                    dec <xPos | dec <xPos
                    dec <yCount
                while ne | wend
                tya | clc|adc #-VVramWidth*FloorHeight+2 | tay
                inc <xPos | inc <xPos

                lda <cellByte
                lsr a | lsr a
                sta <cellByte

                lda <xMod
                clc|adc #1 | and #3
                sta <xMod
                if eq
                    ldx <cellOffset
                    lda CellMap_,x | inx
                    sta <cellByte
                    stx <cellOffset
                endif
                dec <cCount
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth*FloorHeight | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            lda <xMod
            if eq
                ldx <cellOffset
                dex
                stx <cellOffset
            endif

            lda <cellOffset | clc|adc #MapWidth-(VVramWidth/2+1)/ColumnsPerByte-1 | sta <cellOffset
            dec <fCount
        while ne | wend
    pla
rts
