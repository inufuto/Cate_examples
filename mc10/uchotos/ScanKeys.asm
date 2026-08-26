Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

    cseg
table:
    defb not $02, $01, Keys_Left  ; A
    defb not $04, $08, Keys_Down  ; Z
    defb not $08, $04, Keys_Right ; S
    defb not $08, $08, Keys_Up    ; ↑
    defb not $08, $20, Keys_Up    ; ;
    defb not $10, $02, Keys_Up    ; L
    defb not $10, $08, Keys_Down  ; ↓
    defb not $10, $20, Keys_Left  ; ,
    defb not $20, $08, Keys_Left  ; ←
    defb not $40, $08, Keys_Right ; →
    defb not $40, $20, Keys_Down  ; .
    defb not $80, $04, Keys_Up    ; W
    defb not $80, $08, Keys_Button0   ; space
    defb not $80, $20, Keys_Right ; /
    defb 0
ScanKeys_: public ScanKeys_
    pshb
        clrb
        
        ldx #table
        do
            ldaa 0,x
        while ne
            inx
            staa <$02
            ldaa $bfff
            bita 0,x
            if eq
                orab 1,x
            endif
            inx
            inx
        wend

        ; ldaa #not $80
        ; staa <$02
        ldaa <$03
        bita #$02 ; shift
        if eq
            orab #Keys_Button1
        endif

        tba
    pulb
rts
