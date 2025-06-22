include "VVram.inc"

ext VVram_
ext Ground_, GroundY_, dotOffset_
ext Tiles_

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


; void RollDown();
cseg
RollDown_: public RollDown_
    push ax | push bx
        mov bx,Ground_+GroundWidth*(GroundHeight-1)
        mov ah,GroundWidth*(GroundHeight-1)
        do
            dec bx
            mov al,[bx]
            mov [bx+GroundWidth],al
            dec ah
        while nz | wend
    pop bx | pop ax
ret


TileSize equ 4
GroundWidth equ VVramWidth/TileSize
GroundHeight equ (VVramHeight+TileSize*2-1)/TileSize

; void DrawGround();
cseg
DrawGround_: public DrawGround_
    push ax | push bx | push cx | push dx | push si | push di
        mov al,[dotOffset_]
        mov ah,16 | mul ah
        add ax,Tiles_
        mov bx,ax

        mov di,VVram_
        mov al,[GroundY_] | mov dh,al ; yPos
        or al,al
        do | while s
            sub di,VVramWidth
            inc al
        wend

        mov si,Ground_
        do
            mov dl,GroundWidth
            do
                push bx
                    mov al,[si] | inc si
                    mov ah,16*2 | mul ah
                    add bx,ax

                    mov ch,TileSize
                    do
                        cmp dh,VVramHeight
                        if c
                            mov cl,TileSize
                            do
                                mov al,[bx] | inc bx
                                mov [di],al | inc di
                                dec cl
                            while nz | wend
                            add di,VVramWidth-TileSize
                        else
                            add bx,TileSize
                            add di,VVramWidth
                        endif
                        inc dh
                        dec ch
                    while nz | wend
                pop bx
                add di,TileSize-VVramWidth*TileSize
                sub dh,TileSize
                dec dl
            while nz | wend
            add di,VVramWidth*(TileSize-1)
            add dh,TileSize
            cmp dh,VVramHeight
        while c | wend
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
ret
