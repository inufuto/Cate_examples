; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
cseg
CopyMemory_: public CopyMemory_
    push ax | push cx | push si | push di
        mov di,ax
        mov si,dx
        do
            mov al,[si] | inc si
            mov [di],al | inc di
            dec cx
        while nz | wend
    pop di | pop si | pop cx | pop ax
ret


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
