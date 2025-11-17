include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext VVram_

MapWidth equ 8
TileSize equ 4
GroundHeight equ (VVramHeight+TileSize-1)/TileSize+1

dseg
GroundLayer: public GroundLayer
    defs VVramWidth*GroundHeight*TileSize


; void FillGround();
scope
zseg
pDistionation equ ZW0
pTile equ ZW1
rowCount equ ZB1
groundOffset equ ZB2
xCount equ ZB3
yCount equ ZB4
tileOffset equ ZB5
vvramOffset equ ZB6
cseg
FillGround_: public FillGround_
    pha
        stz groundOffset

        lda #low(GroundLayer) | sta pDistionation
        lda #high(GroundLayer) | sta pDistionation+1
        
        lda #GroundHeight | sta rowCount
        do
            stz vvramOffset
            lda #MapWidth | sta xCount
            do
                ldx groundOffset | lda Ground_,x
                inx | stx groundOffset
                stz pTile+1
                asl a | rol pTile+1 ;*2
                asl a | rol pTile+1 ;*4
                clc|adc DotOffset_ | sta pTile
                lda pTile+1 | adc #0 | sta pTile+1
                lda pTile
                asl a | rol pTile+1 ;*2
                asl a | rol pTile+1 ;*4
                asl a | rol pTile+1 ;*8
                asl a | rol pTile+1 ;*16
                clc|adc #low(Tiles_) | sta pTile
                lda pTile+1 | adc #high(Tiles_) | sta pTile+1

                stz tileOffset
                lda #TileSize | sta yCount
                do
                    ldx #TileSize
                    do
                        ldy tileOffset | lda (pTile),y | iny | sty tileOffset
                        ldy vvramOffset | sta (pDistionation),y | iny | sty vvramOffset
                        dex
                    while ne | wend
                    lda vvramOffset | clc|adc #VVramWidth-TileSize | sta vvramOffset
                    dec yCount
                while ne | wend
                lda vvramOffset | clc|adc #TileSize-VVramWidth*TileSize | sta vvramOffset
                dec xCount
            while ne | wend
            lda pDistionation | clc|adc #low(VVramWidth*TileSize) | sta pDistionation
            if cs
                inc pDistionation+1
            endif
            
            dec rowCount
        while ne | wend
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


; void GroundToVVram();
scope
pSource equ ZW0
pVVram equ ZW1
cseg
GroundToVVram_: public GroundToVVram_
    pha
        lda #low(GroundLayer) | sta pSource
        lda #high(GroundLayer) | sta pSource+1
        lda yMod_ | and #3
        if ne
            tax
            do
                lda pSource | clc|adc #low(VVramWidth) | sta pSource
                lda pSource+1 | adc #high(VVramWidth) | sta pSource+1
                dex
            while ne | wend
        endif
        
        lda #low(VVram_) | sta pVVram
        lda #high(VVram_) | sta pVVram+1

        ldx #VVramHeight
        do
            ldy #0
            do
                lda (pSource),y
                sta (pVVram),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda pSource | clc | adc #low VVramWidth | sta pSource
            if cs
                inc pSource+1
            endif
            lda pVVram | clc | adc #low VVramWidth | sta pVVram
            if cs
                inc pVVram+1
            endif
            dex
        while ne | wend
    pla
rts
endscope      
