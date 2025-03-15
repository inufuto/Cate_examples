include "ZeroPage.inc"
include "VVram.inc"

ext Ground_, GroundY_
ext Tiles_

TileSize equ 4
GroundWidth equ VVramWidth/TileSize
GroundHeight equ (VVramHeight+TileSize*2-1)/TileSize


pTile equ ZW0
pVVram equ ZW1
sourceX equ ZB0
yPos equ ZB1
xCount2 equ ZB2
yPos2 equ ZB3


dseg
VVram_: public VVram_
        defs VVramWidth*VVramHeight


; void DrawGround();
cseg
DrawGround_: public DrawGround_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        ldx GroundY_
        do
            txa | and #$80
        while ne
            lda <pVVram | sec|sbc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | sbc #high VVramWidth | sta <pVVram+1
            inx
        wend

        ldx #0 | stx <sourceX
        lda GroundY_ | sta <yPos
        do
            lda #GroundWidth | sta <xCount2
            do
                stz <pTile+1
                ldx <sourceX | lda Ground_,x | inx | stx <sourceX
                asl a | rol <pTile+1 ;*2
                asl a | rol <pTile+1 ;*4
				asl a | rol <pTile+1 ;*8
				asl a | rol <pTile+1 ;*16
                clc|adc #low Tiles_ | sta <pTile
                lda <pTile+1 | adc #high Tiles_ | sta <pTile+1

                lda <yPos | sta <yPos2
                ldx #TileSize
                do
                    lda <yPos2 | cmp #VVramHeight
                    if cc
                        ldy #0
                        do
                            lda (<pTile),y | sta (<pVVram),y
                            iny
                            cpy #TileSize
                        while ne | wend
                    endif
                    lda <pVVram | clc|adc #VVramWidth | sta <pVVram
					lda <pVVram+1 | adc #0 | sta <pVVram+1

                    lda <pTile | clc|adc #TileSize | sta <pTile
					lda <pTile+1 | adc #0 | sta <pTile+1

                    lda <pTile+1 | adc #0 | sta <pTile+1
                    inc <yPos2
                    dex
                while ne | wend
                lda <pVVram | clc|adc #low(TileSize-VVramWidth*TileSize) | sta <pVVram
                lda <pVVram+1 | adc #high(TileSize-VVramWidth*TileSize) | sta <pVVram+1
                dec <xCount2
            while ne | wend
            lda <pVVram | clc|adc #low(VVramWidth*TileSize-VVramWidth) | sta <pVVram
            lda <pVVram+1 | adc #high(VVramWidth*TileSize-VVramWidth) | sta <pVVram+1
            lda <yPos | clc|adc #TileSize | sta <yPos
            cmp #VVramHeight
        while cc | wend
	pla
rts