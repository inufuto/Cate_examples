include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVram_

dseg
Vram_: public Vram_
    defs VramWidth*VramHeight
Backup:
    defs VVramWidth*VVramHeight

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
ClearScreen_: public ClearScreen_
    push ax | push bx | push cx
        xor ax,ax
        mov bx,Vram_
        mov cx,VramWidth*VramHeight/2
        do
            mov [bx],ax
            inc bx | inc bx
        wloop
        mov bx,Backup
        mov cx,VVramWidth*VVramHeight/2
        do
            mov [bx],ax
            inc bx | inc bx
        wloop
    pop cx | pop bx | pop ax
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c, byte shift);
cseg
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
CharTable:
    defb " 0123456789ACEFGHIKMNOPRSTUVY"


; ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
cseg
Put_: public Put_
    push ax | push cx | push dx | push si | push di
        mov di,ax
        mov al,8 | mul dl
        add ax,CharPattern
        mov si,ax
        or cl,cl
        if z
            mov cl,8
            do
                mov al,[si] | inc si
                mov [di],al
                add di,VramWidth
                dec cl
            while nz | wend
        else
            mov cl,8
            do
                mov ah,[si] | inc si
                xor al,al
                shr ax,1 | shr ax,1 | shr ax,1 | shr ax,1
                xchg al,ah
                mov dx,[di]
                and dx,0ff0h
                or ax,dx
                mov [di],ax
                add di,VramWidth
                dec cl
            while nz | wend
        endif
    pop di | pop si | pop dx | pop cx | pop ax
    inc ax
ret
        

; void VVramToVram();
VVramToVram_: public VVramToVram_
    push ax | push bx | push cx | push dx | push si | push di
        mov si,VVram_
        mov di,Backup
        mov bx,Vram_
        mov ch,VVramHeight
        do
            mov cl,VVramWidth
            do
                mov al,[si] | inc si
                cmp al,[di]
                if ne
                    mov [di],al
                    mov ah,8 | mul ah
                    add ax,CharPattern
                    push si
                        mov si,ax
                        mov dl,8
                        do
                            mov al,[si] | inc si
                            mov [bx],al
                            add bx,VramWidth
                            dec dl
                        while nz | wend
                        add bx,1-VramWidth*8
                    pop si
                else
                    inc bx
                endif
                inc di
                dec cl
            while nz | wend
            add bx,VramWidth*8-VVramWidth
            dec ch
        while nz | wend
    pop si | pop si | pop dx | pop cx | pop bx | pop ax
ret


; ptr<byte> VramPtr(byte x, byte y);
cseg
VramPtr_: public VramPtr_
    push dx
        mov dh,al
        mov al,VramWidth*8 | mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,Vram_
    pop dx
ret


; ptr<byte> BackupPtr(byte x, byte y);
cseg
BackupPtr_: public BackupPtr_
    push dx
        mov dh,al
        mov al,VVramWidth | mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,Backup
    pop dx
ret


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    push ax | push bx | push cx | push dx
        mov ch,1 | mov cl,1
        shr al,1
        if c
            inc cl
        endif

        shr dl,1
        if c
            inc ch
        endif

        xchg dl,al
        mov ah,VVramWidth | mul ah
        add ax,Backup
        xor dh,dh
        add ax,dx
        mov bx,ax

        do
            push bx
                mov ah,cl
                do
                    mov byte ptr[bx],0ffh
                    inc bx
                    dec ah
                while nz | wend
            pop bx
            add bx,VVramWidth            
            dec ch
        while nz | wend
    pop dx | pop cx | pop bx | pop ax
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
    push ax | push cx | push dx | push si | push di
        mov dh,al
        mov al,VramWidth*4 | mul dl
        add ax,Vram_
        mov di,ax
        mov al,dh
        shr al,1
        xor ah,ah
        add di,ax

        mov al,cl
        mov ah,8 | mul ah
        add ax,CharPattern
        mov si,ax

        test dh,01h
        if z
            mov cl,7
            do
                mov al,[si] | inc si
                mov ah,[di]
                and ah,01h
                or al,ah
                mov [di],al
                add di,VramWidth
                dec cl
            while nz | wend
        else
            mov cl,7
            do
                mov ah,[si] | inc si
                xor al,al
                shr ax,1 | shr ax,1 | shr ax,1 | shr ax,1
                mov dx,[di]
                xchg dl,dh
                and dx,0001h
                or ax,dx
                xchg al,ah
                mov [di],ax
                add di,VramWidth
                dec cl
            while nz | wend
        endif
    pop di | pop si | pop dx | pop cx | pop ax
ret
