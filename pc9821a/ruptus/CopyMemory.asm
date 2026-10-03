; void FillMemory(ptr<byte> pDestination, word length, byte b);
cseg
FillMemory_: public FillMemory_
    push dx | push bx
        mov bx,ax
        do
            mov [bx],cl
            inc bx
            dec dx
        while nz | wend
    pop bx | pop dx
ret
