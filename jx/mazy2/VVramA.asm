; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    push bx
        mov bx,ax
        mov [bx],dl
    pop bx
    inc ax
ret