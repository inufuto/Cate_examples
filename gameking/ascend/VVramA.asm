include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"

ext VVram_
ext dotOffset_
ext pStage_, StageMap_, topRow_, yMod_
ext DrawBlocks_

VisibleFloorCount equ (VVramHeight+FloorHeight-1)/FloorHeight+1
FloorHeight equ 4
ColumnCount equ 12
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte
ColumnWidth equ 2

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3

pSource equ ZW0
pVVram equ ZW1
charOffset2 equ ZW2 ; byte
charOffset4 equ ZW2+1 ; byte
pChars equ ZW3

mapHeight equ ZB0
currentRow equ ZB1
yPos equ ZB2
fCount equ ZB3
cCount equ ZB4
vOffset equ ZB5

zseg
upperByte:
    defb 0
middleByte:
    defb 0
lowerByte:
    defb 0
pUpper:
    defw 0
pMiddle:
    defw 0
pLower:
    defw 0
chOffset:
    defw 0
leftChar:
    defb 0
rightChar:
    defb 0
bCount:
    defb 0
rCount:
    defb 0


; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defs 1
cseg
VVramPtr_: public VVramPtr_
	pha
        sty <pVVram
        stz <pVVram+1
        lda	VVramPtr_y
        asl a ;*2
        clc|adc VVramPtr_y ;*3
        asl a | rol <pVVram+1 ;6
        asl a | rol <pVVram+1 ;12
        asl a | rol <pVVram+1 ;24
        clc | adc <pVVram | tay
        lda <pVVram+1 | adc #0 | tax
        tya | clc|adc #low VVram_ | tay
        txa | adc #high VVram_ | tax
	pla
rts


; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    pha
        lda dotOffset_
        asl a | sta <charOffset2
        asl a | sta <charOffset4

        lda pStage_ | sta <pSource
        lda pStage_+1 | sta <pSource+1
        ldy #0 | lda (<pSource),y | sec|sbc #1 | sta <mapHeight

                                                            _deb: public _deb
        lda topRow_ | sta <currentRow
        if pl
            asl a | clc|adc <currentRow
            clc|adc #low(StageMap_-MapWidth) | sta <pSource
            lda #high(StageMap_-MapWidth) | adc #0 | sta <pSource+1
        else
            lda #low(StageMap_-MapWidth*2) | sta <pSource
            lda #high(StageMap_-MapWidth*2) | sta <pSource+1
        endif

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        lda #0 | sec|sbc yMod_ | sta <yPos
        tax
        do
        while mi
            lda <pVVram | sec|sbc #VVramWidth | sta <pVVram
            lda <pVVram+1 | sbc #0 | sta <pVVram+1
            inx
        wend

        lda #VisibleFloorCount | sta <fCount
        do
            lda #0 | sta <vOffset
            lda #MapWidth | sta <cCount
            do
                lda <currentRow
                if pl
                    if eq
                        lda #0
                    else
                        ldy #0 | lda (<pSource),y
                    endif
                    sta <upperByte
                    ldy #MapWidth | lda (<pSource),y | sta <middleByte

                    lda <currentRow
                    cmp <mapHeight
                    if cc
                        ldy #MapWidth*2 | lda (<pSource),y
                    else
                        lda #0
                    endif
                    sta <lowerByte
                else
                    lda #$ff | sta <upperByte
                    lda #0 | sta <middleByte
                    ldy #MapWidth*2 | lda (<pSource),y | sta <lowerByte
                endif
                lda <pSource | clc|adc #1 | sta <pSource
                lda <pSource+1 | adc #0 | sta <pSource+1

                lda #ColumnsPerByte | sta <bCount
                do
                    lda <middleByte | and #3
                    if eq
                        lda <upperByte | and #3
                        cmp #CellType_Hole
                        if eq
                            lda #low Space2 | sta <pUpper
                            lda #high Space2 | sta <pUpper+1
                        else
                            lda #low SpaceUnderFloor | sta <pUpper
                            lda #high SpaceUnderFloor | sta <pUpper+1
                        endif
                        lda <lowerByte | and #3
                        cmp #CellType_Ladder
                        if eq
                            lda #low SpaceLadder | sta <pMiddle
                            lda #high SpaceLadder | sta <pMiddle+1
                            lda #low Ladder2 | sta <pLower
                            lda #high Ladder2 | sta <pLower+1
                            jmp next
                        endif
                        cmp #CellType_Wall
                        if eq
                            lda #low Space4 | sta <pMiddle
                            lda #high Space4 | sta <pMiddle+1
                            lda #low SpaceWall | sta <pLower
                            lda #high SpaceWall | sta <pLower+1
                            jmp next
                        endif
                        lda #low Space4 | sta <pMiddle
                        lda #high Space4 | sta <pMiddle+1
                        lda #low Floor | sta <pLower
                        lda #high Floor | sta <pLower+1
                        jmp next
                    endif
                    cmp #CellType_Ladder ; middleByte
                    if eq
                        lda #low Ladder2 | sta <pUpper
                        lda #high Ladder2 | sta <pUpper+1
                        lda #low Ladder4 | sta <pMiddle
                        lda #high Ladder4 | sta <pMiddle+1

                        lda <lowerByte | and #3
                        cmp #CellType_Ladder
                        if eq
                            lda #low Ladder2 | sta <pLower
                            lda #high Ladder2 | sta <pLower+1
                            jmp next
                        endif
                        cmp #CellType_Wall ; lowerByte
                        if eq
                            lda #low LadderWall | sta <pLower
                            lda #high LadderWall | sta <pLower+1
                            jmp next
                        endif
                        lda #low LadderFloor | sta <pLower
                        lda #high LadderFloor | sta <pLower+1
                        jmp next
                    endif
                    cmp #CellType_Wall ; middleByte
                    if eq
                        lda #low WallUnderFloor | sta <pUpper
                        lda #high WallUnderFloor | sta <pUpper+1
                        lda #low Wall | sta <pMiddle
                        lda #high Wall | sta <pMiddle+1

                        lda <lowerByte | and #3
                        cmp #CellType_Wall
                        if eq
                            lda #low WallFloorUnderWall | sta <pLower
                            lda #high WallFloorUnderWall | sta <pLower+1
                            jmp next
                        endif
                        lda #low FloorUnderWall | sta <pLower
                        lda #high FloorUnderWall | sta <pLower+1
                        jmp next
                    endif
                    lda <upperByte | and #3
                    cmp #CellType_Hole
                    if eq
                        lda #low Space2 | sta <pUpper
                        lda #high Space2 | sta <pUpper+1
                    else
                        lda #low SpaceUnderFloor | sta <pUpper
                        lda #high SpaceUnderFloor | sta <pUpper+1
                    endif
                    lda #low Space4 | sta <pMiddle
                    lda #high Space4 | sta <pMiddle+1
                    lda #low Space2 | sta <pLower
                    lda #high Space2 | sta <pLower+1
                    next:
                    ldy <pUpper | ldx <pUpper+1 | jsr FillTile2
                    ldy <pMiddle | ldx <pMiddle+1 | jsr FillTile4
                    ldy <pLower | ldx <pLower+1 | jsr FillTile2

                    lda <vOffset | clc|adc #(-VVramWidth*FloorHeight+ColumnWidth) | sta <vOffset
                    lda <yPos | sec|sbc #FloorHeight | sta <yPos

                    lsr <upperByte | lsr <upperByte
                    lsr <middleByte | lsr <middleByte
                    lsr <lowerByte | lsr <lowerByte

                    dec <bCount
                while ne | wend
                dec <cCount
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth*FloorHeight | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1

            inc <currentRow
            lda <yPos | clc|adc #4 | sta <yPos
            dec <fCount
        while ne | wend                
        jsr DrawBlocks_
    pla
