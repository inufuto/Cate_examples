include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles
ext TerrainPattern
ext TerrainCharOffset
ext VVram_

MapWidth equ 6
TileSize equ 4
GroundHeight equ (VVramHeight+TileSize-1)/TileSize+1
TerrainCharCount equ Char_Terrain1-Char_Terrain0

; void UpdateGroundChars(bool next);
cseg
UpdateGroundChars_: public UpdateGroundChars_
    push ax | push cx | push si | push di
        or al,al
        mov al,[TerrainCharOffset]
        if z
            xor al,TerrainCharCount
        endif
        or al,al
        if z
            mov di,2000h+Char_Terrain0*PatternSize 
        else
            mov di,2000h+Char_Terrain1*PatternSize
        endif

        mov al,[DotOffset_]
        and al,7
        add al,al
        xor ah,ah
        mov si,TerrainPattern+PatternSize
        sub si,ax

        mov ch,TerrainCharCount
        do
            mov cl,PatternSize/2
            do
                mov ax,[cs:si] | inc si | inc si
                mov [di],ax | inc di | inc di
                dec cl
            while nz | wend
            add si,PatternSize
            dec ch
        while nz | wend
    pop di | pop di | pop cx | pop ax
ret


; void DrawGround();
cseg
DrawGround_: public DrawGround_
	push ax | push cx | push dx | push bx | push si | push di
        mov di,VVram_
        mov dl,0 ;yPos
        mov al,[yMod_]
        and al,3
        sub dl,al
        mov ah,VVramWidth | mul ah
        sub di,ax

        mov ah,[TerrainCharOffset]
        
        mov si,Ground_
        do
            mov ch,MapWidth
            do
                mov bl,[si] | inc si
                xor bh,bh
                shl bx,1 | shl bx,1 | shl bx,1 | shl bx,1
                add bx,Tiles
                
                mov cl,TileSize
                do
                    cmp dl,VVramHeight ; yPos
                    if c
                        mov dh,TileSize
                        do
                            mov al,[cs:bx] | inc bx
                            add al,ah
                            mov [di],al | inc di
                            dec dh
                        while nz | wend
                        add di,VVramWidth-TileSize
                    else
                        inc bx | inc bx | inc bx | inc bx
                        add di,VVramWidth
                    endif
                    inc dl ; yPos
                    dec cl
                while nz | wend
                add di,TileSize-VVramWidth*TileSize
                sub dl,TileSize
                dec ch
            while nz | wend
            add di,VVramWidth*TileSize-TileSize*MapWidth
            add dl,TileSize
            cmp dl,VVramHeight
        while c | wend
	pop di | pop si | pop bx | pop cx | pop dx | pop ax
ret


; void RollDown();
cseg
RollDown_: public RollDown_
    push ax | push cx | push si | push di
        mov di,Ground_+MapWidth*GroundHeight-2-MapWidth
        mov cl,MapWidth*(GroundHeight-1)/2
        do
            mov ax,[di]
            mov [di+MapWidth],ax
            dec di | dec di
            dec cl
        while nz | wend

        mov si,[pCurrentRow_]
        mov di,Ground_
        mov cl,MapWidth/2
        do
            mov ax,[si] | inc si | inc si
            mov [di],ax | inc di | inc di
            dec cl
        while nz | wend
    pop di | pop si | pop cx | pop ax
ret


ext MapBytes
ext StageMap_

MapHeight equ 32

; void CopyMapBytes(byte index);
cseg
CopyMapBytes_: public CopyMapBytes_
    push ax | push cx | push si | push di
        mov ah,MapWidth*MapHeight | mul ah
        add ax,MapBytes
        mov si,ax
        mov di,StageMap_
        mov cl,MapWidth*MapHeight/2
        do
            mov ax,[cs:si] | inc si | inc si
            mov [di],ax | inc di | inc di
            dec cl
        while nz | wend
    pop di | pop si | pop cx | pop ax
ret
