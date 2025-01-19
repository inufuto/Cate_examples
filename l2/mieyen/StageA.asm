include "VVram.inc"

ext CellMap_
ext VVram_

ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte3
ext @Temp@Byte4
ext @Temp@Word
ext @Temp@Word2
ext @Temp@Word3

; ptr<byte> CellMapPtr(byte column, byte row);
CellMapPtr_@Param1: public CellMapPtr_@Param1
CellMapPtr_row:
    defb 0
cseg
CellMapPtr_: public CellMapPtr_
    psha | pshb
        lsra | staa <@Temp@Word+1
        ldab CellMapPtr_row
        aslb ;*2
        aslb ;*4
        addb CellMapPtr_row ;*5
        addb <@Temp@Word+1
        clra
        addb #low CellMap_ | adca #high CellMap_
        staa <@Temp@Word | stab <@Temp@Word+1
        ldx <@Temp@Word
    pulb | pula
rts


Cell_RightWall equ $01
Cell_BottomWall equ $02
Cell_Dot equ $04
Cell_Food equ $08
ColumnCount equ 10
RowCount equ 7
ColumnWidth equ 3
RowHeight equ 3

Char_Wall equ $9d

pVVram equ @Temp@Word
pCell equ @Temp@Word2
pChars equ @Temp@Word3
rCount equ @Temp@Byte
cCount equ @Temp@Byte2
cellByte equ @Temp@Byte3
bCount equ @Temp@Byte4

; void DrawBackground();
cseg
DotChars:
    defb $0c, 0, 0, 0
FoodChars:
    defb $07, $05, $0f, $0f
DrawBackground_: public DrawBackground_
    psha | pshb
        ldx #VVram_
        ldaa #Char_Wall
        do
            staa 0,x | inx
            cpx #VVram_+ColumnWidth*ColumnCount+1
        while ne | wend
        clr 0,x | inx | stx <pVVram

        ldx #CellMap_ | stx <pCell
        ldaa #RowCount | staa <rCount
        do
            ldx <pVVram
            ldaa #Char_Wall
            staa 0,x
            staa VVramWidth,x
            staa VVramWidth*2,x
            inx | stx <pVVram

            ldaa #ColumnCount/2 | staa <cCount
            do
                ldx <pCell
                ldaa 0,x | staa <cellByte
                inx | stx <pCell

                ldaa #2 | staa <bCount
                do
                    ldaa <cellByte
                    anda #$0c
                    cmpa #Cell_Food
                    if eq
                        ldx #FoodChars
                        bra put2s
                    endif
                    cmpa #Cell_Dot
                    if eq
                        ldx #DotChars
                        put2s:
                        stx <pChars | ldaa 0,x
                        ldx <pVVram | staa 0,x
                        ldx <pChars | ldaa 1,x
                        ldx <pVVram | staa 1,x
                        ldx <pChars | ldaa 2,x
                        ldx <pVVram | staa VVramWidth,x
                        ldx <pChars | ldaa 3,x
                        ldx <pVVram | staa VVramWidth+1,x
                        bra nextCell
                    endif
                    ldx <pVVram
                    clr 0,x
                    clr 1,x
                    clr VVramWidth,x
                    clr VVramWidth+1,x
                    nextCell:
                    ldaa <cellByte
                    anda #Cell_RightWall
                    if ne
                        ldaa #Char_Wall
                    else
                        clra
                    endif
                    staa 2,x
                    staa VVramWidth+2,x

                    ldaa <cellByte
                    anda #Cell_BottomWall
                    if ne
                        ldaa #Char_Wall
                    else
                        clra
                    endif
                    staa VVramWidth*2,x
                    staa VVramWidth*2+1,x

                    ldaa #Char_Wall
                    staa VVramWidth*2+2,x

                    inx | inx | inx
                    stx <pVVram

                    ldaa <cellByte
                    lsra | lsra | lsra | lsra
                    staa <cellByte

                    dec <bCount
                while ne | wend
                
                dec <cCount
            while ne | wend

            ldaa <pVVram | ldab <pVVram+1
            addb #low(VVramWidth*3-(ColumnWidth*ColumnCount+1))
            adca #high(VVramWidth*3-(ColumnWidth*ColumnCount+1))
            staa <pVVram | stab <pVVram+1

            dec <rCount
        while ne | wend
    pulb | pula
rts
