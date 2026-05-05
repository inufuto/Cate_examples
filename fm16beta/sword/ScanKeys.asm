include "Vram.inc"

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

Keys_Bit_Left equ 0
Keys_Bit_Right equ 1
Keys_Bit_Up equ 2
Keys_Bit_Down equ 3
Keys_Bit_Button0 equ 4
Keys_Bit_Button1 equ 5

KeyInt equ 08h+1

dseg
LastBits:
    defb 0

cseg
InitKeys: public InitKeys
    cli
        xor ax,ax | mov es,ax
        mov ax,KeyHandler | mov [es:KeyInt*4],ax
        mov ax,cs | mov [es:KeyInt*4+2],ax

        mov byte ptr[LastBits],0
    sti
ret

KeyTable:
    defb 53,Keys_Button0 ; Space
    defb 59,Keys_Up ; 8
    defb 62,Keys_Left ; 4
    defb 64,Keys_Right; 6
    defb 67,Keys_Down ; 2
    defb 77,Keys_Up ; Up
    defb 79,Keys_Left ; Left
    defb 80,Keys_Down ; Down
    defb 81,Keys_Right ; Right
    defb 83,Keys_Button1 ; Shift
    defb 84,Keys_Button1 ; Shift
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
        mov dx,0fd01h | in al,dx
                            ; mov [KeyValue_],al
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

        mov al,20h | out 0,al ; EOI
    pop dx | pop bx | pop ax
    pop ds
iret

cseg
ScanKeys_: public ScanKeys_
    mov al,[LastBits]
ret


cseg
Command:
    defb 0,0
    defb 3fh
    defb 'YAMAUCHI'
    defb 94h,01h,90h
InitKeyMode: public InitKeyMode
    mov dx,0fd05h
    do
        in al,dx
        and al,80h
    while nz | wend
    mov al,80h | out dx,al ; hold
    do
        in al,dx
        and al,80h
    while z | wend
    
    mov dx,0fc80h
    mov bx,Command
    mov cl,14
    do
        mov al,[bx] | inc bx
        out dx,al | inc dx
        dec cl
    while nz | wend

    mov dx,0fd05h
    mov al,00h | out dx,al ; release

    mov cx,0
    do
    wloop
ret
