include "VVram.inc"
include "VVram.inc"
include "Chars.inc"

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

dseg
BackgroundChanged_: public BackgroundChanged_
    defb 0
charOffset2:
    defb 0
charOffset4:
    defb 0
mapHeight:
    defb 0
yPos:
    defb 0


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    pushw rr2
        mult rr2,VVramWidth
        clr r0
        addw rr0,rr2
        addw rr0,VVram
    popw rr2
ret


; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    pushw rr0 | pushw rr2 | pushw rr4 | pushw rr6 | pushw rr8 | pushw rr10
        mov r1,@dotOffset_
        sll r1 | mov @charOffset2,r1
        sll r1 | mov @charOffset4,r1

        movw rr0,@pStage_
        mov r1,@rr0
        dec r1
        mov @mapHeight,r1

        mov r4,@topRow_ ; currentRow
        cmp r4,0
        if pl
            mov r1,r4
            sll r1 | add r1,r4
            clr r0
            addw rr0,StageMap_-MapWidth
            movw rr8,rr0
        else
            movw rr8,StageMap_-MapWidth*2
        endif

        movw rr10,VVram
        mov r1,@yMod_
        clr r0 | sub r0,r1 | mov @yPos,r0
        clr r0
        mult rr0,VVramWidth
        subw rr10,rr0

        mov r0,VisibleFloorCount
        do
            mov r1,MapWidth
            do
                pushw rr0
                    or r4,r4 ; currentRow
                    if pl
                        if z
                            clr r1
                        else
                            mov r5,@rr8 ; upperByte
                        endif
                        mov r6,MapWidth(rr8) ; middleByte

                        cmp r4,@mapHeight ; currentRow
                        if c
                            mov r7,MapWidth*2(rr8) ; lowerByte
                        else
                            clr r7
                        endif
                    else
                        mov r5,0ffh ; upperByte
                        clr r6 ; middleByte
                        mov r7,MapWidth*2(rr8) ; lowerByte
                    endif
                    incw rr8

                    pushw rr8
                        mov r2,ColumnsPerByte
                        do
                            mov r1,r6 | and r1,3 ; middleByte
                            if z
                                mov r1,r5 | and r1,3 ; upperByte
                                cmp r1,CellType_Hole
                                if z
                                    movw rr8,Space2 | call FillTile2
                                else
                                    movw rr8,SpaceUnderFloor | call FillTile2
                                endif
                                mov r1,r7 | and r1,3 ; lowerByte
                                cmp r1,CellType_Ladder
                                if z
                                    movw rr8,SpaceLadder | call FillTile4
                                    movw rr8,Ladder2 | call FillTile2
                                    br t,next
                                endif
                                cmp r1,CellType_Wall
                                if z
                                    movw rr8,Space4 | call FillTile4
                                    movw rr8,SpaceWall | call FillTile2
                                    br t,next
                                endif
                                movw rr8,Space4 | call FillTile4
                                movw rr8,Floor | call FillTile2
                                br t,next
                            endif
                            cmp r1,CellType_Ladder ; middleByte
                            if z
                                movw rr8,Ladder2 | call FillTile2
                                movw rr8,Ladder4 | call FillTile4
                                mov r1,r7 | and r1,3 ; lowerByte
                                cmp r1,CellType_Ladder
                                if z
                                    movw rr8,Ladder2 | call FillTile2
                                    br t,next
                                endif
                                cmp r1,CellType_Wall ; lowerByte
                                if z
                                    movw rr8,LadderWall | call FillTile2
                                    br t,next
                                endif
                                movw rr8,LadderFloor | call FillTile2
                                br t,next
                            endif
                            cmp r1,CellType_Wall ; middleByte
                            if z
                                movw rr8,WallUnderFloor | call FillTile2
                                movw rr8,Wall | call FillTile4
                                mov r1,r7 | and r1,3 ; lowerByte
                                cmp r1,CellType_Wall
                                if z
                                    movw rr8,WallFloorUnderWall | call FillTile2
                                    br t,next
                                endif
                                movw rr8,FloorUnderWall | call FillTile2
                                br t,next
                            endif
                            mov r1,r5 | and r1,3 ; upperByte
                            cmp r1,CellType_Hole
                            if z
                                movw rr8,Space2 | call FillTile2
                            else
                                movw rr8,SpaceUnderFloor | call FillTile2
                            endif
                            movw rr8,Space4 | call FillTile4
                            movw rr8,Space2 | call FillTile2
                            
                            next:
                            addw rr10,-VVramWidth*FloorHeight+ColumnWidth
                            mov r1,@yPos | sub r1,FloorHeight | mov @yPos,r1

                            srl r5 | srl r5 ; upperByte
                            srl r6 | srl r6 ; middleByte
                            srl r7 | srl r7 ; lowerByte

                            dec r2
                        while nz|wend
                    popw rr8
                popw rr0
                dec r1
            while nz|wend
            inc r4 ; currentRow
            addw rr10,VVramWidth*FloorHeight-ColumnWidth*ColumnCount
            mov r1,@yPos | add r1,FloorHeight | mov @yPos,r1

            dec r0
        while nz|wend
    popw rr10 | popw rr8 | popw rr6 | popw rr4 | popw rr2 | popw rr0
    call DrawBlocks_
