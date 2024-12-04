Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h
Keys_Break equ 80h

; Keys_Bit_Left equ 0
; Keys_Bit_Right equ 1
; Keys_Bit_Up equ 2
; Keys_Bit_Down equ 3
; Keys_Bit_Button0 equ 4
; Keys_Bit_Button1 equ 5

PortA equ 20h
PortB equ 22h
PEMask equ 08h

dseg
LastBits:
    defb 0
JoystickAvailable_:  public JoystickAvailable_
    defb 0

cseg
InitKeys: public InitKeys
    cli
        in al,60h
        mov byte ptr[LastBits],0

        xor al,al
        mov [JoystickAvailable_],al
        not al | out PortA,al
    sti
ret


cseg
KeyTable:
    defb 3,Keys_Down ; 2
    defb 5,Keys_Left ; 4
    defb 7,Keys_Right; 6
    defb 9,Keys_Up ; 8
    defb 38,Keys_Up ; ;
    defb 39,Keys_Up ; :
    defb 49,Keys_Left ; .
    defb 50,Keys_Down ; /
    defb 51,Keys_Right; \
    defb 52,Keys_Button0 ; Space
    defb 55,Keys_Button1 ; Shift
    defb 72,Keys_Left ; Left
    defb 73,Keys_Up ; Up
    defb 74,Keys_Down ; Down
    defb 75,Keys_Right ; Right
    defb 68,Keys_Break ; Break
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
        in al,60h
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
PrinterTable:
    defb not 01h,Keys_Right
    defb not 02h,Keys_Left
    defb not 04h,Keys_Up
    defb not 08h,Keys_Down
    defb not 010h,Keys_Button1
    defb not 020h,Keys_Button0
    defb 0
ScanKeys_: public ScanKeys_
    push dx | push bx
        xor dl,dl

        mov bx,PrinterTable
        do
            mov al,[bx]
            or al,al
        while nz
            inc bx
            out PortA,al
            in al,PortB
            and al,PEMask
            if z
                or dl,[bx]
            endif
            inc bx
        wend
        mov al,dl
        or al,al
        if nz
            mov byte ptr [JoystickAvailable_],1
            jmp ScanKeys_exit
        endif

        cmp byte ptr [JoystickAvailable_],0
        if nz
            xor al,al
            jmp ScanKeys_exit
        endif

        mov al,[LastBits]
        and al,not Keys_Break
        ScanKeys_exit:
    pop bx | pop dx
ret


ScanStop_: public ScanStop_
    mov al,[LastBits]
    and al,Keys_Break
    if nz
        mov al,1
    endif
ret
