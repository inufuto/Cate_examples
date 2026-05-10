include "Model100.inc"

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
            in PORTB | ori 01h | out PORTB

            mvi a,not 01h | out PORTA
            in KEYIN
            ani 80h ; L
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif

            mvi a,not 08h | out PORTA
            in KEYIN
            mov d,a
            ani 08h ; ;
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani 20h ; ,
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d
            ani 40h ; .
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif
            mov a,d
            ani 80h ; /
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif

            mvi a,not 20h | out PORTA
            in KEYIN
            mov d,a
            ani 10h ; Left
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d
            ani 20h ; Right
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif
            mov a,d
            ani 40h ; Up
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d
            ani 80h ; Down
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif

            mvi a,not 40h | out PORTA
            in KEYIN
            ani 01h ; Space
            if z
                mov a,e | ori Keys_Button0 | mov e,a
            endif

            in PORTB | ani not 01h | out PORTB
            mvi a,not 0 | out PORTA
            in KEYIN
            ani 04h ; GRPH
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
        mvi a,not 80h | out PORTA
        in PORTB | ori 01h | out PORTB
        in KEYIN
        ani 80h ; STOP
        if z
            mvi a,1
        else
            xra a
        endif
    ei
ret
