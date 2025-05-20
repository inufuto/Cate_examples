include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_
ext WallChars0,WallChars1,WallChars2,WallChars3
ext CellChars0,CellChars1,CellChars2,CellChars3

ColumnCount equ 10
RowCount equ 7

Cell_RightWall equ $01
Cell_BottomWall equ $02
Cell_TypeMask equ $0c
Cell_LeftWall equ $10
Cell_TopWall equ $20
Cell_Visible equ $80

pVVram equ ZW0

cellOffset equ ZB0
cell equ ZB1
typeByte equ ZB2
row equ ZB3
column equ ZB4
xCount equ ZB5
yCount equ ZB6

; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        ldx #0
        stx <row
        do
            ldy #0
            sty <column
            jsr Wall0
            jsr Wall1
            jsr Wall2
            jsr Wall3
            jsr Wall0
            jsr Wall1
            jsr Wall2
            jsr Wall3
            jsr Wall0
            jsr Wall1
            jsr WallEnd
            txa | sec|sbc #ColumnCount | tax
            iny

            lda #0 | sta <column
            jsr Cell0
            jsr Cell1
            jsr Cell2
            jsr Cell3
            jsr Cell0
            jsr Cell1
            jsr Cell2
            jsr Cell3
            jsr Cell0
            jsr Cell1
            jsr CellEnd
            
            lda <pVVram | clc|adc #VVramWidth*3 | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            ldy <row | iny | sty <row
            cpy #RowCount
        while ne | wend
        ldy #0
        sty <column
        jsr Bottom0
        jsr Bottom1
        jsr Bottom2
        jsr Bottom3
        jsr Bottom0
        jsr Bottom1
        jsr Bottom2
        jsr Bottom3
        jsr Bottom0
        jsr Bottom1
        jsr BottomEnd
    pla
rts
Wall0:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_TopWall
        if ne
            lda #7
        else
            lda #5
        endif
        sta <typeByte
    else
        lda <row
        if ne
            lda CellMap_-ColumnCount,x
            sta <cell
            and #Cell_Visible
            if ne
                lda <cell
                and #Cell_BottomWall
                if ne
                    lda #7
                else
                    lda #5
                endif
                sta <typeByte
            endif
            lda <column
            if ne
                lda CellMap_-ColumnCount-1,x
                ora CellMap_-1,x
                and #Cell_Visible
                if ne
                    lda <typeByte | ora #4 | sta <typeByte
                endif
            endif
            lda CellMap_-ColumnCount+1,x
            ora CellMap_+1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #1 | sta <typeByte
            endif
        else
            lda <column
            if ne
                lda CellMap_-1,x
                and #Cell_Visible
                if ne
                    lda <typeByte | ora #4 | sta <typeByte
                endif
            endif
            lda CellMap_+1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #1 | sta <typeByte
            endif
        endif
    endif
    jsr DrawWall0
rts
DrawWall0:
    stx <cellOffset
        lda <typeByte
        asl a
        clc|adc <typeByte
        tax
        lda #3 | sta <xCount
        do
            lda WallChars0,x | inx
            sta (<pVVram),y | iny
            dec <xCount
        while ne | wend
    ldx <cellOffset
    inx
    inc <column
rts
Wall1:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_TopWall
        if ne
            lda #3
        else
            lda #1
        endif
        sta <typeByte
    else
        lda <row
        if ne
            lda CellMap_-ColumnCount,x
            sta <cell
            and #Cell_Visible
            if ne
                lda <cell
                and #Cell_BottomWall
                if ne
                    lda #3
                else
                    lda #1
                endif
                sta <typeByte
            endif
            lda <column
            cmp #ColumnCount-1
            if ne
                lda CellMap_-ColumnCount+1,x
                ora CellMap_+1,x
                and #Cell_Visible
                if ne
                    lda <typeByte | ora #1 | sta <typeByte
                endif
            endif
        else
            lda <column
            cmp #ColumnCount-1
            if ne
                lda CellMap_+1,x
                and #Cell_Visible
                if ne
                    lda <typeByte | ora #1 | sta <typeByte
                endif
            endif
        endif
    endif
    jsr DrawWall1
rts
DrawWall1:
    stx <cellOffset
        lda <typeByte
        asl a
        tax
        lda #2 | sta <xCount
        do
            lda WallChars1,x | inx
            sta (<pVVram),y | iny
            dec <xCount
        while ne | wend
    ldx <cellOffset
    inx
    inc <column
rts
Wall2:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_TopWall
        if ne
            lda #7
        else
            lda #5
        endif
        sta <typeByte
    else
        lda <row
        if ne
            lda CellMap_-ColumnCount,x
            sta <cell
            and #Cell_Visible
            if ne
                lda <cell
                and #Cell_BottomWall
                if ne
                    lda #7
                else
                    lda #5
                endif
                sta <typeByte
            endif
            lda CellMap_-ColumnCount-1,x
            ora CellMap_-1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #4 | sta <typeByte
            endif
            lda CellMap_-ColumnCount+1,x
            ora CellMap_+1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #1 | sta <typeByte
            endif
        else
            lda CellMap_-1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #4 | sta <typeByte
            endif
            lda CellMap_+1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #1 | sta <typeByte
            endif
        endif
    endif
    jsr DrawWall2
