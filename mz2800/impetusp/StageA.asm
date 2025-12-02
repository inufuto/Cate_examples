include "Vram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext TerrainPattern
ext TerrainCharOffset
ext NextPage

TerrainCharCount equ Char_Terrain1-Char_Terrain0
MapWidth equ 8
TileSize equ 4
GroundHeight equ VramHeight/TileSize+1

; void UpdateGroundChars(bool next);
cseg
UpdateGroundChars_: public UpdateGroundChars_
    push ax | push bx | push cx | push si | push di
        or al,al
        mov al,[TerrainCharOffset]
        if z
            xor al,TerrainCharCount
        endif
        add al,Char_Terrain
        mov ah,CharHeight*2 | mul ah
        mov di,ax

        mov ax,PcgSegment | mov es,ax
        
        mov al,[DotOffset_] | xor ah,ah
        mov si,TerrainPattern+CharHeight
        sub si,ax

        mov ch,TerrainCharCount
        do
            mov cl,TPlaneCount
            do
                mov bl,CharHeight
                do
                    movsb
                    inc di
                    dec bl
                while nz | wend
                add si,CharHeight
                add di,1000h-CharHeight*2
                dec cl
            while nz | wend
            add di,CharHeight*2-1000h*TPlaneCount
            dec ch
        while nz | wend
    pop di | pop si | pop cx | pop cx | pop ax
ret


; void DrawGround();
cseg
DrawGround_: public DrawGround_
	push ax | push bx | push cx | push dx | push si | push di
        mov ax,TVramSegment | mov es,ax

        mov di,0
        mov dl,0 ;yPos
        mov al,[yMod_]
        and al,3
        sub dl,al
        mov ah,VramRowSize | mul ah
        sub di,ax
        add di,[NextPage]

        mov dh,[TerrainCharOffset]
        mov bx,Ground_
        do
            mov ch,MapWidth
            do
                mov al,[bx] | inc bx
                xor ah,ah
                shl ax,1 | shl ax,1 | shl ax,1 | shl ax,1
                add ax,Tiles_
                mov si,ax
                
                mov cl,TileSize
                do
                    cmp dl,VramHeight ; yPos
                    if c
                        mov ah,TileSize
                        do
                            mov al,[si] | inc si
                            add al,dh
                            mov [es:di],al
                            add di,VramStep
                            dec ah
                        while nz | wend
                        add di,VramRowSize-TileSize*VramStep
                    else
                        inc si | inc si | inc si | inc si
                        add di,VramRowSize
                    endif
                    inc dl ; yPos
                    dec cl
                while nz | wend
                add di,TileSize*VramStep-VramRowSize*TileSize
                sub dl,TileSize
                dec ch
            while nz | wend
            add di,VramRowSize*TileSize-TileSize*MapWidth*VramStep
            add dl,TileSize
            cmp dl,VramHeight
        while c | wend
	pop di | pop si | pop dx | pop cx | pop bx | pop ax
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
