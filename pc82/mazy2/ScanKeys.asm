include "pc82.inc"

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
            mvi a,not $08 | out PORTA
            in PORTB | ori $01 | out PORTB
            in KEYIN
            mov d,a
            ani $10 ; ,
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d
            ani $20 ; .
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif
            mov a,d
            ani $40 ; /
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif

            mvi a,not $20 | out PORTA
            in KEYIN
            mov d,a
            ani $04 ; ;
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani $20 ; SPACE
            if z
                mov a,e | ori Keys_Button0 | mov e,a
            endif

            mvi a,not $40 | out PORTA
            in KEYIN
            mov d,a
            ani $01 ; Up
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani $02 ; Down
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif
            mov a,d
            ani $04 ; Left
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d
            ani $08 ; Right
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif

            mvi a,not 0 | out PORTA
            in PORTB | ani $fe | out PORTB
            in KEYIN
            mov d,a
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
        mvi a,not $80 | out PORTA
        in PORTB | ori $01 | out PORTB
        in KEYIN
        ani $80 ; STOP
        if z
            mvi a,1
        else
            xra a
        endif
    ei
ret
