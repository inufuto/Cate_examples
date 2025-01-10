Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ Keys_Left or Keys_Right or Keys_Up or Keys_Down
Keys_Button0 equ $10
Keys_Button1 equ $20
Keys_Button equ Keys_Button0 or Keys_Button1

PaperEmpty equ $08

dseg
DirBits:
    defb 0
ButtonBits:
    defb 0
JoystickAvailable_:  public JoystickAvailable_
    defb 0


cseg
InitKey: public InitKey
    clr JoystickAvailable_
    clr DirBits
    clr ButtonBits
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
KeyHandler: public KeyHandler
    pshs x
        ldx #KeyTable
        do
            tst ,x
        while ne
            cmpa ,x
            if eq
                lda 1,x
                clr DirBits ; option (avoid on shooting game)
                bra KeyHandler_match
            endif
            leax 2,x
        wend
        clra
        KeyHandler_match:
        tfr a,b
        anda #Keys_Button
        if ne
            ora ButtonBits
            sta ButtonBits
            bra KeyHandler_skip
        endif
        andb #Keys_Dir
        stb DirBits
        KeyHandler_skip:
    puls x
rts


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
        bita #PaperEmpty
        if eq
            orb ,x
        endif
        leax 1,x
    wend
rts


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
        endif

        tst JoystickAvailable_
        if eq
            lda ButtonBits
            ora DirBits
            clr ButtonBits
            tsta
            bne ScanKeys_exit
        endif
        clra
ScanKeys_exit:
    puls b,x
rts
