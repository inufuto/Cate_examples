include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext pNextPage_
ext dotOffset_
ext pStage_, StageMap_, topRow_, yMod_
ext DrawBlocks_

FloorHeight equ 4
ColumnCount equ 16
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte
ColumnWidth equ 2
VisibleFloorCount equ (WindowHeight+FloorHeight-1)/FloorHeight+1

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3

scope
charOffset2 equ @Temp@Byte
charOffset4 equ @Temp@Byte2
mapHeight equ @Temp@Byte3
currentRow equ @Temp@Byte4
yPos equ @Temp@Byte5
pUpper equ @Temp@Word
pMiddle equ @Temp@Word2
pLower equ @Temp@Word3
pSource equ @Temp@Word4
pVram equ @Temp@Word5
zseg
upperByte:
    defb 0
middleByte:
    defb 0
lowerByte:
    defb 0
pChars:
    defw 0

; void MapToVram();
cseg
MapToVram_: public MapToVram_
    psha | pshb
        ldaa dotOffset_
        asla | staa charOffset2
        asla | staa charOffset4

        ldx pStage_
        ldaa 0,x | staa mapHeight

        ldaa topRow_ | staa currentRow
        if pl
            asla | asla ;*4
            adda #low(StageMap_-MapWidth) | staa pSource+1
            ldaa #high(StageMap_-MapWidth) | adca #0 | staa pSource
        else
            ldx #StageMap_-MapWidth*2 | stx pSource
        endif

        ldx pNextPage_ | stx pVram
        ldaa pVram+1 | adda #VramRowSize*StatusHeight | staa pVram+1
        ldaa yMod_
        nega
        staa yPos
        do | while mi
            ldab pVram+1 | subb #VramRowSize | stab pVram+1
            ldab pVram | sbcb #0 | stab pVram
            inca
        wend

        ldab #VisibleFloorCount
        do
            pshb
                ldab #MapWidth
                do
                    pshb
                        ldx pSource
                        ldaa currentRow
                        if pl
                            if eq
                                clra
                            else
                                ldaa 0,x
                            endif
                            staa upperByte
                            ldaa MapWidth,x | staa middleByte
                            ldaa currentRow
                            inca
                            cmpa mapHeight
                            if cs
                                ldaa MapWidth*2,x
                            else
                                        _deb: public _deb
                                clra
                            endif
                            staa lowerByte
                        else
                            ldaa #$ff | staa upperByte
                            clr middleByte
                            ldaa MapWidth*2,x | staa lowerByte
                        endif
                        inx | stx pSource

                        ldab #ColumnsPerByte
                        do
                            pshb
                                ldaa middleByte
                                anda #$03
                                if eq
                                    ldaa upperByte
                                    anda #$03
                                    cmpa #CellType_Hole
                                    if eq
                                        ldx #Space2
                                    else
                                        ldx #SpaceUnderFloor
                                    endif
                                    stx pUpper
                                    ldaa lowerByte
                                    anda #$03
                                    cmpa #CellType_Ladder
                                    if eq
                                        ldx #SpaceLadder | stx pMiddle
                                        ldx #Ladder2 | stx pLower
                                        bra next
                                    endif
                                    cmpa #CellType_Wall
                                    if eq
                                        ldx #Space4 | stx pMiddle
                                        ldx #SpaceWall | stx pLower
                                        bra next
                                    endif
                                    ldx #Space4 | stx pMiddle
                                    ldx #Floor | stx pLower
                                    bra next
                                endif
                                cmpa #CellType_Ladder
                                if eq
                                    ldx #Ladder2 | stx pUpper
                                    ldx #Ladder4 | stx pMiddle
                                    ldaa lowerByte
                                    anda #$03
                                    cmpa #CellType_Ladder
                                    if eq
                                        ldx #Ladder2 | stx pLower
                                        bra next
                                    endif
                                    cmpa #CellType_Wall
                                    if eq
                                        ldx #LadderWall | stx pLower
                                        bra next
                                    endif
                                    ldx #LadderFloor | stx pLower
                                    bra next
                                endif
                                cmpa #CellType_Wall
                                if eq
                                    ldx #WallUnderFloor | stx pUpper
                                    ldx #Wall | stx pMiddle
                                    ldaa lowerByte
                                    anda #$03
                                    cmpa #CellType_Wall
                                    if eq
                                        ldx #WallFloorUnderWall | stx pLower
                                        bra next
                                    endif
                                    ldx #FloorUnderWall | stx pLower
                                    bra next
                                endif
                                ldaa upperByte
                                anda #$03
                                cmpa #CellType_Hole
                                if eq
                                    ldx #Space2
                                else
                                    ldx #SpaceUnderFloor
                                endif
                                stx pUpper
                                ldx #Space4 | stx pMiddle
                                ldx #Space2 | stx pLower
                                next:
                                ldx pUpper | bsr FillTile2
                                ldx pMiddle | bsr FillTile4
                                ldx pLower | bsr FillTile2
                                
                                ldaa pVram+1 | adda #low(-VramRowSize*FloorHeight+ColumnWidth) | staa pVram+1
                                ldaa pVram | adca #high(-VramRowSize*FloorHeight+ColumnWidth) | staa pVram

                                ldaa upperByte | lsra | lsra | staa upperByte
                                ldaa middleByte | lsra | lsra | staa middleByte
                                ldaa lowerByte | lsra | lsra | staa lowerByte

                                ldaa yPos | suba #FloorHeight | staa yPos
                            pulb
                            decb
                        while ne | wend
                    pulb
                    decb
                while ne | wend
                ldaa pVram+1 | adda #low(VramRowSize*FloorHeight-ColumnWidth*ColumnCount) | staa pVram+1
                ldaa pVram | adca #high(VramRowSize*FloorHeight-ColumnWidth*ColumnCount) | staa pVram

                inc currentRow
                ldaa yPos | adda #FloorHeight | staa yPos
            pulb
            decb
        while ne | wend
    pulb | pula
    jsr DrawBlocks_
