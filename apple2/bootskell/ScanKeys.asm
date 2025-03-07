include "apple2.inc"
include "ZeroPage.inc"

ZB0 equ Zp.Byte

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

dseg
Stick0_: public Stick0_
    defb 0
Stick1_: public Stick1_
    defb 0
stickIndex: public stickIndex
    defb 0

cseg
ReadStick_: public ReadStick_
    pha
        lda stickIndex
        if eq
            ldx #0
            jsr PREAD
            sty Stick0_
            lda #1
        else
            ldx #1
            jsr PREAD
            sty Stick1_
            lda #0
        endif            
        sta stickIndex
    pla
rts

cseg
ScanKeys_: public ScanKeys_
    pha
        jsr ReadStick_

        lda #0
        sta <ZB0

        lda Stick0_
        cmp #$20
        if cc
            lda <ZB0
            ora #Keys_Left
            sta <ZB0
        else
            cmp #$e0
            if cs
                lda <ZB0
                ora #Keys_Right
                sta <ZB0
            endif
        endif

        lda Stick1_
        cmp #$20
        if cc
            lda <ZB0
            ora #Keys_Up
            sta <ZB0
        else
            cmp #$e0
            if cs
                lda <ZB0
                ora #Keys_Down
                sta <ZB0
            endif
        endif

        lda PB0
        and #$80
        if ne
            lda <ZB0
            ora #Keys_Button0
            sta <ZB0
        endif

        lda PB1
        and #$80
        if ne
            lda <ZB0
            ora #Keys_Button1
            sta <ZB0
        endif
        ldy <ZB0

        ; tya | and #$f0
        ; if eq
        ;     lda $c000
        ;     ldx #0
        ;     do
        ;         cmp KeyTable,x
        ;         if eq
        ;             inx
        ;             lda KeyTable,x | tay
        ;             jmp key_exit
        ;         endif
        ;         inx | inx
        ;         cpx #12
        ;     while ne | wend
        ; endif
        ; key_exit:
    pla
rts

; KeyTable:
;     defb $a0,Keys_Button0
;     defb $ac,Keys_Left
;     defb $af,Keys_Right
;     defb $ae,Keys_Down
;     defb $cc,Keys_Up
;     defb $bb,Keys_Up
