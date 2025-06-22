include "VVram.inc"
include "Vram.inc"
include "Chars.inc"

ext VVram_
ext dotOffset_
ext pStage_, StageMap_, topRow_, yMod_
ext DrawBlocks_

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


; ; void BackgroundToVVram();
; cseg
; BackgroundToVVram_: public BackgroundToVVram_
;     push ax | push cx | push si | push di
;         mov al,[yMod_]
;         mov ah,VVramWidth
;         mul ah
;         add ax,Background_
;         mov si,ax

;         mov ax,ds | mov es,ax
;         mov di,VVram_
;         mov cx,VVramWidth*VVramHeight/2
;         do
;             movsw
;         wloop
;         call DrawBlocks_
;     pop di | pop si | pop cx | pop ax
; ret


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

dseg
charOffset2:
    defw 0
charOffset4:
    defw 0
pUpper:
    defw 0
pMiddle:
    defw 0
pLower:
    defw 0
yPos:
    defb 0
; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    push ax | push bx | push cx | push dx | push si | push di
        mov al,[dotOffset_] | xor ah,ah
        shl ax,1 | mov [charOffset2],ax
        shl ax,1 | mov [charOffset4],ax

        mov bx,[pStage_]
        mov al,[bx] | mov bh,al ; mapHeight

        mov al,[topRow_]
        mov bl,al ; currentRow
        or al,al
        if ns
            shl al,1 | shl al,1 | xor ah,ah
            add ax,StageMap_-MapWidth
            mov si,ax
        else
            mov si,StageMap_-MapWidth*2
        endif

        mov di,VVram_
        mov al,[yMod_]
        neg al
        mov [yPos],al
        if s
            do
                sub di,VVramWidth
                inc al
            while nz | wend
        endif

        mov ch,VisibleFloorCount
        do
            mov cl,MapWidth
            do
                push cx
                    or bl,bl ; currentRow
                    if ns
                        if z
                            xor ch,ch ; upperByte
                        else
                            mov ch,[si] ; upperByte
                        endif
                        mov dh,[si+MapWidth] ; middleByte
                        cmp bl,bh
                        if c
                            mov dl,[si+MapWidth*2] ; lowerByte
                        else
                            xor dl,dl
                        endif
                    else
                        mov ch,0ffh ; upperByte
                        xor dh,dh ; middleByte
                        mov dl,[si+MapWidth*2] ; lowerByte
                    endif
                    inc si
                    push si
                        mov cl,ColumnsPerByte
                        do
                            mov al,dh | and al,3 ; middleByte
                            if z
                                mov al,ch | and al,3 ; upperByte
                                cmp al,CellType_Hole
                                if z
                                    mov ax,Space2
                                else
                                    mov ax,SpaceUnderFloor
                                endif
                                mov [pUpper],ax
                                mov al,dl | and al,3 ; lowerByte
                                cmp al,CellType_Ladder
                                if z
                                    mov word ptr[pMiddle],SpaceLadder
                                    mov word ptr[pLower],Ladder2
                                    jmp next
                                endif
                                cmp al,CellType_Wall ; lowerByte
                                if z
                                    mov word ptr[pMiddle],Space4
                                    mov word ptr[pLower],SpaceWall
                                    jmp next
                                endif
                                mov word ptr[pMiddle],Space4
                                mov word ptr[pLower],Floor
                                jmp next
                            endif
                            cmp al,CellType_Ladder ; middleByte
                            if z
                                mov word ptr[pUpper],Ladder2
                                mov word ptr[pMiddle],Ladder4
                                mov al,dl | and al,3 ; lowerByte
                                cmp al,CellType_Ladder
                                if z
                                    mov word ptr[pLower],Ladder2
                                    jmp next
                                endif
                                cmp al,CellType_Wall ; lowerByte
                                if z
                                    mov word ptr[pLower],LadderWall
                                    jmp next
                                endif
                                mov word ptr[pLower],LadderFloor
                                jmp next
                            endif
                            cmp al,CellType_Wall ; middleByte
                            if z
                                mov word ptr[pUpper],WallUnderFloor
                                mov word ptr[pMiddle],Wall

                                mov al,dl | and al,3 ; lowerByte
                                cmp al,CellType_Wall
                                if z
                                    mov word ptr[pLower],WallFloorUnderWall
                                    jmp next
                                endif
                                mov word ptr[pLower],FloorUnderWall
                                jmp next
                            endif
                            mov al,ch | and al,3 ; upperByte
                            cmp al,CellType_Hole
                            if z
                                mov ax,Space2
                            else
                                mov ax,SpaceUnderFloor
                            endif
                            mov [pUpper],ax
                            mov word ptr[pMiddle],Space4
                            mov word ptr[pLower],Space2
                            next:
                            push cx
                                mov si,[pUpper] | call FillTile2
                                mov si,[pMiddle] | call FillTile4
                                mov si,[pLower] | call FillTile2
                            pop cx

                            add di,ColumnWidth-VVramWidth*FloorHeight
                            sub byte ptr[yPos],FloorHeight

                            shr ch,1 | shr ch,1 ; upperByte
                            shr dh,1 | shr dh,1 ; middleByte
                            shr dl,1 | shr dl,1 ; lowerByte

                            dec cl
                        while nz | wend
                    pop si
                pop cx
                dec cl
            while nz | wend
            add di,VVramWidth*FloorHeight-ColumnWidth*ColumnCount
            add byte ptr[yPos],FloorHeight
            inc bl ; currentRow

            dec ch
        while nz | wend
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
    call DrawBlocks_
ret
FillTile2:
    add si,[charOffset2]
jmp FillRow
FillTile4:
    add si,[charOffset4]
    mov cl,2
    do
        call FillRow
        dec cl
    while nz | wend
ret
FillRow:
                _deb: public _deb
    cmp byte ptr[yPos],VVramHeight
    if c
        mov ax,[si]
        mov [di],ax
    endif
    inc si | inc si
    add di,VVramWidth
    inc byte ptr[yPos]
ret
