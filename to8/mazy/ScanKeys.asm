KTST equ $E809
GETC equ $E806

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
    pshs b
        clrb
        
        lda $E7CC
        bita #$04 ;Left
        if eq 
            orb #Keys_Left
        endif
        bita #$08 ;Right
        if eq
            orb #Keys_Right
        endif
        bita #$01 ;Up
        if eq
            orb #Keys_Up
        endif
        bita #$02 ;Down
        if eq
            orb #Keys_Down
        endif

        lda $E7CD
        bita #$40 ;A
        if eq
            orb #Keys_Button0
        endif
        bita #$04 ;B
        if eq
            orb #Keys_Button1
        endif
        tfr b,a
    puls b
rts
