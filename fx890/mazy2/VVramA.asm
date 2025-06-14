include "VVram.inc"

ext VVramBack_, VVramFront_


; ptr<byte> VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
	push dx
        mov dh,al
        mov al,VVramWidth | mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
	pop dx
ret


; void VVramBackToFront()
cseg
VVramBackToFront_: public VVramBackToFront_
    push cx | push si | push di
        mov cx,ds | mov es,cx
        mov si,VVramBack_
        mov di,VVramFront_
        mov cx,VVramWidth*VVramHeight/2
        do
            movsw
        wloop
    pop di | pop si | pop cx
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    push bx
        mov bx,ax
        mov [bx],dl
    pop bx
    inc ax
ret