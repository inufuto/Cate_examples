include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext VVram_, SpriteLayer

MapWidth equ 5
TileSize equ 4
GroundHeight equ VVramHeight/TileSize+1

; void DrawGround();
scope
pVVram equ ZW0
pMap equ ZW1
pTile equ ZW2
yPos equ ZB0
groundOffset equ ZB1
columnCount equ ZB2
xCount equ ZB3
yCount equ ZB4
tileOffset equ ZB6
vvramOffset equ ZB7
cseg
DrawGround_: public DrawGround_
    pha
        lda #low VVram_ | sta pVVram
        lda #high VVram_ | sta pVVram+1
        stz yPos
        lda yMod_
        if ne
            tax
            do
                dec yPos
                lda pVVram | sec|sbc #low(VVramWidth) | sta pVVram
                lda pVVram+1 | sbc #high(VVramWidth) | sta pVVram+1
            dex | while ne | wend
        endif
        stz groundOffset
        do
            stz vvramOffset
            lda #MapWidth | sta columnCount
            do
                ldx groundOffset | lda Ground_,x | inx | stx groundOffset
                asl a | adc DotOffset_
                stz pTile+1
                asl a | rol pTile+1 ;*2
                asl a | rol pTile+1 ;*4
                asl a | rol pTile+1 ;*8
                asl a | rol pTile+1 ;*16
                clc|adc #low(Tiles_) | sta pTile
                lda pTile+1 | adc #high(Tiles_) | sta pTile+1

                stz tileOffset
                lda #TileSize | sta yCount
                do
                    lda yPos
                    cmp #VVramHeight
                    if cc
                        lda #TileSize | sta xCount
                        do
                            ldy tileOffset
                            lda (pTile),y | iny
                            sty tileOffset

                            ldy vvramOffset
                            sta (pVVram),y | iny
                            sty vvramOffset
                        dec xCount | while ne | wend
                        lda vvramOffset | clc|adc #VVramWidth-TileSize | sta vvramOffset
                    else
                        lda tileOffset | clc|adc #TileSize | sta tileOffset
                        lda vvramOffset | clc|adc #VVramWidth | sta vvramOffset
                    endif
                    inc yPos
                dec yCount | while ne | wend
                lda vvramOffset | clc|adc #TileSize-VVramWidth*TileSize | sta vvramOffset
                lda yPos | sec|sbc #TileSize | sta yPos
            dec columnCount | while ne | wend
            lda pVVram | clc|adc #VVramWidth*TileSize | sta pVVram
            if cs | inc pVVram+1 | endif
            lda yPos | clc|adc #TileSize | sta yPos
            cmp #VVramHeight
        while cc | wend
    pla
rts
endscope


; void RollDown();
scope
pMap equ ZW0
cseg
RollDown_: public RollDown_
    pha
        ldx #MapWidth*(GroundHeight-1)
        do
            dex
            lda Ground_,x
            sta Ground_+MapWidth,x
            cpx #0
        while ne | wend

        lda pCurrentRow_ | sta pMap
        lda pCurrentRow_+1 | sta pMap+1
        ldy #0
        do
            lda (pMap),y
            sta Ground_,y
            iny
            cpy #MapWidth
        while ne | wend
    pla
rts
endscope


ext Status_

; void StatusToVVram();
scope
StatusToVVram_: public StatusToVVram_
    pha
        ldx #0
        do
            lda Status_,x
            if ne
                sta SpriteLayer,x
            endif
            inx
            cpx #VVramWidth*2
        while ne | wend
    pla
rts
endscope