rts
FillTile2:
    stx pChars
    ldaa pChars+1 | adda charOffset2 | staa pChars+1
    ldaa pChars | adca #0 | staa pChars
    ldab #1
    bra Repeat
FillTile4:
    stx pChars
    ldaa pChars+1 | adda charOffset4 | staa pChars+1
    ldaa pChars | adca #0 | staa pChars
    ldab #2
Repeat:
    do
        pshb
            ldaa yPos
            cmpa #WindowHeight
            if cs
                ldab #2
                do
                    ldx pChars | ldaa 0,x | inx | stx pChars
                    ldx pVram | staa 0,x | inx | stx pVram
                    decb
                while ne | wend
                ldaa pVram+1 | adda #low(VramRowSize-2) | staa pVram+1
                ldaa pVram | adca #high(VramRowSize-2) | staa pVram
            else
                ldx pChars | inx | inx | stx pChars
                ldaa pVram+1 | adda #low(VramRowSize) | staa pVram+1
                ldaa pVram | adca #high(VramRowSize) | staa pVram
            endif
            inc yPos
        pulb
        decb
    while ne | wend
rts

Space4:
; 0
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 2
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 4
defb Char_Space, Char_Space
defb Char_Space, Char_Space
; 6
defb Char_Space, Char_Space
defb Char_Space, Char_Space

Space2:
; 0
defb Char_Space, Char_Space
; 2
defb Char_Space, Char_Space
; 4
defb Char_Space, Char_Space
; 6
defb Char_Space, Char_Space

Floor:
; 0
defb Char_Space_Floor0, Char_Space_Floor0
; 2
defb Char_Space_Floor2, Char_Space_Floor2
; 4
defb Char_Space_Floor4, Char_Space_Floor4
; 6
defb Char_Space_Floor6, Char_Space_Floor6

SpaceUnderFloor:
; 0
defb Char_Space, Char_Space
; 2
defb Char_Space, Char_Space
; 4
defb Char_Space, Char_Space
; 6
defb Char_Floor_Space6, Char_Floor_Space6

WallUnderFloor:
; 0
defb Char_Wall_Wall0, Char_Space
; 2
defb Char_Wall_Wall0, Char_Space
; 4
defb Char_Wall_Wall0, Char_Space
; 6
defb Char_Wall_Wall0, Char_Floor_Space6

SpaceLadder:
; 0
defb Char_Space, Char_Space
defb Char_Space_LeftLadder0, Char_Space_RightLadder0
; 2
defb Char_Space, Char_Space
defb Char_Space_LeftLadder2, Char_Space_RightLadder2
; 4
defb Char_Space, Char_Space
defb Char_Space_LeftLadder4, Char_Space_RightLadder4
; 6
defb Char_Space, Char_Space
defb Char_Space_LeftLadder6, Char_Space_RightLadder6

Ladder4:
; 0
defb Char_Space_LeftLadder0, Char_Space_RightLadder0
defb Char_Space_LeftLadder0, Char_Space_RightLadder0
; 2
defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
; 4
defb Char_Space_LeftLadder0, Char_Space_RightLadder0
defb Char_Space_LeftLadder0, Char_Space_RightLadder0
; 6
defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2

Ladder2:
; 0
defb Char_Space_LeftLadder0, Char_Space_RightLadder0
; 2
defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
; 4
defb Char_Space_LeftLadder0, Char_Space_RightLadder0
; 6
defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2

LadderFloor:
; 0
defb Char_Space_Floor0, Char_Space_Floor0
; 2
defb Char_LeftLadder_Floor2, Char_RightLadder_Floor2
; 4
defb Char_LeftLadder_Floor4, Char_RightLadder_Floor4
; 6
defb Char_LeftLadder_Floor6, Char_RightLadder_Floor6

LadderWall:
; 0
defb Char_Wall_Wall0, Char_Space_Floor0
; 2
defb Char_LeftLadder_Wall2, Char_RightLadder_Floor2
; 4
defb Char_LeftLadder_Floor4, Char_RightLadder_Floor4
; 6
defb Char_LeftLadder_Floor6, Char_RightLadder_Floor6

Wall:
; 0
defb Char_Wall_Wall0, Char_Space
defb Char_Wall_Wall0, Char_Space
; 2
defb Char_Wall_Wall0, Char_Space
defb Char_Wall_Wall0, Char_Space
; 4
defb Char_Wall_Wall0, Char_Space
defb Char_Wall_Wall0, Char_Space
; 6
defb Char_Wall_Wall0, Char_Space
defb Char_Wall_Wall0, Char_Space

SpaceWall:
; 0
defb Char_Wall_Wall0, Char_Space_Floor0
; 2
defb Char_Space_Wall2, Char_Space_Floor2
; 4
defb Char_Space_Floor4, Char_Space_Floor4
; 6
defb Char_Space_Floor6, Char_Space_Floor6

WallFloorUnderWall:
; 0
defb Char_Wall_Wall0, Char_Space_Floor0
; 2
defb Char_Wall_Wall0, Char_Space_Floor2
; 4
defb Char_Wall_Wall0, Char_Space_Floor4
; 6
defb Char_Wall_Wall0, Char_Space_Floor6

FloorUnderWall:
; 0
defb Char_Space_Floor0, Char_Space_Floor0
; 2
defb Char_Wall_Floor2, Char_Space_Floor2
; 4
defb Char_Wall_Wall0, Char_Space_Floor4
; 6
defb Char_Wall_Wall0, Char_Space_Floor6
endscope