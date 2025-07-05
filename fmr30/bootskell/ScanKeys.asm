Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

KeyInt equ 40h+2

dseg
FirstByte:
    defb 0
LastBits:
    defb 0
kkk_: public kkk_
    defb 0


cseg
InitKeys: public InitKeys
    cli
        mov byte ptr[LastBits],0

        xor ax,ax | mov es,ax
        mov ax,KeyHandler | mov [es:KeyInt*4],ax
        mov ax,cs | mov [es:KeyInt*4+2],ax

        mov dx,009h
        xor al,al
        out dx,al | out dx,al | out dx,al
        mov al,40h | out dx,al
        mov al,7fh | out dx,al
        mov al,16h
        out dx,al | out dx,al | out dx,al
        
        mov dx,00bh | mov al,42h | out dx,al
        mov dx,00ah | mov al,03h | out dx,al

        mov dx,101h | mov al,80h | out dx,al
    sti
ret

KeyTable:
    defb 26h,Keys_Up ; L
    defb 27h,Keys_Up ; ;
    defb 2ah,Keys_Button0 ; Z
    defb 2bh,Keys_Button1 ; X
    defb 31h,Keys_Left ; ,
    defb 32h,Keys_Down ; .
    defb 33h,Keys_Right; /
    defb 4dh,Keys_Up ; Up
    defb 4fh,Keys_Left ; Left
    defb 50h,Keys_Down ; Down
    defb 51h,Keys_Right ; Right
    defb 0
ToBits:
    and al,7fh
    mov bx,KeyTable
    do
        mov ah,[bx]
        or ah,ah
    while nz
        cmp al,ah
        if z
            inc bx
            mov al,[bx]
            jmp ToBits_exit
        endif
        inc bx | inc bx
    wend
    xor al,al
ToBits_exit:
ret

KeyHandler: public KeyHandler
    push ds
    push ax | push bx | push dx
        mov ax,cs | mov ds,ax
                        

        mov dx,08h | in al,dx
        test al,80h
        if nz
            mov [FirstByte],al
                        mov [kkk_],al
        else
            mov ah,[FirstByte]
            cmp ah,0f0h
            if c
                test ah,10h
                if nz
                    call ToBits
                    mov ah,[LastBits]
                    not al
                    and ah,al
                else
                    call ToBits
                    mov ah,[LastBits]
                    or ah,al
                endif
                mov [LastBits],ah
            endif
        endif
        KeyHandler_exit:
        mov dx,100h | mov al,20h | out dx,al ; EOI
    pop dx | pop bx | pop ax
    pop ds
iret


cseg
ScanKeys_: public ScanKeys_
    mov al,[LastBits]
ret