ret
FillTile2:
    mov r1,@charOffset2 | clr r0
    addw rr8,rr0
    mov r3,1
jmp t,Repeat
FillTile4:
    mov r1,@charOffset4 | clr r0
    addw rr8,rr0
    mov r3,2
Repeat:
    mov r0,@yPos
    do
        cmp r0,VVramHeight
        if c
            mov r1,(rr8)+ | mov (rr10)+,r1
            mov r1,(rr8)+ | mov @rr10,r1
            addw rr10,VVramWidth-1
        else
            incw rr8 | incw rr8
            addw rr10,VVramWidth
        endif
        inc r0
        dec r3
    while nz|wend
    mov @yPos,r0
ret


Space4:
	; 0
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 1
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 2
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 3
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 4
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 5
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 6
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
	; 7
	defb Char_Space, Char_Space
	defb Char_Space, Char_Space
Space2:
	; 0
	defb Char_Space, Char_Space
	; 1
	defb Char_Space, Char_Space
	; 2
	defb Char_Space, Char_Space
	; 3
	defb Char_Space, Char_Space
	; 4
	defb Char_Space, Char_Space
	; 5
	defb Char_Space, Char_Space
	; 6
	defb Char_Space, Char_Space
	; 7
	defb Char_Space, Char_Space
Floor:
	; 0
	defb Char_Space_Floor0, Char_Space_Floor0
	; 1
	defb Char_Space_Floor1, Char_Space_Floor1
	; 2
	defb Char_Space_Floor2, Char_Space_Floor2
	; 3
	defb Char_Space_Floor3, Char_Space_Floor3
	; 4
	defb Char_Space_Floor4, Char_Space_Floor4
	; 5
	defb Char_Space_Floor5, Char_Space_Floor5
	; 6
	defb Char_Space_Floor6, Char_Space_Floor6
	; 7
	defb Char_Space_Floor7, Char_Space_Floor7
SpaceUnderFloor:
	; 0
	defb Char_Space, Char_Space
	; 1
	defb Char_Space, Char_Space
	; 2
	defb Char_Space, Char_Space
	; 3
	defb Char_Space, Char_Space
	; 4
	defb Char_Space, Char_Space
	; 5
	defb Char_Floor_Space5, Char_Floor_Space5
	; 6
	defb Char_Floor_Space6, Char_Floor_Space6
	; 7
	defb Char_Floor_Space7, Char_Floor_Space7
WallUnderFloor:
	; 0
	defb Char_Wall_Wall0, Char_Space
	; 1
	defb Char_Wall_Wall0, Char_Space
	; 2
	defb Char_Wall_Wall0, Char_Space
	; 3
	defb Char_Wall_Wall0, Char_Space
	; 4
	defb Char_Wall_Wall0, Char_Space
	; 5
	defb Char_Wall_Wall0, Char_Floor_Space5
	; 6
	defb Char_Wall_Wall0, Char_Floor_Space6
	; 7
	defb Char_Wall_Wall0, Char_Floor_Space7
SpaceLadder:
	; 0
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 1
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder1, Char_Space_RightLadder1
	; 2
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder2, Char_Space_RightLadder2
	; 3
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder3, Char_Space_RightLadder3
	; 4
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder4, Char_Space_RightLadder4
	; 5
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder5, Char_Space_RightLadder5
	; 6
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder6, Char_Space_RightLadder6
	; 7
	defb Char_Space, Char_Space
	defb Char_Space_LeftLadder7, Char_Space_RightLadder7
