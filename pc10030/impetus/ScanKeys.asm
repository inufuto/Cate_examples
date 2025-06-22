Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h
Keys_Button equ Keys_Button0 or Keys_Button1

KeyInt equ 43h


dseg
LastBits:
    defb 0

cseg
InitKeys: public InitKeys
    in al,20h
    cli
        xor ax,ax | mov es,ax
        mov ax,KeyHandler | mov [es:KeyInt*4],ax
        mov ax,cs | mov [es:KeyInt*4+2],ax

        in al,02h
        and al,not 08h
        out 02h,al

        mov byte ptr[LastBits],0
    sti
ret

KeyTable:
    defb 5, Keys_Button1 ; CODE
    defb 74,Keys_Button0 ; Space
    defb 19,Keys_Up ; Up
    defb 20,Keys_Down ; Down
    defb 21,Keys_Left ; Left
    defb 22,Keys_Right ; Right
    defb 80,Keys_Down ; 2
    defb 82,Keys_Left ; 4
    defb 84,Keys_Right; 6
    defb 87,Keys_Up ; 8
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
    push ax | push bx
    push ds
        mov ax,cs | mov ds,ax
    
        in al,20h
        test al,80h
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

        mov al,20h | out 00h,al ; EOI
    pop ds
    pop bx | pop ax
iret


; byte ScanKeys();
ScanKeys_: public ScanKeys_
    mov al,[LastBits]
ret