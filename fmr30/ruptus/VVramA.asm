include "VVram.inc"

ext VVram_

; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    push ax | push cx | push bx
        mov bx,VVram_
        xor ax,ax
        mov cx,VVramWidth*VVramHeight/2
        do
            mov [bx],ax
            add bx,2
        wloop
    pop bx | pop cx | pop ax
ret

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
