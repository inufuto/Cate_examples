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

cseg
ScanKeys_: public ScanKeys_
    push cx
        mov ch,ah
        mov cl,0
        
        ; mov ah,3
        ; int 18h

        mov ax,0406h
        int 18h
        test ah,10h ; Space
        if nz
            or cl,Keys_Button0
        endif

        mov ax,0407h
        int 18h
        test ah,20h ; Down
        if nz
            or cl,Keys_Down
        endif
        test ah,10h ; Right
        if nz
            or cl,Keys_Right
        endif
        test ah,08h ; Left
        if nz
            or cl,Keys_Left
        endif
        test ah,04h ; Up
        if nz
            or cl,Keys_Up
        endif

        mov ax,0408h
        int 18h
        test ah,40h ; 4
        if nz
            or cl,Keys_Left
        endif
        test ah,08h ; 8
        if nz
            or cl,Keys_Up
        endif

        mov ax,0409h
        int 18h
        test ah,08h ; 2
        if nz
            or cl,Keys_Down
        endif
        test ah,01h ; 6
        if nz
            or cl,Keys_Right
        endif

        mov ax,040eh
        int 18h
        test ah,08h ; GRPH
        if nz
            or cl,Keys_Button1
        endif

        mov al,cl
        mov ah,ch
    pop cx
ret
