include "wsc.inc"

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    push cx
        mov ch,ah
        xor cl,cl

        mov al,20h | out REG_KEYPAD,al
        xchg ax,ax | xchg ax,ax | xchg ax,ax | xchg ax,ax
        in al,REG_KEYPAD
        test al,01h
        if nz
            or cl,Keys_Up
        endif
        test al,02h
        if nz
            or cl,Keys_Right
        endif        
        test al,04h
        if nz
            or cl,Keys_Down
        endif
        test al,08h
        if nz
            or cl,Keys_Left
        endif

        mov al,40h | out REG_KEYPAD,al
        xchg ax,ax | xchg ax,ax | xchg ax,ax | xchg ax,ax
        in al,REG_KEYPAD
        test al,06h
        if nz
            or cl,Keys_Button0
        endif
        test al,08h
        if nz
            or cl,Keys_Button1
        endif        

        mov al,cl
        mov ah,ch
    pop cx
ret
