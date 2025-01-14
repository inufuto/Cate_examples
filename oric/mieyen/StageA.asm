include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext CellMap_
ext VVram_

pCell equ ZW0

; ptr<byte> CellMapPtr(byte column, byte floor);
dseg
CellMapPtr_@Param1: public CellMapPtr_@Param1
CellMapPtr_y:
	defs 1
cseg
CellMapPtr_: public CellMapPtr_
    pha
        lda CellMapPtr_y
        asl a ;*2
        asl a ;*4
        clc|adc CellMapPtr_y ;*5
        sta <pCell

        tya
        lsr a
        clc|adc <pCell
        clc|adc #low CellMap_ | tay
        lda #0 | adc #high CellMap_ | tax
    pla
rts


Cell_RightWall equ 01h
Cell_BottomWall equ 02h
Cell_Dot equ 04h
Cell_Food equ 08h
ColumnCount equ 10
RowCount equ 7
ColumnWidth equ 3
RowHeight equ 3
Char_Wall equ Char_Logo+$0f

pVVram equ ZW0
cellOffset equ ZB0
cellByte equ ZB1
rCount equ ZB2
cCount equ ZB3
bCount equ ZB4

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    pha
        lda #Char_Wall
        ldx #0
        do
            sta VVram_,x
            inx
            cpx #ColumnWidth*ColumnCount+1
        while ne | wend

        lda #low CellMap_ | sta <pCell
        lda #high CellMap_ | sta <pCell+1

        lda #low(VVram_+VVramWidth) | sta <pVVram
        lda #high(VVram_+VVramWidth) | sta <pVVram+1

        ldx #0 | stx <cellOffset
        lda #RowCount | sta <rCount
        do
            lda #Char_Wall
            ldy #0 | sta (<pVVram),y
            ldy #VVramWidth | sta (<pVVram),y
            ldy #VVramWidth*2 | sta (<pVVram),y
            ldy #1

            lda #ColumnCount/2 | sta <cCount
            do
                ldx <cellOffset
                lda CellMap_,x | inx
                sta <cellByte
                stx <cellOffset

                lda #2 | sta <bCount
                do
                    lda <cellByte
                    and #$0c
                    cmp #Cell_Food
                    if eq
                        lda #Char_Food | sta (<pVVram),y
                        iny
                        lda #Char_Food+1 | sta (<pVVram),y
                        tya | clc|adc #VVramWidth-1 | tay
                        lda #Char_Food+2 | sta (<pVVram),y
                        iny
                        lda #Char_Food+3 | sta (<pVVram),y
                        jmp nextCell
                    endif
                    cmp #Cell_Dot
                    if eq
                        lda #Char_Dot | sta (<pVVram),y
                        iny
                        lda #Char_Space | sta (<pVVram),y
                        tya | clc|adc #VVramWidth-1 | tay
                        lda #Char_Dot+1 | sta (<pVVram),y
                        iny
                        lda #Char_Space | sta (<pVVram),y
                        jmp nextCell
                    endif
                    lda #Char_Space | sta (<pVVram),y
                    iny
                    lda #Char_Space | sta (<pVVram),y
                    tya | clc|adc #VVramWidth-1 | tay
                    lda #Char_Space | sta (<pVVram),y
                    iny
                    lda #Char_Space | sta (<pVVram),y
                    nextCell:
                    tya | clc|adc #1-VVramWidth | tay

                    lda <cellByte
                    and #Cell_RightWall
                    if ne
                        lda #Char_Wall
                    else
                        lda #Char_Space
                    endif
                    tax | sta (<pVVram),y
                    tya | clc|adc #VVramWidth | tay
                    txa | sta (<pVVram),y
                    tya | clc|adc #VVramWidth-2 | tay

                    lda <cellByte
                    and #Cell_BottomWall
                    if ne
                        lda #Char_Wall
                    else
                        lda #Char_Space
                    endif
                    sta (<pVVram),y
                    iny
                    sta (<pVVram),y
                    iny

                    lda #Char_Wall
                    sta (<pVVram),y
                    tya | clc|adc #1-VVramWidth*2 | tay

                    lda <cellByte
                    lsr a | lsr a | lsr a | lsr a
                    sta <cellByte

                    dec <bCount
                while ne | wend
                dec <cCount
            while ne | wend

            lda <pVVram | clc|adc #VVramWidth*3 | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            dec <rCount
        while ne | wend
    pla
rts
