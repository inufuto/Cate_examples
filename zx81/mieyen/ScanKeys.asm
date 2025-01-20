Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

; 6,7,8,9,0 : D,U,R,L,0
; Q,A,O,P,SPACE,ENTER : U,D,L,R,0,1
cseg
ScanKeys_: public ScanKeys_
    push d
        mvi e,0
        
        mvi a,$fe | in $fe | mov d,a
        mov a,d | ani $02 ; Z
        if z
            mov a,e | ori Keys_Button0 | mov e,a
        endif
        mov a,d | ani $04 ; X
        if z
            mov a,e | ori Keys_Button1 | mov e,a
        endif
        mov a,d | ani $01 ; SHIFT
        if z
            mvi a,$f7 | in $fe | mov d,a
            mov a,d | ani $10 ; 5
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif

            mvi a,$ef | in $fe | mov d,a
            mov a,d | ani $04 ; 8
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif
            mov a,d | ani $08 ; 7
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d | ani $10 ; 6
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif
        else
            mvi a,$ef | in $fe | mov d,a
            mov a,d | ani $01 ; 0
            if z
                mov a,e | ori Keys_Button0 | mov e,a
            endif
            mov a,d | ani $02 ; 9
            if z
                mov a,e | ori Keys_Left | mov e,a
            endif
            mov a,d | ani $04 ; 8
            if z
                mov a,e | ori Keys_Right | mov e,a
            endif
            mov a,d | ani $08 ; 7
            if z
                mov a,e | ori Keys_Up | mov e,a
            endif
            mov a,d | ani $10 ; 6
            if z
                mov a,e | ori Keys_Down | mov e,a
            endif
        endif

        mvi a,$fd | in $fe | mov d,a
        mov a,d | ani $01 ; A
        if z
            mov a,e | ori Keys_Down | mov e,a
        endif
        
        mvi a,$fb | in $fe | mov d,a
        mov a,d | ani $01 ; Q
        if z
            mov a,e | ori Keys_Up | mov e,a
        endif

        mvi a,$df | in $fe | mov d,a
        mov a,d | ani $01 ; P
        if z
            mov a,e | ori Keys_Right | mov e,a
        endif
        mov a,d | ani $02 ; O
        if z
            mov a,e | ori Keys_Left | mov e,a
        endif

        mvi a,$bf | in $fe | mov d,a
        mov a,d | ani $01 ; ENTER
        if z
            mov a,e | ori Keys_Button1 | mov e,a
        endif
        mov a,d | ani $04 ; K
        if z
            mov a,e | ori Keys_Up | mov e,a
        endif
        mov a,d | ani $08 ; J
        if z
            mov a,e | ori Keys_Up | mov e,a
        endif

        mvi a,$7f | in $fe | mov d,a
        mov a,d | ani $01 ; SPACE
        if z
            mov a,e | ori Keys_Button0 | mov e,a
        endif
        mov a,d | ani $02 ; .
        if z
            mov a,e | ori Keys_Right | mov e,a
        endif
        mov a,d | ani $04 ; M
        if z
            mov a,e | ori Keys_Down | mov e,a
        endif
        mov a,d | ani $08 ; N
        if z
            mov a,e | ori Keys_Left | mov e,a
        endif

        mov a,e
    pop d
ret
