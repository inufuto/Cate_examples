include "GameCom.inc"

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

Count equ 10

dseg
P0Value:
    defb 0

cseg
InitKeys: public InitKeys
    mov r P0C,00h
    mov r P1C,0fch
    mov r P2C,0ffh
    mov r P3C,0a2h

    mov r0,0ffh | mov @P0Value,r0
ret


; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    push r0
        push r P2_
            mov P2,7fh
            mov r0,10
            do
                nop | nop | nop
            dwnz r0
            mov r0,P0
            mov @P0Value,r0
        pop r P2_

        clr r1
        mov r0,@P0Value
        if bc,r0,0
            bset r1,Keys_Bit_Up
        endif
        if bc,r0,1
            bset r1,Keys_Bit_Down
        endif
        if bc,r0,2
            bset r1,Keys_Bit_Left
        endif
        if bc,r0,3
            bset r1,Keys_Bit_Right
        endif
        if bc,r0,7
            bset r1,Keys_Bit_Button0
        endif
        mov r0,P1
        if bc,r0,0
            bset r1,Keys_Bit_Button1
        endif
    pop r0
ret


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    mov r1,@P0Value
    and r1,30h ; PAUSE & MENU
    if z
        push r0 | push r2
            mov r2,Count
            do
                call ScanKeys_
                mov r0,@P0Value
                and r0,30h ; PAUSE & MENU
                if nz
                    clr r1            
                    br t,ScanStop_break
                endif
                dec r2
            while nz|wend
            ScanStop_break:
            mov r1,1
        pop r2 | pop r0
    else
        clr r1
    endif
ret


; byte ScanKeysWait();
ScanKeysWait_: public ScanKeysWait_
    push r0 | push r2
        mov r2,Count
        do
            call ScanKeys_
            or r1,r1
            br z,ScanKeysWait_off
            dec r2
        while nz|wend
        ScanKeysWait_off:
    pop r2 | pop r0
ret