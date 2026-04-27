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

        ldab #2 | stab <$02
        ; oim #2,2 | aim #not 1,2
        ldab <$03
        bitb #$02
        if eq
            oraa #Keys_Button0
        endif
        bitb #$04
        if eq
            oraa #Keys_Button1
        endif

        ldab #1 | stab <$02 
        ; oim #1,2 | aim #not 2,2
        ldab <$03
        bitb #$02
        if eq
            oraa #Keys_Up
        endif
        bitb #$04
        if eq
            oraa #Keys_Down
        endif
        bitb #$08
        if eq
            oraa #Keys_Left
        endif
        bitb #$10
        if eq
            oraa #Keys_Right
        endif
    pulb
rts