Ladder4:
	; 0
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 1
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
	; 2
	defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
	defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
	; 3
	defb Char_LeftLadder_LeftLadder3, Char_RightLadder_RightLadder3
	defb Char_LeftLadder_LeftLadder3, Char_RightLadder_RightLadder3
	; 4
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 5
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
	; 6
	defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
	defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
	; 7
	defb Char_LeftLadder_LeftLadder3, Char_RightLadder_RightLadder3
	defb Char_LeftLadder_LeftLadder3, Char_RightLadder_RightLadder3
Ladder2:
	; 0
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 1
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
	; 2
	defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
	; 3
	defb Char_LeftLadder_LeftLadder3, Char_RightLadder_RightLadder3
	; 4
	defb Char_Space_LeftLadder0, Char_Space_RightLadder0
	; 5
	defb Char_LeftLadder_LeftLadder1, Char_RightLadder_RightLadder1
	; 6
	defb Char_LeftLadder_LeftLadder2, Char_RightLadder_RightLadder2
	; 7
	defb Char_LeftLadder_LeftLadder3, Char_RightLadder_RightLadder3
LadderFloor:
	; 0
	defb Char_Space_Floor0, Char_Space_Floor0
	; 1
	defb Char_LeftLadder_Floor1, Char_RightLadder_Floor1
	; 2
	defb Char_LeftLadder_Floor2, Char_RightLadder_Floor2
	; 3
	defb Char_LeftLadder_Floor3, Char_RightLadder_Floor3
	; 4
	defb Char_LeftLadder_Floor4, Char_RightLadder_Floor4
	; 5
	defb Char_LeftLadder_Floor5, Char_RightLadder_Floor5
	; 6
	defb Char_LeftLadder_Floor6, Char_RightLadder_Floor6
	; 7
	defb Char_LeftLadder_Floor7, Char_RightLadder_Floor7
LadderWall:
	; 0
	defb Char_Wall_Wall0, Char_Space_Floor0
	; 1
	defb Char_LeftLadder_Wall1, Char_RightLadder_Floor1
	; 2
	defb Char_LeftLadder_Wall2, Char_RightLadder_Floor2
	; 3
	defb Char_LeftLadder_Wall3, Char_RightLadder_Floor3
	; 4
	defb Char_LeftLadder_Floor4, Char_RightLadder_Floor4
	; 5
	defb Char_LeftLadder_Floor5, Char_RightLadder_Floor5
	; 6
	defb Char_LeftLadder_Floor6, Char_RightLadder_Floor6
	; 7
	defb Char_LeftLadder_Floor7, Char_RightLadder_Floor7
Wall:
	; 0
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 1
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 2
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 3
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 4
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 5
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 6
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
	; 7
	defb Char_Wall_Wall0, Char_Space
	defb Char_Wall_Wall0, Char_Space
SpaceWall:
	; 0
	defb Char_Wall_Wall0, Char_Space_Floor0
	; 1
	defb Char_Space_Wall1, Char_Space_Floor1
	; 2
	defb Char_Space_Wall2, Char_Space_Floor2
	; 3
	defb Char_Space_Wall3, Char_Space_Floor3
	; 4
	defb Char_Space_Floor4, Char_Space_Floor4
	; 5
	defb Char_Space_Floor5, Char_Space_Floor5
	; 6
	defb Char_Space_Floor6, Char_Space_Floor6
	; 7
	defb Char_Space_Floor7, Char_Space_Floor7
WallFloorUnderWall:
	; 0
	defb Char_Wall_Wall0, Char_Space_Floor0
	; 1
	defb Char_Wall_Wall0, Char_Space_Floor1
	; 2
	defb Char_Wall_Wall0, Char_Space_Floor2
	; 3
	defb Char_Wall_Wall0, Char_Space_Floor3
	; 4
	defb Char_Wall_Wall0, Char_Space_Floor4
	; 5
	defb Char_Wall_Wall0, Char_Space_Floor5
	; 6
	defb Char_Wall_Wall0, Char_Space_Floor6
	; 7
	defb Char_Wall_Wall0, Char_Space_Floor7
FloorUnderWall:
	; 0
	defb Char_Space_Floor0, Char_Space_Floor0
	; 1
	defb Char_Wall_Floor1, Char_Space_Floor1
	; 2
	defb Char_Wall_Floor2, Char_Space_Floor2
	; 3
	defb Char_Wall_Floor3, Char_Space_Floor3
	; 4
	defb Char_Wall_Wall0, Char_Space_Floor4
	; 5
	defb Char_Wall_Wall0, Char_Space_Floor5
	; 6
	defb Char_Wall_Wall0, Char_Space_Floor6
	; 7
	defb Char_Wall_Wall0, Char_Space_Floor7
