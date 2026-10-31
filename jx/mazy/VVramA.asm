include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Map_
ext BaseX_, BaseY_

MapStep equ 8

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
cseg
MapToVVram_: public MapToVVram_
    push ax | push cx | push dx | push si | push di
        mov al,[BaseY_]
        mov ah,MapStep
        mul ah
        add ax,Map_
        mov si,ax
        mov al,[BaseX_]
        mov cl,al
        shr al,1
        shr al,1
        shr al,1
        xor ah,ah
        add si,ax
        mov dl,1
        and cl,07h
        shl dl,cl

        mov di,VVram_
        mov ch,VVramHeight
        do
            push si
                mov cl,VVramWidth
                do
                    mov al,[si]
                    test al,dl
                    if nz
                        mov byte ptr [di],Char_Wall
                    else
                        mov byte ptr [di],Char_Space
                    endif
                    inc di
                    rol dl,1
                    if b
                        inc si
                    endif
                    dec cl
                while nz | wend
            pop si
            add si,MapStep
            dec ch
        while nz | wend
    pop di | pop si | pop dx | pop cx | pop ax
ret
