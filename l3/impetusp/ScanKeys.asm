Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

dseg
KeyCode:
    defb 0

cseg
KeyHandler: public KeyHandler
    pshs a
        lda $FFE0
        if mi
            sta KeyCode
        endif
    puls a
rts

KeyTable:
    defb $80,Keys_Button0 
    defb $81,Keys_Up
    defb $83,Keys_Left
    defb $84,Keys_Down
    defb $85,Keys_Right
    defb $87,Keys_Button1
    defb $9d,Keys_Button0 or Keys_Left
    defb $8d,Keys_Up
    defb $8e,Keys_Button0 or Keys_Right
    defb $b7,Keys_Left
    defb $be,Keys_Right
    defb $c7,Keys_Down or Keys_Left
    defb $c8,Keys_Button0 or Keys_Left
    defb $ca,Keys_Button0 or Keys_Right
    defb $cd,Keys_Down
    defb $ce,Keys_Down or Keys_Right
    defb 0

ScanKeys_: public ScanKeys_
    pshs b,x
        ; ldb $FFE0
        ldb KeyCode
        if mi
            ldx #KeyTable
            do
                lda ,x
            while ne
                cmpb ,x
                if eq
                    lda 1,x
                    bra ScanKeys_exit
                endif
                leax 2,x
            wend
        endif
        clra
ScanKeys_exit:
    puls b,x
rts