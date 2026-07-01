Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

KeyInt equ 09h

dseg
KeyBits:
    defb 0

cseg
InitKeys: public InitKeys
    cli
        xor ax,ax | mov es,ax
        mov ax,KeyHandler | mov [es:KeyInt*4],ax
        mov ax,cs | mov [es:KeyInt*4+2],ax

        mov byte ptr[KeyBits],0
    sti
ret

KeyTable:
    defb 34h, Keys_Button0 ; SPACE
    defb 73h, Keys_Button1 ; GRPH
    defb 3ah, Keys_Up ; Up
    defb 3bh, Keys_Left ; Left
    defb 3ch, Keys_Right ; Right
    defb 3dh, Keys_Down ; Down
    defb 43h, Keys_Up ; 8
    defb 46h, Keys_Left ; 4
    defb 48h, Keys_Right ; 6
    defb 4bh, Keys_Down ; 2
    defb 0
ToBits: ;(al)->al
    mov bx,KeyTable
    do
        mov ah,[bx]
        or ah,ah
    while nz
        inc bx
        cmp al,ah
        if z
            mov al,[bx]
            ret
        endif
        inc bx
    wend
    xor al,al
ret

KeyHandler: public KeyHandler
    sti
    push ds
    push ax | push bx | push cx
        mov ax,cs | mov ds,ax
        
        mov cx,20
        do 
        wloop

        in al,41h
        test al,80h
        if z
            call ToBits
            or [KeyBits],al
        else
            and al,7fh
            call ToBits
            not al
            and [KeyBits],al
        endif

        mov al,20h | out 00h,al ; EOI
    pop cx | pop bx | pop ax
    pop ds
iret


cseg
ScanKeys_: public ScanKeys_
    mov al,[KeyBits]
ret
