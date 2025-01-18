include "Apple2.inc"
include "ZeroPage.inc"

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
stickIndex:
    defb 0

cseg
Read:
    a8 | i8
    do
        lda PADDL0,x
    while mi | wend
    sei
        lda PTRIG
        ldy #0
        nop | nop | nop | nop
        do
            lda PADDL0,x
            bpl Read_break
            iny
            nop | nop | nop | nop
            nop | nop | nop | nop
        while ne | wend
        dey
        Read_break:
    cli
rts
ReadStick:
    lda stickIndex
    if eq
        ldx #0
        jsr Read
        sty Stick0_
        lda #1
    else
        ldx #1
        jsr Read
        sty Stick1_
        lda #0
    endif            
    sta stickIndex
rts
ReadStick_: public ReadStick_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            jsr ReadStick
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts


cseg
ScanKeys_: public ScanKeys_
    php
        rep #$10 | i16
        phx | phy
            sep #$30 | a8 | i8
            pha
                jsr ReadStick
                
                stz <@zp+0

                lda Stick0_
                cmp #$20
                if cc
                    lda <@zp+0
                    ora #Keys_Left
                    sta <@zp+0
                    jmp ScanKeys_x
                endif
                cmp #$e0
                if cs
                    lda <@zp+0
                    ora #Keys_Right
                    sta <@zp+0
                endif
                ScanKeys_x:

                lda Stick1_
                cmp #$20
                if cc
                    lda <@zp+0
                    ora #Keys_Up
                    sta <@zp+0
                    jmp ScanKeys_y
                endif
                cmp #$e0
                if cs
                    lda <@zp+0
                    ora #Keys_Down
                    sta <@zp+0
                endif
                ScanKeys_y:

                lda PB0
                and #$80
                if ne
                    lda <@zp+0
                    ora #Keys_Button0
                    sta <@zp+0
                endif

                lda PB1
                and #$80
                if ne
                    lda <@zp+0
                    ora #Keys_Button1
                    sta <@zp+0
                endif
            pla
        rep #$10 | i16
        ply | plx
    plp
rts
