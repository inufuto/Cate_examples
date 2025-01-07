Port_KeyScan equ $eec0
Port_Sound equ $ee80

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

    cseg

ScanKeys_:
    public ScanKeys_
    pshb
        clrb

        ldaa #$80
        staa Port_KeyScan
        ldaa Port_KeyScan
        bita #$01 ; Z
        if eq
            orab #Keys_Button1
        endif

        ldaa #$86
        staa Port_KeyScan
        ldaa Port_KeyScan
        bita #$01 ; M
        if eq
            orab #Keys_Down
        endif
        bita #$02 ; J
        if eq
            orab #Keys_Left
        endif
        
        ldaa #$87
        staa Port_KeyScan
        ldaa Port_KeyScan
        bita #$02 ; K
        if eq
            orab #Keys_Right
        endif
        bita #$04 ; I
        if eq
            orab #Keys_Up
        endif

        ldaa #$88
        staa Port_KeyScan
        ldaa Port_KeyScan
        bita #$01 ; .
        if eq
            orab #Keys_Left
        endif

        ldaa #$89
        staa Port_KeyScan
        ldaa Port_KeyScan
        bita #$01 ; /
        if eq
            orab #Keys_Down
        endif
        bita #$02 ; ;
        if eq
            orab #Keys_Up
        endif

        ldaa #$8a
        staa Port_KeyScan
        ldaa Port_KeyScan
        bita #$01 ; _
        if eq
            orab #Keys_Right
        endif
        bita #$02 ; :
        if eq
            orab #Keys_Up
        endif

        ldaa #$8b
        staa Port_KeyScan
        ldaa Port_KeyScan
        bita #$01 ; Space
        if eq
            orab #Keys_Button0
        endif

        tba
    pulb
rts

ScanStop_:
    public ScanStop_
    ldaa #$82
    staa Port_KeyScan
    ldaa Port_KeyScan
    bita #$11
    if eq
        ldaa #1
    else
        clra
    endif
rts