rts

FillTile2:
    tya | clc|adc <charOffset2 | sta <pChars
    txa | adc #0 | sta <pChars+1
    lda #1
jmp Repeat

FillTile4:
    tya | clc|adc <charOffset4 | sta <pChars
    txa | adc #0 | sta <pChars+1
    lda #2
jmp Repeat

Repeat:
    sta <rCount
    lda #0 | sta <chOffset
    do
        lda <yPos
        cmp #VVramHeight
        if cc
            ldy <chOffset | lda (<pChars),y | sta <leftChar
            iny | lda (<pChars),y | sta <rightChar
            ldy <vOffset | lda <leftChar | sta (<pVVram),y
            iny  | lda <rightChar | sta (<pVVram),y
        endif
        inc <chOffset | inc <chOffset
        inc <yPos
        lda <vOffset | clc|adc #VVramWidth | sta <vOffset
        dec <rCount
    while ne | wend
rts

Space4:
	; 0
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 1
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
Space2:
	; 0
	defb Char_Space, Char_Space
	; 1
	defb Char_Space, Char_Space
Floor:
	; 0
	defb Char_Space_Floor0, Char_Space_Floor0
	; 1
	defb Char_Space_Floor1, Char_Space_Floor1
SpaceUnderFloor:
	; 0
	defb Char_Space, Char_Space
	; 1
	defb Char_Space, Char_Space
WallUnderFloor:
	; 0
	defb Char_Wall_Wall0, Char_Space
	; 1
	defb Char_Wall_Wall0, Char_Space
SpaceLadder:
	; 0
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 1
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder1, Char_Space_RightLadder1
Ladder4:
	; 0
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 1
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
Ladder2:
	; 0
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 1
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
LadderFloor:
	; 0
	defb Char_Space_Floor0, Char_Space_Floor0
	; 1
	defb Char_LeftLadder_Floor1, Char_RightLadder_Floor1
LadderWall:
	; 0
	defb Char_Wall_Wall0, Char_Space_Floor0
	; 1
	defb Char_LeftLadder_Floor1, Char_RightLadder_Floor1
Wall:
	; 0
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 1
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
SpaceWall:
	; 0
	defb Char_Wall_Wall0, Char_Space_Floor0
	; 1
	defb Char_Space_Floor1, Char_Space_Floor1
WallFloorUnderWall:
	; 0
	defb Char_Wall_Wall0, Char_Space_Floor0
	; 1
	defb Char_Wall_Wall0, Char_Space_Floor1
FloorUnderWall:
	; 0
	defb Char_Space_Floor0, Char_Space_Floor0
	; 1
	defb Char_Wall_Wall0, Char_Space_Floor1

; Char_Space_LeftUpperBlock0 equ $56
; Char_Space_LeftUpperBlock1 equ $05
; Char_Space_RightUpperBlock0 equ $59
; Char_LeftUpperBlock_LeftLowerBlock0 equ $65
; Char_LeftUpperBlock_LeftLowerBlock1 equ $66
; Char_RightUpperBlock_RightLowerBlock0 equ $95
; Char_RightUpperBlock_RightLowerBlock1 equ $99
; Char_LeftLowerBlock_Space1 equ $50
Char_Space_Floor0 equ $a0
Char_Space_Floor1 equ $0a
Char_Wall_Wall0 equ $aa
Char_Space_LeftLadder0 equ $64
Char_Space_RightLadder0 equ $91
Char_Space_LeftLadder1 equ $06
Char_Space_RightLadder1 equ $09
Char_LeftLadder_LeftLadder1 equ $46
Char_RightLadder_RightLadder1 equ $19
Char_LeftLadder_Floor1 equ $4a
Char_RightLadder_Floor1 equ $1a
