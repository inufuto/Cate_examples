Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h
Keys_Button equ Keys_Button0 or Keys_Button1


KeyInt equ 43h

PortA equ 10h
PortB equ 11h
PortC equ 12h
PortCtrl equ 13h
PEMask equ 02h
DKMask equ 08h
SRKMask equ 10h
DCBit equ 0
DCOn equ (DCBit shl 1) or 1
DCOff equ (DCBit shl 1) or 0
STCBit equ 1
STCOn equ (STCBit shl 1) or 1
STCOff equ (STCBit shl 1) or 0

dseg
LastKey:
    defb 0
LastDir:
    defb 0
JoystickAvailable_:  public JoystickAvailable_
    defb 0


cseg
InitKeys: public InitKeys
    cli
        xor ax,ax | mov es,ax
        mov ax,KeyHandler | mov [es:KeyInt*4],ax
        mov ax,cs | mov [es:KeyInt*4+2],ax

        xor al,al | out 13h,al
        mov [LastKey],al
        mov [LastDir],al
        mov [JoystickAvailable_],al
        not al | out PortA,al

        in al,32h
        and al,not 08h
        out 32h,al
    sti
ret


WaitALittle:
    mov cl,20
    do
        dec cl
    while nz | wend
ret
RcvBitAH:
    mov al,STCOn | out PortCtrl,al
    call WaitALittle
    in al,PortB
    and al,DKMask
    mov ah,al
    shr ah,1 | shr ah,1 | shr ah,1
    mov al,STCOff | out PortCtrl,al
    xor dh,ah
ret
KeyTable:
    defb 09h,Keys_Button1 ; Tab
    defb ' ',Keys_Button0 
    defb 0f1h,Keys_Down or Keys_Left ; 1
    defb 0f2h,Keys_Down
    defb 0f3h,Keys_Down or Keys_Right
    defb 0f4h,Keys_Left
    defb 0f6h,Keys_Right
    defb 0f7h,Keys_Up or Keys_Left
    defb 0f8h,Keys_Up
    defb 0f9h,Keys_Up or Keys_Right
    defb 1eh,Keys_Right
    defb 1fh,Keys_Left
    defb 1ch,Keys_Up
    defb 1dh,Keys_Down
    ; defb 'z',Keys_Button0 or Keys_Left
    ; defb 'x',Keys_Button0 or Keys_Right
    ; defb 'Z',Keys_Button0 or Keys_Left
    ; defb 'X',Keys_Button0 or Keys_Right
    defb 0
KeyHandler: public KeyHandler
    push ax | push bx | push cx | push dx
    push ds
        mov ax,cs | mov ds,ax

        in al,PortB
        and al,DKMask
        if nz
            xor dx,dx
            mov ch,9
            do
                call RcvBitAH ; code
                shl dl,1
                or dl,ah
                dec ch
            while nz | wend
            call RcvBitAH ; Parity
            mov al,dh | or al,DCOff | out PortCtrl,al
            mov al,STCOn | out PortCtrl,al
            call WaitALittle
            mov al,STCOff | out PortCtrl,al
            
            mov bx,KeyTable
            do
                mov al,[bx]
                or al,al
            while nz
                cmp al,dl
                if z
                    inc bx
                    mov al,[bx]
                    jmp KeyHandler_exit
                endif
                inc bx | inc bx
            wend
            xor al,al
            KeyHandler_exit:
            mov [LastKey],al
        endif
        mov al,20h | out 30h,al ; EOI
    pop ds
    pop dx | pop cx | pop bx | pop ax
iret


PrinterTable:
    defb 01h,Keys_Right
    defb 02h,Keys_Left
    defb 04h,Keys_Up
    defb 08h,Keys_Down
    defb 010h,Keys_Button1
    defb 020h,Keys_Button0
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
            if nz
                or dl,[bx]
            endif
            inc bx
        wend
        mov al,dl
        or al,al
        if nz
            mov dl,1
            mov [JoystickAvailable_],dl
            jmp ScanKeys_exit
        endif

        mov al,[JoystickAvailable_]
        or al,al
        if nz
            xor al,al
            jmp ScanKeys_exit
        endif

        mov al,[LastKey]
        test al,Keys_Button
        if nz
            mov dl,[LastDir]
            mov [LastKey],dl
            or al,dl
            jmp ScanKeys_exit
        endif
        test al,Keys_Dir
        if nz
            mov [LastDir],al
            jmp ScanKeys_exit
        endif
        xor al,al
        ScanKeys_exit:
    pop bx | pop dx
ret
