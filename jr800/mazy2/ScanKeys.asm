Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    pshb
        clra
        
        ldab $0ffe
        bitb #$04 ; Num2
        if eq
            oraa #Keys_Down
        endif
        bitb #$10 ; Num4
        if eq
            oraa #Keys_Left
        endif
        bitb #$40 ; Num6
        if eq
            oraa #Keys_Right
        endif

        ldab $0ffd
        bitb #$01 ; Num8
        if eq
            oraa #Keys_Up
        endif
        
        ldab $0ff7
        bitb #$10 ; ,
        if eq
            oraa #Keys_Down
        endif
        bitb #$40 ; .
        if eq
            oraa #Keys_Right
        endif

        ldab $0fef
        bitb #$01 ; Space
        if eq
            oraa #Keys_Button0
        endif

        ldab $0fdf
        bitb #$08 ; K
        if eq
            oraa #Keys_Up
        endif
        bitb #$10 ; L
        if eq
            oraa #Keys_Up
        endif
        bitb #$20 ; M
        if eq
            oraa #Keys_Left
        endif

        ldab $0f7f
        bitb #$40 ; Return
        if eq
            oraa #Keys_Button1
        endif
    pulb
rts


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    ldaa $0fef
    bita #$08 ; C
    if eq
        ldaa $0dff
        bita #$10
        if eq
            ldaa #1
            rts
        endif
    endif

    ldaa $0f7f
    if pl
        ldaa #1
        rts
    endif
    clra
rts
