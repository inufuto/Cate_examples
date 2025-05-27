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

KeyInt equ 40h+1

dseg
FirstByte:
    defb 0
LastBits:
    defb 0

cseg
InitKeys: public InitKeys
    cli
        mov dx,604h | mov al,01h | out dx,al
        mov al,0fch | out 02h,al

        xor ax,ax | mov es,ax
        mov ax,KeyHandler | mov [es:KeyInt*4],ax
        mov ax,cs | mov [es:KeyInt*4+2],ax

        mov byte ptr[LastBits],0
    sti
ret

KeyTable:
    defb 35h,Keys_Button0 ; Space
    defb 3bh,Keys_Up ; 8
    defb 3eh,Keys_Left ; 4
    defb 40h,Keys_Right; 6
    defb 43h,Keys_Down ; 2
    defb 4dh,Keys_Up ; Up
    defb 4fh,Keys_Left ; Left
    defb 50h,Keys_Down ; Down
    defb 51h,Keys_Right ; Right
    defb 53h, Keys_Button1 ; Shift
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
        mov dx,600h | in al,dx
        test al,80h
        if nz
            mov [FirstByte],al
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
        mov al,20h | out 00h,al ; EOI
    pop dx | pop bx | pop ax
    pop ds
iret

PrinterTable:
    defb not 01h,Keys_Right
    defb not 02h,Keys_Left
    defb not 04h,Keys_Up
    defb not 08h,Keys_Down
    defb not 10h,Keys_Button1
    defb not 20h,Keys_Button0
    defb 0

cseg
ScanKeys_: public ScanKeys_
    mov al,[LastBits]
ret
