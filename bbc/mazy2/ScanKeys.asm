Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

dseg
row:
    defb 0
bits:
    defb 0

; byte ScanKeys();
cseg
Table:
    defb $00,Keys_Button1 ; Shift
    defb $19,Keys_Left ; Left
    defb $25,Keys_Up ; I
    defb $29,Keys_Down ; Down
    defb $39,Keys_Up ; Up
    defb $42,Keys_Right ; X
    defb $45,Keys_Left ; J
    defb $46,Keys_Right ; K
    defb $48,Keys_Up ; *
    defb $49,Keys_Button0 ; Return
    defb $61,Keys_Left ; Z
    defb $62,Keys_Button0 ; Space
    defb $65,Keys_Down ; M
    defb $68,Keys_Down ; ?
    defb $79,Keys_Right ; Right
    defb $ff
ScanKeys_: public ScanKeys_
    ldy #0
    sei
        lda #$7f | sta $fe43
        lda #$03 | sta $fe40
        ldx #0
        do
            lda Table,x
            cmp #$ff
        while ne
            inx
            sta $fe4f | lda $fe4f
            and #$80
            if ne
                tya | ora Table,x | tay
            endif
            inx
        wend
        lda #$0b | sta $fe40
    cli
    tya
rts
