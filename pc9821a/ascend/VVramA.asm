include "VVram.inc"
include "Chars.inc"

ext VVram_
ext dotOffset_
ext pStage_, StageMap_, topRow_, yMod_
ext DrawBlocks_

VisibleFloorCount equ (VVramHeight+FloorHeight-1)/FloorHeight+1
FloorHeight equ 4
ColumnCount equ 16
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte
ColumnWidth equ 2

CellType_Space equ 0
CellType_Ladder equ 1
CellType_Wall equ 2
CellType_Hole equ 3

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push dx
        mov dh,al
        mov al,VVramWidth
        mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,VVram_
    pop dx
ret


; void MapToVVram();
dseg
charOffset2:
    defb 0
charOffset4:
    defb 0
mapHeight:
    defb 0
yPos:
    defb 0
cseg
MapToVVram_: public MapToVVram_
    push ax | push bx | push cx | push dx | push si | push di
        mov al,[dotOffset_]
        shl al,1 | mov [charOffset2],al
        shl al,1 | mov [charOffset4],al

        mov bx,[pStage_]
        mov al,[bx]
        dec al
        mov [mapHeight],al

        mov ch,[topRow_] ; currentRow
        cmp ch,0
        if ns
            mov al,ch
            shl al,1 | shl al,1
            xor ah,ah
            add ax,StageMap_-MapWidth
            mov si,ax
        else
            mov si,StageMap_-MapWidth*2
        endif

        mov di,VVram_
        mov al,[yMod_]
        xor ah,ah | sub ah,al | mov [yPos],ah
        mov ah,VVramWidth | mul ah
        sub di,ax

        mov ah,VisibleFloorCount
        do
            mov al,MapWidth
            do
                push ax
                    or ch,ch ; currentRow
                    if ns
                        if z
                            xor al,al
                        else
                            mov cl,[si] ; upperByte
                        endif
                        mov dh,[si+MapWidth] ; middleByte

                        cmp ch,[mapHeight] ; currentRow
                        if c
                            mov dl,[si+MapWidth*2] ; lowerByte
                        else
                            xor dl,dl
                        endif
                    else
                        mov cl,0ffh ; upperByte
                        xor dh,dh ; middleByte
                        mov dl,[si+MapWidth*2] ; lowerByte
                    endif
                    inc si

                    push si
                        mov bh,ColumnsPerByte
                        do
                            mov al,dh | and al,3 ; middleByte
                            if z
                                mov al,cl | and al,3 ; upperByte
                                cmp al,CellType_Hole
                                if z
                                    mov si,Space2 | call FillTile2
                                else
                                    mov si,SpaceUnderFloor | call FillTile2
                                endif
                                mov al,dl | and al,3 ; lowerByte
                                cmp al,CellType_Ladder
                                if z
                                    mov si,SpaceLadder | call FillTile4
                                    mov si,Ladder2 | call FillTile2
                                    jmp next
                                endif
                                cmp al,CellType_Wall
                                if z
                                    mov si,Space4 | call FillTile4
                                    mov si,SpaceWall | call FillTile2
                                    jmp next
                                endif
                                mov si,Space4 | call FillTile4
                                mov si,Floor | call FillTile2
                                jmp next
                            endif
                            cmp al,CellType_Ladder ; middleByte
                            if z
                                mov si,Ladder2 | call FillTile2
                                mov si,Ladder4 | call FillTile4
                                mov al,dl | and al,3 ; lowerByte
                                cmp al,CellType_Ladder
                                if z
                                    mov si,Ladder2 | call FillTile2
                                    jmp next
                                endif
                                cmp al,CellType_Wall ; lowerByte
                                if z
                                    mov si,LadderWall | call FillTile2
                                    jmp next
                                endif
                                mov si,LadderFloor | call FillTile2
                                jmp next
                            endif
                            cmp al,CellType_Wall ; middleByte
                            if z
                                mov si,WallUnderFloor | call FillTile2
                                mov si,Wall | call FillTile4
                                mov al,dl | and al,3 ; lowerByte
                                cmp al,CellType_Wall
                                if z
                                    mov si,WallFloorUnderWall | call FillTile2
                                    jmp next
                                endif
                                mov si,FloorUnderWall | call FillTile2
                                jmp next
                            endif
                            mov al,cl | and al,3 ; upperByte
                            cmp al,CellType_Hole
                            if z
                                mov si,Space2 | call FillTile2
                            else
                                mov si,SpaceUnderFloor | call FillTile2
                            endif
                            mov si,Space4 | call FillTile4
                            mov si,Space2 | call FillTile2
                            
                            next:
                            add di,-VVramWidth*FloorHeight+ColumnWidth
                            mov al,[yPos] | sub al,FloorHeight | mov [yPos],al

                            shr cl,1 | shr cl,1 ; upperByte
                            shr dh,1 | shr dh,1 ; middleByte
                            shr dl,1 | shr dl,1 ; lowerByte

                            dec bh
                        while nz|wend
                    pop si
                pop ax
                dec al
            while nz|wend
            inc ch ; currentRow
            add di,VVramWidth*FloorHeight-ColumnWidth*ColumnCount
            mov al,[yPos] | add al,FloorHeight | mov [yPos],al

            dec ah
        while nz|wend
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
    call DrawBlocks_
ret
FillTile2:
    mov al,[charOffset2] | xor ah,ah
    add si,ax
    mov bl,1
jmp Repeat
FillTile4:
    mov al,[charOffset4] | xor ah,ah
    add si,ax
    mov bl,2
Repeat:
    mov ah,[yPos]
    do
        cmp ah,VVramHeight
        if c
            mov al,[si] | inc si | mov [di],al | inc di
            mov al,[si] | inc si | mov [di],al
            add di,VVramWidth-1
        else
            inc si | inc si
            add di,VVramWidth
        endif
        inc ah
        dec bl
    while nz|wend
    mov [yPos],ah
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
