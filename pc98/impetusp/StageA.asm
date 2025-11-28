include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext Ground_, TopRow_, yMod_, DotOffset_
ext pCurrentRow_
ext Tiles_
ext VVram_

MapWidth equ 8
TileSize equ 4
GroundHeight equ VVramHeight/TileSize+1


; void DrawGround();
cseg
DrawGround_: public DrawGround_
	push ax | push cx | push dx | push bx | push si | push di
        mov di,VVram_
        mov dl,0 ;yPos
										_deb: public _deb
        mov al,[yMod_]
        and al,3
        sub dl,al
        mov ah,VVramWidth | mul ah
        sub di,ax

        mov si,Ground_
        do
            mov ch,MapWidth
            do
                mov bl,[si] | inc si
                shl bl,1
                add bl,[DotOffset_]
                xor bh,bh
                shl bx,1 | shl bx,1 | shl bx,1 | shl bx,1
                add bx,Tiles_
                
                mov cl,TileSize
                do
                    cmp dl,VVramHeight ; yPos
                    if c
                        mov dh,TileSize/2
                        do
                            mov ax,[bx] | inc bx | inc bx
                            mov [di],ax | inc di | inc di
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
