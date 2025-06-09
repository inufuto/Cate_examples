include "ngp.inc"

ext ClearWatchDogTimer_

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

; byte ScanKeys();
cseg
BitTable:
    defb 04h,08h,01h,02h,10h,20h
ScanKeys_: public ScanKeys_
    call ClearWatchDogTimer_
    push bc | push de| push xhl
        xor a,a
        ld e,(ControllerStatus)
        ld xhl,BitTable
        ld bc,0601h
        do
            ld d,e
            and d,(xhl+)
            if nz
                or a,c
            endif
            sll 1,c
        dwnz b
    pop xhl | pop de | pop bc
ret
