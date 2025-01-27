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
        sei
            ldab #not $02 | stab $20
            ldab $22
            bitb #$08 ; ;
            if eq
                oraa #Keys_Up
            endif
            bitb #$10 ; ,
            if eq
                oraa #Keys_Left
            endif
            bitb #$40 ; .
            if eq
                oraa #Keys_Down
            endif
            bitb #$80 ; /
            if eq
                oraa #Keys_Right
            endif

            ldab #not $08 | stab $20
            ldab $22
            bitb #$02 ; I
            if eq
                oraa #Keys_Up
            endif
            bitb #$04 ; J
            if eq
                oraa #Keys_Left
            endif
            bitb #$08 ; K
            if eq
                oraa #Keys_Right
            endif
            bitb #$10 ; L
            if eq
                oraa #Keys_Up
            endif
            bitb #$20 ; M
            if eq
                oraa #Keys_Down
            endif

            ldab #not $20 | stab $20
            ldab $28
            bitb #$02 ; Shift
            if eq
                oraa #Keys_Button1
            endif

            ldab #not $40 | stab $20
            ldab $22
            bitb #$02 ; Space
            if eq
                oraa #Keys_Button0
            endif
        cli
    pulb
rts


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    pshb
        clra
        sei
            ldab #not $80  | stab $20
            ldab $22
            bitb #$04
            if eq
                inca
            endif
        cli
    pulb
rts
