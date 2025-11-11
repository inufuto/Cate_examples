include "S1.inc"
include "Vram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext DispPage

MapWidth equ 8
TileSize equ 4
GroundHeight equ VramHeight/TileSize+1


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
        lda DispPage
        anda #$01
        if ne
            ldy #TVram0
        else
            ldy #TVram1
        endif

        clr yPos
        lda yMod_
        anda #3
        if ne
            do
                leay -VramWidth,y
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
                    lsla
                    adda DotOffset_
                    ldb #16 | mul
                    addd #Tiles_
                    tfr d,x
                    lda #TileSize | sta yCount
                    do
                        lda yPos
                        cmpa #VramHeight
                        if cs
                            lda #TileSize | sta xCount2
                            do
                                lda ,x+
                                sta ,y+
                                dec xCount2
                            while ne | wend
                            leay VramWidth-TileSize,y
                        else
                            leax TileSize,x
                            leay VramWidth,y
                        endif
                        inc yPos
                        dec yCount
                    while ne | wend
                    leay TileSize-VramWidth*TileSize,y
                    lda yPos | suba #TileSize | sta yPos
                puls x
                dec xCount
            while ne | wend
            leay VramWidth*TileSize-TileSize*MapWidth,y
            lda yPos
            adda #TileSize
            sta yPos
            cmpa #VramHeight
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
