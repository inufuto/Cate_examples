Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

    cseg
table:
    defb not $02, $02, Keys_Up    ; I
    defb not $04, $02, Keys_Left  ; J
    defb not $08, $02, Keys_Right ; K
    defb not $08, $08, Keys_Up    ; ↑
    defb not $10, $08, Keys_Down  ; ↓
    defb not $20, $02, Keys_Down  ; M
    defb not $20, $08, Keys_Left  ; ←
    defb not $40, $08, Keys_Right ; →
    defb not $80, $08, Keys_Button0   ; space
    defb not $80, $40, Keys_Button1   ; shift
    defb 0
ScanKeys_: public ScanKeys_
    pshs b,x
        clrb
        
        ldx #table
        do
            lda ,x+
        while ne
            sta $ff02
            lda $ff00
            bita ,x+
            if eq
                orb ,x
            endif
            leax 1,x
        wend

        tfr b,a
    puls b,x
rts
