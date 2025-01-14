ext WritePsg

VIA_IORB equ $300 ; Port B in and out

Psg_IO equ 14

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

cseg
Read:
    ora #$b8
    sta VIA_IORB
    ldx #4
    do
        dex
    while ne | wend
    lda VIA_IORB
    and #8
rts

ScanKeys_: public ScanKeys_
    pha
        ldy #0

        sei
            lda #Psg_IO
            ldx #$fe
            jsr WritePsg
            lda #1; J
            jsr Read
            if ne
                tya
                ora #Keys_Left
                tay                
            endif
            lda #2; M
            jsr Read
            if ne
                tya
                ora #Keys_Down
                tay                
            endif
            lda #3; K
            jsr Read
            if ne
                tya
                ora #Keys_Right
                tay                
            endif
            lda #4; Space
            jsr Read
            if ne
                tya
                ora #Keys_Button0
                tay                
            endif

            lda #Psg_IO
            ldx #$fd
            jsr WritePsg
            lda #4; <
            jsr Read
            if ne
                tya
                ora #Keys_Left
                tay                
            endif
            lda #5; I
            jsr Read
            if ne
                tya
                ora #Keys_Up
                tay                
            endif

            lda #Psg_IO
            ldx #$fb
            jsr WritePsg
            lda #4; >
            jsr Read
            if ne
                tya
                ora #Keys_Right
                tay                
            endif

            lda #Psg_IO
            ldx #$f7
            jsr WritePsg
            lda #4; Up
            jsr Read
            if ne
                tya
                ora #Keys_Up
                tay                
            endif

            lda #Psg_IO
            ldx #$df
            jsr WritePsg
            lda #2; Z
            jsr Read
            if ne
                tya
                ora #Keys_Down
                tay                
            endif
            lda #4; Left
            jsr Read
            if ne
                tya
                ora #Keys_Left
                tay                
            endif
            lda #6; A
            jsr Read
            if ne
                tya
                ora #Keys_Up
                tay                
            endif
            lda #7; Return
            jsr Read
            if ne
                tya
                ora #Keys_Button1
                tay                
            endif

            lda #Psg_IO
            ldx #$bf
            jsr WritePsg
            lda #4; Down
            jsr Read
            if ne
                tya
                ora #Keys_Down
                tay                
            endif

            lda #Psg_IO
            ldx #$7f
            jsr WritePsg
            lda #4; Right
            jsr Read
            if ne
                tya
                ora #Keys_Right
                tay                
            endif
        cli
    pla
rts
