Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

; dseg
; JoystickAvailable_: public JoystickAvailable_
;     defb 0
; jjj_: public jjj_
;     defb 0

cseg
; InitJoystick: public InitJoystick
;     psha
;         ldaa $cc02 | staa jjj_
;         anda #$ff
;         if ne
;             ldaa #1
;         else
;             clra
;         endif
;         staa JoystickAvailable_
;     pula
; rts


cseg
ScanKeys_:
    public ScanKeys_
    pshb
        clrb

        ldaa $cc02
        cmpa #$ff
        if ne
            bita #$01
            if ne
                orab #Keys_Right
            endif
            bita #$02
            if ne
                orab #Keys_Left
            endif
            bita #$04
            if ne
                orab #Keys_Up
            endif
            bita #$08
            if ne
                orab #Keys_Down
            endif
            bita #$10
            if ne
                orab #Keys_Button0
            endif
        endif

        clra
        staa $c801
        ldaa $c800
        bita #$04   ;Z
        if eq
            orab #Keys_Button0
        endif
        bita #08    ;X
        if eq
            orab #Keys_Button1
        endif

        ldaa #6
        staa $c801
        ldaa $c800
        bita #$04   ;K
        if eq
            orab #Keys_Up
        endif
        bita #$08   ;L
        if eq
            orab #Keys_Up
        endif
        ldaa #7
        staa $c801
        ldaa $c800
        bita #$08   ;M
        if eq
            orab #Keys_Left
        endif
        bita #$10   ;,
        if eq
            orab #Keys_Down
        endif
        ldaa #8
        staa $c801
        ldaa $c800
        bita #$01   ;,
        if eq
            orab #Keys_Right
        endif

        tba
    pulb
rts

ScanStop_:
    public ScanStop_
    clra
    staa $c801
    ldaa $c800
    bita #$11
    if eq
        ldaa #1
    else
        clra    
    endif
rts