rts
DrawWall2:
    stx <cellOffset
        lda <typeByte
        asl a
        tax
        lda #2 | sta <xCount
        do
            lda WallChars2,x | inx
            sta (<pVVram),y | iny
            dec <xCount
        while ne | wend
    ldx <cellOffset
    inx
    inc <column
rts
Wall3:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_TopWall
        if ne
            lda #3
        else
            lda #2
        endif
        sta <typeByte
    else
        lda <row
        if ne
            lda CellMap_-ColumnCount,x
            sta <cell
            and #Cell_Visible
            if ne
                lda <cell
                and #Cell_BottomWall
                if ne
                    lda #3
                else
                    lda #2
                endif
                sta <typeByte
            endif
            lda CellMap_-ColumnCount-1,x
            ora CellMap_-1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #2 | sta <typeByte
            endif
        else
            lda CellMap_-1,x
            and #Cell_Visible
            if ne
                lda <typeByte | ora #2 | sta <typeByte
            endif
        endif
    endif
    jsr DrawWall3
rts
DrawWall3:
    stx <cellOffset
        lda <typeByte
        asl a
        tax
        lda #2 | sta <xCount
        do
            lda WallChars3,x | inx
            sta (<pVVram),y | iny
            dec <xCount
        while ne | wend
    ldx <cellOffset
    inx
    inc <column
rts
WallEnd:
    lda #Char_Space | sta <typeByte
    lda <row
    if ne
        lda CellMap_-ColumnCount-1,x
        ora CellMap_-1,x
        and #Cell_Visible
        if ne
            lda #Char_WS4 | sta <typeByte
        endif
    else
        lda CellMap_-1,x
        and #Cell_Visible
        if ne
            lda #Char_WS4 | sta <typeByte
        endif
    endif
    lda <typeByte
    sta (pVVram),y
rts
Cell0:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_LeftWall
        if ne
            lda <typeByte | ora #8 | sta <typeByte
        endif
        lda <cell
        and #Cell_RightWall
        if ne
            lda <typeByte | ora #1 | sta <typeByte
        endif
        lda <cell
        and #Cell_TypeMask
        lsr a
        ora <typeByte | sta <typeByte
    else
        lda <column
        if ne
            lda CellMap_-1,x
            sta <cell
            and #Cell_Visible
            if ne
                lda <cell
                and #Cell_RightWall
                if ne
                    lda <typeByte | ora #8 | sta <typeByte
                endif
            endif
        endif
        lda CellMap_+1,x
        sta <cell
        and #Cell_Visible
        if ne
            lda <cell
            and #Cell_LeftWall
            if ne
                lda <typeByte | ora #1 | sta <typeByte
            endif
        endif
    endif
    stx <cellOffset
        lda <typeByte
                    _deb: public _deb
        asl a
        clc|adc <typeByte
        asl a
        tax
        lda #2 | sta <yCount
        do
            lda #3 | sta <xCount
            do
                lda CellChars0,x | inx
                sta (<pVVram),y | iny
                dec <xCount
            while ne | wend
            tya | clc|adc #VVramWidth-3 | tay
            dec <yCount
        while ne | wend
        tya | clc|adc #3-VVramWidth*2 | tay
    ldx <cellOffset
    inx
    inc <column
rts
Cell1:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_RightWall
        if ne
            lda <typeByte | ora #1 | sta <typeByte
        endif
        lda <cell
        and #Cell_TypeMask
        lsr a
        ora <typeByte | sta <typeByte
    else
        lda <column
        cmp #ColumnCount-1
        if ne
            lda CellMap_+1,x
            sta <cell
            and #Cell_Visible
            if ne
                lda <cell
                and #Cell_LeftWall
                if ne
                    lda <typeByte | ora #1 | sta <typeByte
                endif
            endif
        endif
    endif
    stx <cellOffset
        lda <typeByte
        asl a | asl a
        tax
        lda #2 | sta <yCount
        do
            lda #2 | sta <xCount
            do
                lda CellChars1,x | inx
                sta (<pVVram),y | iny
                dec <xCount
            while ne | wend
            tya | clc|adc #VVramWidth-2 | tay
            dec <yCount
        while ne | wend
        tya | clc|adc #2-VVramWidth*2 | tay
    ldx <cellOffset
    inx
    inc <column
