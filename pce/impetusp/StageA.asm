include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext NextPage, TerrainCharOffset
ext RepeatWrite

MapWidth equ 8
TileSize equ 4
GroundHeight equ (VramHeight+TileSize-1)/TileSize+1


scope
; void UpdateGroundChars(bool next);
pSource equ ZW0
wDestination equ ZW1
cseg
UpdateGroundChars_: public UpdateGroundChars_
    pha
        lda TerrainCharOffset
        cpy #0
        if eq
            eor #TerrainCharCount
        endif
        cmp #0
        if eq
            ldy #low(CharPatternRam+CharPatternSize/2*Char_Terrain0)
            ldx #high(CharPatternRam+CharPatternSize/2*Char_Terrain0)
        else
            ldy #low(CharPatternRam+CharPatternSize/2*Char_Terrain1)
            ldx #high(CharPatternRam+CharPatternSize/2*Char_Terrain1)
        endif
        sty wDestination | stx wDestination+1

        lda #CharHeight | sec|sbc DotOffset_ | asl a | sta pSource
        lda #low(TerrainPattern) | clc|adc pSource | sta pSource
        lda #high(TerrainPattern) | adc #0 | sta pSource+1

        ldx #(Char_Terrain1-Char_Terrain0)*PlaneCount/2
        do
            sei
                defb $03,$00 ; st0 Memory Address Write
                sty >$0002
                lda wDestination | sta >$0002
                lda wDestination+1 | sta >$0003
                
                ldy #0
                do
                    defb $03,$02 ; st0 Vram Data
                    lda (pSource),y | iny | sta >$0002
                    lda (pSource),y | iny | sta >$0003
                    cpy #CharHeight*2
                while ne | wend
            cli
            lda pSource | clc|adc #CharHeight*2*2 | sta pSource
            if cs
                inc pSource+1
            endif
            lda wDestination | clc|adc #CharHeight | sta wDestination
            if cs
                inc wDestination+1
            endif

            dex
        while ne | wend
    pla
rts
endscope


scope
; void DrawGround();
wVram equ ZW0
pTile equ ZW1
yPos equ ZB0
charOffset equ ZB1
groundOffset equ ZB2
columnCount equ ZB3
tileOffset equ ZB4
yCount equ ZB5
cseg
DrawGround_: public DrawGround_
    pha
        stz yPos
        lda TerrainCharOffset | sta charOffset

        stz wVram
        lda NextPage | sta wVram+1
        lda yMod_
        if ne
            tax
            do
                lda wVram | sec|sbc #low(VramRowSize) | sta wVram
                lda wVram+1 | sbc #high(VramRowSize) | sta wVram+1
                dec yPos
                dex
            while ne | wend
        endif

        stz groundOffset
        do
            lda #MapWidth | sta columnCount
            do
                ldx groundOffset | lda Ground_,x | inx | stx groundOffset
                stz pTile+1
                asl a | rol pTile+1 ;*2
                asl a | rol pTile+1 ;*4
                asl a | rol pTile+1 ;*8
                asl a | rol pTile+1 ;*16
                clc|adc #low(Tiles_) | sta pTile
                lda pTile+1 | adc #high(Tiles_) | sta pTile+1

                ldy #0
                lda #TileSize | sta yCount
                do
                    lda yPos
                    cmp #VramHeight
                    if cc
                        sei
                            defb $03,$00 ; st0 Memory Address Write
                            lda wVram | sta >$0002
                            lda wVram+1 | sta >$0003
                            ldx #TileSize
                            do
                                lda (pTile),y | iny
                                clc|adc charOffset
                                defb $03,$02 ; st0 Vram Data
                                sta >$0002
                                defb $23,$01 ; st2
                                dex
                            while ne | wend
                        cli
                    else
                        iny | iny | iny | iny
                    endif
                    lda wVram | clc|adc #VramRowSize | sta wVram
                    if cs
                        inc wVram+1
                    endif
                    inc yPos
                    dec yCount
                while ne | wend
                lda wVram | clc|adc #low(TileSize*VramStep-VramRowSize*TileSize) | sta wVram
                lda wVram+1 | adc #high(TileSize*VramStep-VramRowSize*TileSize) | sta wVram+1
                lda yPos | sec|sbc #TileSize | sta yPos
                dec columnCount
            while ne | wend
            lda wVram | clc|adc #low(VramRowSize*TileSize-TileSize*MapWidth*VramStep) | sta wVram
            lda wVram+1 | adc #high(VramRowSize*TileSize-TileSize*MapWidth*VramStep) | sta wVram+1
            lda yPos | clc|adc #TileSize | sta yPos
            cmp #VramHeight
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
