Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

ext WriteSound, ReadSound

dseg
PrevKey:
    defb 0

cseg
FMTable:
    defb 1,Keys_Up
    defb 2,Keys_Down
    defb 4,Keys_Left
    defb 8,Keys_Right
    defb 16,Keys_Button0
    defb 32,Keys_Button1
    defb 0
ReadFM:
    ldd #$0f2f
    jsr WriteSound
    lda #14
    jsr ReadSound
    
    clrb
    ldx #FMTable
    do
        tst,x
    while ne
        bita,x+
        if eq
            orb,x
        endif
        leax 1,x
    wend
rts


KeyTable:
    defb $10,Keys_Button1 
    defb $57,Keys_Button0
    defb $58,Keys_Button0
    defb $35,Keys_Button0
    defb $42,Keys_Down or Keys_Left
    defb $43,Keys_Down
    defb $44,Keys_Down or Keys_Right
    defb $3e,Keys_Left
    defb $40,Keys_Right
    defb $3a,Keys_Up or Keys_Left
    defb $3b,Keys_Up
    defb $3c,Keys_Up or Keys_Right
    defb $51,Keys_Right
    defb $4f,Keys_Left
    defb $4d,Keys_Up
    defb $50,Keys_Down
    defb 0

ScanKeys_: public ScanKeys_
    pshs b,x
        clrb
        bsr ReadFM        
        tfr b,a
        tsta
        bne ScanKeys_exit
        
        ldb $FD01
        bitb #$80
        if ne
            andb #$7f
            cmpb PrevKey
            beq ScanKeys_off
        endif
        stb PrevKey
        ldx #KeyTable
        do
            lda,x
        while ne
            cmpb,x
            if eq
                lda 1,x
                bra ScanKeys_exit
            endif
            leax 2,x
        wend
ScanKeys_off:
        clra
ScanKeys_exit:
    puls b,x
rts
