include "VVram.inc"

ext VVram_
ext yMod_, Background_
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


; void BackgroundToVVram();
cseg
BackgroundToVVram_: public BackgroundToVVram_
    push ax | push cx | push si | push di
        mov al,[yMod_]
        mov ah,VVramWidth
        mul ah
        add ax,Background_
        mov si,ax

        mov ax,ds | mov es,ax
        mov di,VVram_
        mov cx,VVramWidth*VVramHeight/2
        do
            movsw
        wloop
        call DrawBlocks_
    pop di | pop si | pop cx | pop ax
ret