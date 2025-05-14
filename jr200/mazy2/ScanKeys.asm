Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20
KeyTableCount equ 4+2+4+4
    cseg
KeyTable:
    defb $1c,Keys_Right, $1d,Keys_Left, $1e,Keys_Up, $1f,Keys_Down
    defb ' ',Keys_Button0, $0d, Keys_Button1
    defb 'i',Keys_Up, 'j',Keys_Left, 'k',Keys_Right, 'm',Keys_Down
    defb 'u',Keys_Button0 or Keys_Left, 'o',Keys_Button0 or Keys_Right
    defb 'z',Keys_Button0 or Keys_Left, 'x',Keys_Button0 or Keys_Right
ScanKeys_: public ScanKeys_
    pshb
        jsr $E8CB
        ldaa 1
        ldx #KeyTable
        ldab #KeyTableCount
        do
            cmpa 0,x
            if eq
                ldaa 1,x
                bra ScanKeys_exit
            endif
            inx
            inx
            decb
        while ne | wend

        clrb
        ldaa 2
        bita #$01
        if eq
            orab #Keys_Up
        endif
        bita #$02
        if eq
            orab #Keys_Down
        endif
        bita #$04
        if eq
            orab #Keys_Left
        endif
        bita #$08
        if eq 
            orab #Keys_Right
        endif
        bita #$10
        if eq
            orab #Keys_Button0
        endif
        tba
        ScanKeys_exit:
    pulb
rts

ScanStop_: public ScanStop_
    ldaa #1
    cmpa #3
    if eq
        ldaa #1
    else
        clra
    endif
rts
