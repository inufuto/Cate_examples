include "VVram.inc"
include "Chars.inc"

ext VVramBack_
ext Ground_, TopRow_, yMod_
ext pCurrentRow_
ext Tiles_

MapWidth equ 8
TileSize equ 4
GroundHeight equ VVramHeight/TileSize+1

; void DrawGround();
scope
zseg
yPos:
    defb 0
xCount:
    defb 0
yCount:
    defb 0
xCount2:
    defb 0
cseg
DrawGround_: public DrawGround_
    pshs a,b,x,y
        ldy #VVramBack_

        clr yPos
        lda yMod_
        anda #3
        if ne
            do
                leay -VVramWidth,y
                dec yPos
                deca
            while ne | wend
        endif

        ldx #Ground_
        do
            lda #MapWidth | sta xCount
            do
                lda ,x+
                pshs x
                    ldb #16 | mul
                    addd #Tiles_
                    tfr d,x
                    lda #TileSize | sta yCount
                    do
                        lda yPos
                        cmpa #VVramHeight
                        if cs
                            lda #TileSize | sta xCount2
                            do
                                lda ,x+
                                sta ,y+
                                dec xCount2
                            while ne | wend
                            leay VVramWidth-TileSize,y
                        else
                            leax TileSize,x
                            leay VVramWidth,y
                        endif
                        inc yPos
                        dec yCount
                    while ne | wend
                    leay TileSize-VVramWidth*TileSize,y
                    lda yPos | suba #TileSize | sta yPos
                puls x
                dec xCount
            while ne | wend
            leay VVramWidth*TileSize-TileSize*MapWidth,y
            lda yPos
            adda #TileSize
            sta yPos
            cmpa #VVramHeight
        while cs | wend
    puls a,b,x,y
rts
endscope


; void RollDown();
cseg
RollDown_: public RollDown_
    pshs a,b,x,y
        ldx #Ground_+MapWidth*GroundHeight-1-MapWidth
        ldb #MapWidth*(GroundHeight-1)
        do
            lda ,x
            sta MapWidth,x
            leax -1,x
            decb
        while ne | wend

        ldx pCurrentRow_
        ldy #Ground_
        ldb #MapWidth
        do
            lda ,x+
            sta ,y+
            decb
        while ne | wend
    puls a,b,x,y
rts
