Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

Port_FM_Command equ $FD15
Port_FM_Data equ $FD16

    dseg
JoystickAvailable_:  public JoystickAvailable_
    defb 0
    
    cseg
PrinterTable:
    defb $fe,Keys_Right
    defb $fd,Keys_Left
    defb $fb,Keys_Up
    defb $f7,Keys_Down
    defb $ef,Keys_Button1
    defb $df,Keys_Button0
    defb 0

ReadPrinterPort:
    ldx #PrinterTable
    do
        lda ,x+
    while ne
        sta $FD01
        lda $FD02
        bita #$08
        if eq
            orb ,x
        endif
        leax 1,x
    wend
rts


WriteRegister:
    pshs cc | orcc #$50
        stb Port_FM_Data
        pshs b
            ldb #3
            stb Port_FM_Command
            clr Port_FM_Command

            sta Port_FM_Data
            ldb #2
            stb Port_FM_Command
            clr Port_FM_Command
        puls b
    puls cc
rts

ReadRegister:
    pshs cc | orcc #$50
        stb Port_FM_Data
        pshs b
            ldb #3
            stb Port_FM_Command
            clr Port_FM_Command

            ldb #9
            stb Port_FM_Command
            lda Port_FM_Data
            clr Port_FM_Command
        puls b
    puls cc
rts

FMTable:
    defb 1,Keys_Up
    defb 2,Keys_Down
    defb 4,Keys_Left
    defb 8,Keys_Right
    defb 16,Keys_Button0
    defb 32,Keys_Button1
    defb 0
ReadFM:
    ldd #$2f0f
    bsr WriteRegister
    ldb #14
    bsr ReadRegister
    
    clrb
    ldx #FMTable
    do
        tst ,x
    while ne
        bita ,x+
        if eq
            orb ,x
        endif
        leax 1,x
    wend
rts


KeyTable:
    defb $09,Keys_Button1 
    defb ' ',Keys_Button0 
    defb '1',Keys_Down or Keys_Left
    defb '2',Keys_Down
    defb '3',Keys_Down or Keys_Right
    defb '4',Keys_Left
    defb '6',Keys_Right
    defb '7',Keys_Button0 or Keys_Left
    defb '8',Keys_Up
    defb '9',Keys_Button0 or Keys_Right
    defb $1C,Keys_Right
    defb $1D,Keys_Left
    defb $1E,Keys_Up
    defb $1F,Keys_Down
    defb 'z',Keys_Button0 or Keys_Left
    defb 'x',Keys_Button0 or Keys_Right
    defb 'Z',Keys_Button0 or Keys_Left
    defb 'X',Keys_Button0 or Keys_Right
    defb 0

ScanKeys_: public ScanKeys_
    pshs b,x
        clrb
        bsr ReadPrinterPort
        tfr b,a
        tsta
        if ne
            ldb #1
            stb JoystickAvailable_
            bra ScanKeys_exit
        else
            bsr ReadFM        
            tfr b,a
            tsta
            if ne
                ldb #1
                stb JoystickAvailable_
                bra ScanKeys_exit
            endif
        endif

        tst JoystickAvailable_
        if eq
            ldb $FD01
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
