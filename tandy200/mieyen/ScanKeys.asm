ext TimerRate

ScanPort equ $ef
PortA equ $b1
PortB equ $b2

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

cseg
ScanKeys_: public ScanKeys_
    push d
        mvi e,0
        di
            in PortB | ori $01 | out PortB

            mvi a,not $01 | out PortA
            in ScanPort
            mov d,a
            ani $80 ; L
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani $01 ; Z
            if z
                mvi a,5 | sta TimerRate+1
            endif

            mvi a,not $08 | out PortA
            in ScanPort
            mov d,a
            ani $08 ; ;
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani $20 ; ,
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d
            ani $40 ; .
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif
            mov a,d
            ani $80 ; /
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif

            mvi a,not $20 | out PortA
            in ScanPort
            mov d,a
            ani $10 ; Left
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d
            ani $20 ; Right
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif
            mov a,d
            ani $40 ; Up
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani $80 ; Down
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif

            mvi a,not $40 | out PortA
            in ScanPort
            ani $01 ; Space
            if z
                mov a,e | ori Keys_Button0 | mov e,a
            endif

            in PortB | ani not $01 | out PortB
            mvi a,not 0 | out PortA
            in ScanPort
            ani $04 ; GRPH
            if z
                mov a,e | ori Keys_Button1 | mov e,a
            endif
        ei
        mov a,e
    pop d
ret


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    di
        in PortB | ani not $01 | out PortB
        mvi a,not $00 | out PortA
        in ScanPort
        ani $82 ; CTRL+PAUSE
        if z
            mvi a,1
        else
            xra a
        endif
    ei
ret