rts
Cell2:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_LeftWall
        if ne
            lda <typeByte | ora #8 | sta <typeByte
        endif
        lda <cell
        and #Cell_RightWall
        if ne
            lda <typeByte | ora #1 | sta <typeByte
        endif
        lda <cell
        and #Cell_TypeMask
        lsr a
        ora <typeByte | sta <typeByte
    else
        lda CellMap_-1,x
        sta <cell
        and #Cell_Visible
        if ne
            lda <cell
            and #Cell_RightWall
            if ne
                lda <typeByte | ora #8 | sta <typeByte
            endif
        endif
        lda CellMap_+1,x
        sta <cell
        and #Cell_Visible
        if ne
            lda <cell
            and #Cell_LeftWall
            if ne
                lda <typeByte | ora #1 | sta <typeByte
            endif
        endif
    endif
    stx <cellOffset
        lda <typeByte
        asl a | asl a
        tax
        lda #2 | sta <yCount
        do
            lda #2 | sta <xCount
            do
                lda CellChars2,x | inx
                sta (<pVVram),y | iny
                dec <xCount
            while ne | wend
            tya | clc|adc #VVramWidth-2 | tay
            dec <yCount
        while ne | wend
        tya | clc|adc #2-VVramWidth*2 | tay
    ldx <cellOffset
    inx
    inc <column
rts
Cell3:
    lda #0 | sta <typeByte
    lda CellMap_,x | sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_LeftWall
        if ne
            lda <typeByte | ora #4 | sta <typeByte
        endif
        lda <cell
        and #Cell_TypeMask
        lsr a | lsr a
        ora <typeByte | sta <typeByte
    else
        lda CellMap_-1,x
        sta <cell
        and #Cell_Visible
        if ne
            lda <cell
            and #Cell_RightWall
            if ne
                lda <typeByte | ora #4 | sta <typeByte
            endif
        endif
    endif
    stx <cellOffset
        lda <typeByte
        asl a | asl a
        tax
        lda #2 | sta <yCount
        do
            lda #2 | sta <xCount
            do
                lda CellChars3,x | inx
                sta (<pVVram),y | iny
                dec <xCount
            while ne | wend
            tya | clc|adc #VVramWidth-2 | tay
            dec <yCount
        while ne | wend
        tya | clc|adc #2-VVramWidth*2 | tay
    ldx <cellOffset
    inx
    inc <column
rts
CellEnd:
    lda #Char_Space | sta <typeByte
    lda CellMap_-1,x
    sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_RightWall
        if ne
            lda #Char_WS4 | sta <typeByte
        endif
    endif
    lda <typeByte
    sta (<pVVram),y
    tya | clc|adc #VVramWidth | tay
    lda <typeByte
    sta (<pVVram),y
    tya | clc|adc #-VVramWidth | tay
rts
Bottom0:
    lda #0 | sta <typeByte
    lda CellMap_-ColumnCount,x
    sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_BottomWall
        if ne
            lda #7
        else
            lda #5
        endif
        sta <typeByte
    endif
    lda <column
    if ne
        lda CellMap_-ColumnCount-1,x
        and #Cell_Visible
        if ne
            lda <typeByte | ora #4 | sta <typeByte
        endif
    endif
    lda CellMap_-ColumnCount+1,x
    and #Cell_Visible
    if ne
        lda <typeByte | ora #1 | sta <typeByte
    endif
    jsr DrawWall0
rts
Bottom1:
    lda #0 | sta <typeByte
    lda CellMap_-ColumnCount,x
    sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_BottomWall
        if ne
            lda #3
        else
            lda #1
        endif
        sta <typeByte
    endif
    lda <column
    cmp #ColumnCount-1
    if ne
        lda CellMap_-ColumnCount+1,x
        and #Cell_Visible
        if ne
            lda <typeByte | ora #1 | sta <typeByte
        endif
    endif
    jsr DrawWall1
rts
Bottom2:
    lda #0 | sta <typeByte
    lda CellMap_-ColumnCount,x
    sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_BottomWall
        if ne
            lda #7
        else
            lda #5
        endif
        sta <typeByte
    endif
    lda CellMap_-ColumnCount-1,x
    and #Cell_Visible
    if ne
        lda <typeByte | ora #4 | sta <typeByte
    endif
    lda CellMap_-ColumnCount+1,x
    and #Cell_Visible
    if ne
        lda <typeByte | ora #1 | sta <typeByte
    endif
    jsr DrawWall2
rts
Bottom3:
    lda #0 | sta <typeByte
    lda CellMap_-ColumnCount,x
    sta <cell
    and #Cell_Visible
    if ne
        lda <cell
        and #Cell_BottomWall
        if ne
            lda #3
        else
            lda #2
        endif
        sta <typeByte
    endif
    lda CellMap_-ColumnCount-1,x
    and #Cell_Visible
    if ne
        lda <typeByte | ora #2 | sta <typeByte
    endif
    jsr DrawWall3
rts
BottomEnd:
    lda #Char_Space | sta <typeByte
    lda CellMap_-ColumnCount-1,x
    and #Cell_Visible
    if ne
        lda #Char_WS4 | sta <typeByte
    endif
    lda <typeByte
    sta (pVVram),y
rts
