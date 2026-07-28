Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

cseg
ScanKeys_: public ScanKeys_
    push b
        ; di
            xra a,a
            ex
                mvi a,2 | mov pa,a
            ex
            oni pb,$01 | ori a,Keys_Left
            oni pb,$02 | ori a,Keys_Up
            oni pb,$04 | ori a,Keys_Button0

            ex
                mvi a,1 | mov pa,a
            ex
            oni pb,$01 | ori a,Keys_Down
            oni pb,$02 | ori a,Keys_Right
            oni pb,$04 | ori a,Keys_Button1

            ex
                xra a,a | mov pa,a
            ex
        ; ei
    pop b
ret
