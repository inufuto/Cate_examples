include "Zeropage.inc"
include "Vram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext VVram, VVramToVram_

MapWidth equ 6
TileSize equ 4
GroundHeight equ (WindowHeight+TileSize-1)/TileSize+1

zseg 
pVramBack: public pVramBack
    defw 0

scope
; void DrawGround();
pVVram equ ZW0
pTile equ ZW1
rowCount equ ZB0
groundOffset equ ZB1
columnCount equ ZB2
tileOffset equ ZB3
xCount equ ZB4
yCount equ ZB5
vvramOffset equ ZB6
cseg
DrawGround_: public DrawGround_
    pha
        lda #low(VVram) | sta pVVram
        lda #high(VVram) | sta pVVram+1
        stz groundOffset
        lda #GroundHeight | sta rowCount
        do
            stz vvramOffset
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
                
                stz tileOffset
                lda #TileSize | sta yCount
                do
                    lda #TileSize | sta xCount
                    do
                        ldy tileOffset
                        lda (<pTile),y | iny
                        sty tileOffset
                        ldy vvramOffset
                        sta (<pVVram),y | iny
                        sty vvramOffset
                        dec xCount
                    while ne | wend
                    lda vvramOffset | clc|adc #WindowWidth-TileSize | sta vvramOffset
                    dec yCount
                while ne | wend
                lda vvramOffset | clc|adc #TileSize-WindowWidth*TileSize | sta vvramOffset
                dec columnCount
            while ne | wend
            lda pVVram | clc|adc #low(WindowWidth*TileSize) | sta pVVram
            lda pVVram+1 | adc #high(WindowWidth*TileSize) | sta pVVram+1
            dec rowCount
        while ne | wend
    pla
    jsr VVramToVram_
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


scope
; void UpdateOffset();
cseg
wPos equ ZW0
UpdateOffset_: public UpdateOffset_
    pha
        stz pVramBack
        lda #high(VramBackOrg) | sta pVramBack+1

        lda yMod_
        inc a
        asl a | asl a | asl a
        sec|sbc dotOffset_

        sta wPos | stz wPos+1
        asl a | rol wPos+1 ;*2
        clc|adc wPos | sta wPos
        lda wPos+1 | adc #0 ;*3
        lsr a | ror wPos ;*3/2
        lsr a | ror wPos ;*3/4
        sta wPos+1

        ldx wPos
                        cpx #24
                        if cs
                            _deb: public _deb
                            nop
                        endif
        cpx #0
        if ne
            do
                lda pVramBack | clc|adc #VramWidth | sta pVramBack
                lda pVramBack+1 | adc #0 | sta pVramBack+1
                dex
            while ne | wend
        endif
    pla
rts
endscope
