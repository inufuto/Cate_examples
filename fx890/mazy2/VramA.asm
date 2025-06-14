include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

dseg
Vram_: public Vram_
    defs VramWidth*VramHeight
Backup:
    defs VVramWidth*VVramHeight
CharShift_: public CharShift_
    defb 0
TopRow_: public TopRow_
    defb 0


cseg
WaitLcd:
    push ax
        do
            mov al,[es:0]
            test al,80h
        while nz | wend
    pop ax
ret

WriteLcd: public WriteLcd
    call WaitLcd
    ; or al,20h
    mov [es:0],al
    mov [es:1],ah
ret

ReadLcd: public ReadLcd
    call WaitLcd
    ; or al,20h
    mov [es:0],al
    mov ah,[es:1]
ret


; void PresentVram();
cseg
PresentVram_: public PresentVram_
    push ax | push bx | push cx | push dx | push si
        mov ax,LcdSegment | mov es,ax

        mov cl,4
        mov si,Vram_
        mov ch,0
        do
            xor ah,ah
            mov bh,2
            do
                push ax
                    mov al,22h | mov ah,ch | call WriteLcd
                    mov ax,0421h | call WriteLcd
                pop ax
                mov al,20h
                mov bl,12
                do
                    mov dh,[si] | inc si
                    xor dl,dl
                    shr dx,cl
                    or ah,dh
                    call WriteLcd
                    mov ah,dl
                    dec bl
                while nz | wend
                call WriteLcd
                xor ch,20h
                dec bh
            while nz | wend
            inc ch
            cmp ch,VramHeight
        while nz | wend
    pop si | pop dx | pop cx | pop bx | pop ax
ret


; void ClearScreen();
cseg
Clear:
    xor ax,ax
    do
        mov [bx],ax
        inc bx | inc bx
    wloop
ret
ClearScreen_: public ClearScreen_
    push ax | push bx | push cx
        mov bx,Vram_
        mov cx,VramWidth*VramHeight/2
        call Clear
       
        mov bx,Backup
        mov cx,VVramWidth*VVramHeight/2
        call Clear

        mov bx,VVramBack_
        mov cx,VVramWidth*VVramHeight/2
        call Clear
    pop cx | pop bx | pop ax
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c, bool right);
cseg
CharTable:
    defb " 0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push bx | push si | push di
        mov di,ax

        mov bx,CharTable
        xor al,al
        do
            cmp dl,[bx]
            jz PrintC_break
            inc bx
            inc al
            cmp al,29
        while ne | wend
        xor al,al
        PrintC_break:
        mov ah,4 | mul ah
        add ax,AsciiPattern
        mov si,ax

        or cl,cl
        if z
            push di
                mov bl,4
                do
                    mov bh,[si] | inc si

                    mov ah,bh
                    and ah,0f0h
                    mov al,[di]
                    and al,0fh
                    or al,ah
                    mov [di],al
                    add di,VramWidth
                    
                    mov ah,bh
                    shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
                    mov al,[di]
                    and al,0fh
                    or al,ah
                    mov [di],al
                    add di,VramWidth
                    
                    dec bl
                while nz | wend
            pop ax
        else
            push di
                mov bl,4
                do
                    mov bh,[si] | inc si
                    
                    mov ah,bh
                    shr ah,1 | shr ah,1 | shr ah,1 | shr ah,1
                    mov al,[di]
                    and al,0f0h
                    or al,ah
                    mov [di],al
                    add di,VramWidth
                    
                    mov ah,bh
                    and ah,0fh
                    mov al,[di]
                    and al,0f0h
                    or al,ah
                    mov [di],al
                    add di,VramWidth
                    
                    dec bl
                while nz | wend
            pop ax
            inc ax
        endif
    pop di | pop si | pop bx
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push cx | push dx | push si | push di
        mov di,ax ; pVram
        mov al,dl ; c
        mov cl,[CharShift_]
        mov dx,0e000h
        shr dx,cl
        call Put
        mov ax,di
        add cl,3
        mov [CharShift_],cl
        sub cl,8
        if nc
            mov [CharShift_],cl
            inc ax
        endif
    pop di | pop si | pop dx | pop cx
ret
Put: ; di=pVram, cl=shift, dx=mask, al=c
    xor ah,ah
    add ax,ax
    add ax,CharPattern
    mov si,ax

    mov ah,[si] | and ah,0f0h
    call WriteByte
    mov ah,[si] | shl ah,1 | shl ah,1 | shl ah,1 | shl ah,1
    call WriteByte
    inc si
    mov ah,[si] | and ah,0f0h
    call WriteByte
    sub di,VramWidth*3
ret
WriteByte:
    xor al,al
    shr ax,cl
    or dh,dh
    if nz
        mov ch,dh
        not ch
        and ch,[di]
        or ch,ah
        mov [di],ch
    endif
    or dl,dl
    if nz
        mov ch,dl
        not ch
        and ch,[di+1]
        or ch,al
        mov [di+1],ch
    endif
    add di,VramWidth
ret
       

; void VVramToVram();
VVramToVram_: public VVramToVram_
    push ax | push bx | push cx | push dx | push si | push di
        mov al,[TopRow_]
        mov ah,VVramWidth | mul ah
        add ax,VVramFront_+VVramWidth+1
        mov si,ax
        mov bx,Backup
        mov di,Vram_

        mov ch,WindowHeight
        do
            push cx | push di
                mov dx 0e000h
                mov cx,WindowWidth shl 8
                do
                    mov al,[si] | inc si
                    cmp al,[bx]
                    if ne
                        mov [bx],al
                        push cx | push si
                            call Put
                        pop si | pop cx
                    endif
                    inc bx

                    ror dx,1 | ror dx,1 | ror dx,1
                    add cl,3
                    cmp cl,8
                    if nc
                        sub cl,8
                        inc di
                        mov dx 0e000h
                        shr dx,cl
                    endif
                    dec ch
                while nz | wend
            pop di | pop cx
            inc si | inc si
            add di,VramWidth*3
            dec ch
        while nz | wend
    pop si | pop si | pop dx | pop cx | pop bx | pop ax
ret
