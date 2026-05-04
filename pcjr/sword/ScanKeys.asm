Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

dseg
KeyBits: public KeyBits
    defb 0


cseg
CodeTable:
    defb 38h,Keys_Button1 ; Alt
    defb 39h,Keys_Button0 ; Space
    defb 48h,Keys_Up ; Up
    defb 4bh,Keys_Left ; Left
    defb 4dh,Keys_Right ; Right
    defb 50h,Keys_Down ; Down
    defb 0
KeyHandler: public KeyHandler
    push ax | push bx | push dx | push ds
        mov ax,cs | mov ds,ax
        in al,60h | mov dh,al
            
        and al,7fh
        mov bx,CodeTable
        do
            mov ah,[bx] | inc bx
            or ah,ah
        while nz
            cmp al,ah
            if z
                mov dl,[bx]
                jmp KeyHandler_break
            endif
            inc bx
        wend
        xor dl,dl
        KeyHandler_break:
        mov al,[KeyBits]
        test dh,80h
        if z
            or al,dl
        else
            not dl
            and al,dl
        endif
        mov [KeyBits],al
    pop ds | pop dx | pop bx | pop ax
iret


cseg
ScanKeys_: public ScanKeys_
    mov al,[KeyBits]
ret
