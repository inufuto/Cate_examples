include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_
ext pCurrentRow_
ext Tiles_
ext VVram_

MapWidth equ 8
TileSize equ 4
GroundHeight equ (VVramHeight+TileSize-1)/TileSize+1

; void DrawGround();
scope
zseg
pDistionation equ ZW0
pTile equ ZW1
yPos equ ZB1
groundOffset equ ZB2
xCount equ ZB3
yCount equ ZB4
tileOffset equ ZB5
vvramOffset equ ZB6
cseg
DrawGround_: public DrawGround_
    pha
        stz groundOffset

        stz yPos
        lda #low(VVram_) | sta pDistionation
        lda #high(VVram_) | sta pDistionation+1
        lda yMod_
        if ne
            tax
            do
                lda pDistionation | sec|sbc #low(VVramWidth) | sta pDistionation
                lda pDistionation+1 | sbc #high(VVramWidth) | sta pDistionation+1
                dec yPos
                dex
            while ne | wend
        endif
        
        do
            stz vvramOffset
            lda #MapWidth | sta xCount
            do
                ldx groundOffset | lda Ground_,x
                inx | stx groundOffset
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
                        ldx #TileSize
                        do
                            ldy tileOffset | lda (pTile),y | iny | sty tileOffset
                            ldy vvramOffset | sta (pDistionation),y | iny | sty vvramOffset
                            dex
                        while ne | wend
                        lda vvramOffset | clc|adc #VVramWidth-TileSize | sta vvramOffset
                    else
                        lda tileOffset | clc|adc #TileSize | sta tileOffset
                        lda vvramOffset | clc|adc #VVramWidth | sta vvramOffset
                    endif
                    inc yPos
                    dec yCount
                while ne | wend
                lda vvramOffset | clc|adc #TileSize-VVramWidth*TileSize | sta vvramOffset
                lda yPos | sec|sbc #TileSize | sta yPos
                dec xCount
            while ne | wend
            lda pDistionation | clc|adc #low(VVramWidth*TileSize) | sta pDistionation
            if cs
                inc pDistionation+1
            endif
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
