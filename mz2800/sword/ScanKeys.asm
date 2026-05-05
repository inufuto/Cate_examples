Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

PortABits equ 90h
PortA equ 0e8h
PortB equ 0eah
JoystickPort equ 0efh

cseg
ScanKeys_: public ScanKeys_
    push cx | push dx
        xor dl,dl

        mov al,PortABits or 1
        call OutIn
        test al,04h ;8
        if z
            or dl,Keys_Up
        endif

        mov al,PortABits or 2
        call OutIn
        test al,04h ;2
        if z
            or dl,Keys_Down
        endif
        test al,10h ;4
        if z
            or dl,Keys_Left
        endif
        test al,40h ;6
        if z
            or dl,Keys_Right
        endif

        mov al,PortABits or 3
        call OutIn
        test al,02h ;space
        if z
            or dl,Keys_Button0
        endif
        test al,08h ;up
        if z
            or dl,Keys_Up
        endif
        test al,10h ;down
        if z
            or dl,Keys_Down
        endif
        test al,20h ;left
        if z
            or dl,Keys_Left
        endif
        test al,40h ;right
        if z
            or dl,Keys_Right
        endif

        mov al,PortABits or 11
        call OutIn
        test al,01h ;GRPH
        if z
            or dl,Keys_Button1
        endif

        in al,JoystickPort
        test al,01h ; up
        if z
            or dl,Keys_Up
        endif
        test al,02h    ; down
        if z
            or dl,Keys_Down
        endif
        test al,04h ; left
        if z
            or dl,Keys_Left
        endif
        test al,08h ; right
        if z
            or dl,Keys_Right
        endif
        test al,10h    ; A
        if z
            or dl,Keys_Button0
        endif
        test al,20h    ; B
        if z
            or dl,Keys_Button1
        endif

        mov al,dl
    pop dx | pop cx
ret
OutIn:
    out PortA,al
    mov cx,4 | do | wloop
    in al,PortB
ret
