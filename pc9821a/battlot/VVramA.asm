include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push dx
        inc dl
        mov dh,al
        mov al,VVramWidth
        mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,VVram_
    pop dx
ret
