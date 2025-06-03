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
    push d
        mvi e,0
        di
            mvi a,1 | call $349
            ani $80 ; /
            if nz
                mov a,e | ori Keys_Down | mov e,a
            endif

            mvi a,2 | call $349
            ani $80 ; .
            if nz
                mov a,e | ori Keys_Left | mov e,a
            endif
                
            mvi a,3 | call $349
            ani $80 ; ;
            if nz
                mov a,e | ori Keys_Up | mov e,a
            endif

            mvi a,5 | call $349
            ani $04 ; Right
            if nz
                mov a,e | ori Keys_Right | mov e,a
            endif

            mvi a,6 | call $349
            mov d,a
            ani $01 ; Space
            if nz
                mov a,e | ori Keys_Button0 | mov e,a
            endif
            mov a,d
            ani $04 ; Left
            if nz
                mov a,e | ori Keys_Left | mov e,a
            endif

            mvi a,7 | call $349
            ani $04 ; Down
            if nz
                mov a,e | ori Keys_Down | mov e,a
            endif

            mvi a,8 | call $349
            mov d,a
            ani $02 ; :
            if nz
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani $04 ; Up
            if nz
                mov a,e | ori Keys_Up | mov e,a
            endif

            mvi a,9 | call $349
            mov d,a
            ani $01 ; Return
            if nz
                mov a,e | ori Keys_Button1 | mov e,a
            endif
            mov a,d
            ani $08 ; \
            if nz
                mov a,e | ori Keys_Right | mov e,a
            endif
        ei
        mov a,e
    pop d
ret


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    di
        mvi a,6 | call $349
        rrc | rrc | rrc | rrc
        ani $01
    ei
ret
