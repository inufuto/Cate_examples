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

ext UpperChars0,LowerChars0
ext UpperChars1,LowerChars1
ext UpperChars2,LowerChars2

pVVram equ ZW1
cellByte equ ZW2
nextByte equ ZW2+1
mapOffset equ ZB0
cmpByte equ ZB1
rCount equ ZB2
cCount equ ZB3
yCount equ ZB4
xCount equ ZB5

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    pha
        lda #Char_B20WW0
        ldx #0
        do
            sta VVram_,x
            inx
            cpx #VVramWidth
        while ne | wend

        
        lda #low(VVram_+VVramWidth) | sta <pVVram
        lda #high(VVram_+VVramWidth) | sta <pVVram+1
        ldx #0 | stx <mapOffset

        lda #RowCount | sta <rCount
        do
            ldy #0
            
            ldx <mapOffset
            lda CellMap_,x
            asl a | asl a | asl a | asl a
            ora #$01 ; left wall
            sta <cellByte

            jsr Cell0
            ldx <mapOffset
            lda CellMap_,x | inx
            sta <cellByte
            lda CellMap_,x | inx
            sta <nextByte
            stx <mapOffset

            lda #ColumnCount/4 | sta <cCount
            do
                jsr ShiftCell
                jsr Cell1
                jsr ShiftCell
                jsr Cell2
                jsr GetNext
                jsr ShiftCell
                jsr Cell0
                jsr ShiftCell
                jsr GetNext

                dec <cCount
            while ne | wend
            jsr ShiftCell
            jsr Cell1
            dey
            lda #RowHeight | sta <yCount
            do
                lda #Char_B20WW0 | sta (<pVVram),y
                tya | clc|adc #VVramWidth | tay
                dec <yCount
            while ne | wend
                                    _deb: public _deb
            dec <mapOffset

            lda <pVVram | clc|adc #VVramWidth*RowHeight | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            dec <rCount
        while ne | wend
    pla
rts
ShiftCell:
    lda <nextByte
    lsr a | ror <cellByte
    lsr a | ror <cellByte
    lsr a | ror <cellByte
    lsr a | ror <cellByte
    sta <nextByte
rts
GetNext:
    ldx <mapOffset
    lda CellMap_,x | inx
    sta <nextByte
    stx <mapOffset
rts
Cell0:
    lda <cellByte
    and #$d1
    sta <cmpByte
    ldx #0
    do
        lda UpperChars0,x | inx
        cmp <cmpByte
    while ne
        txa | clc|adc #6 | tax
    wend
    lda #2 | sta <yCount
    do
        lda #3 | sta <xCount
        do
            lda UpperChars0,x | inx
            sta (<pVVram),y | iny
            dec <xCount
        while ne | wend
        tya | clc|adc #VVramWidth-3 | tay
        dec <yCount
    while ne | wend

    lda <cellByte
    and #$20
    sta <cmpByte
    ldx #0
    do
        lda LowerChars0,x | inx
        cmp <cmpByte
    while ne
        inx | inx | inx
    wend
    lda #3 | sta <xCount
    do
        lda LowerChars0,x | inx
        sta (<pVVram),y | iny
        dec <xCount
    while ne | wend
    
    tya | clc|adc #-VVramWidth*2 | tay
rts
Cell1:
    lda <cellByte
    and #$cd
    sta <cmpByte
    ldx #0
    do
        lda UpperChars1,x | inx
        cmp <cmpByte
    while ne
        txa | clc|adc #6 | tax
    wend
    lda #2 | sta <yCount
    do
        lda #3 | sta <xCount
        do
            lda UpperChars1,x | inx
            sta (<pVVram),y | iny
            dec <xCount
        while ne | wend
        tya | clc|adc #VVramWidth-3 | tay
        dec <yCount
    while ne | wend

    lda <cellByte
    and #$22
    sta <cmpByte
    ldx #0
    do
        lda LowerChars1,x | inx
        cmp <cmpByte
    while ne
        inx | inx | inx
    wend
    lda #3 | sta <xCount
    do
        lda LowerChars1,x | inx
        sta (<pVVram),y | iny
        dec <xCount
    while ne | wend
    
    tya | clc|adc #-VVramWidth*2 | tay
rts
Cell2:
    lda <cellByte
    and #$cd
    sta <cmpByte
    ldx #0
    do
        lda UpperChars2,x | inx
        cmp <cmpByte
    while ne
        txa | clc|adc #6 | tax
    wend
    lda #2 | sta <yCount
    do
        lda #3 | sta <xCount
        do
            lda UpperChars2,x | inx
            sta (<pVVram),y | iny
            dec <xCount
        while ne | wend
        tya | clc|adc #VVramWidth-3 | tay
        dec <yCount
    while ne | wend

    lda <cellByte
    and #$22
    sta <cmpByte
    ldx #0
    do
        lda LowerChars2,x | inx
        cmp <cmpByte
    while ne
        inx | inx | inx
    wend
    lda #3 | sta <xCount
    do
        lda LowerChars2,x | inx
        sta (<pVVram),y | iny
        dec <xCount
    while ne | wend
    
    tya | clc|adc #-VVramWidth*2 | tay
rts