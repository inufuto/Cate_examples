include "Pasogo.inc"

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h
Keys_Break equ 80h


; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    push dx
        mov al,KeyStatusLow | out Vg230Index,al
        xor dl,dl
        defb 0ebh,0, 0ebh,0
        in al,Vg230Data
        test al,01h
        if z
            or dl,Keys_Button0
        endif
        test al,02h
        if z
            or dl,Keys_Button1
        endif
        test al,04h
        if z
            or dl,Keys_Up
        endif
        test al,08h
        if z
            or dl,Keys_Down
        endif
        test al,10h
        if z
            or dl,Keys_Right
        endif
        test al,20h
        if z
            or dl,Keys_Left
        endif
        mov al,dl
    pop dx
ret
