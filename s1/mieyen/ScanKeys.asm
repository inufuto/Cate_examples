Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

dseg
PrevKey_: public PrevKey_
    defb 0
JoystickAvailable_: public JoystickAvailable_
    defb 0

cseg
InitKeys: public InitKeys
    lda $FFEB | anda #not $02 | sta $FFEB
    clr $FE41
    lda #$40 | sta $FE40
    lda #$04 | sta $FE41
    lda $FFEB | ora #$02 | sta $FFEB
rts


cseg
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
        lda $FFEB | anda #not $02 | sta $FFEB
        clr $FE40
        ldb $FE40
        lda $FFEB | ora #$02 | sta $FFEB
        clra
        bitb #$01
        if eq
            ora #Keys_Up
        endif
        bitb #$02
        if eq
            ora #Keys_Down
        endif
        bitb #$04
        if eq
            ora #Keys_Left
        endif
        bitb #$08
        if eq
            ora #Keys_Right
        endif
        bitb #$20
        if eq
            ora #Keys_Button0
        endif
        cmpa #0
        if ne
            ldb #1 | stb JoystickAvailable_
        endif
        
        ldb JoystickAvailable_
        if eq
            ldb $FFE0
            bitb #$80
            if ne
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
                clra
                sta PrevKey_
            else
                lda PrevKey_
            endif
            ScanKeys_exit:
        endif
    puls b,x
rts